//
//  Highscore+Methods.m
//  Genius
//
//  Created by Alisson L. Selistre on 12/11/14.
//  Copyright (c) 2014 Alisson. All rights reserved.
//

#import "AppDelegate.h"
#import "Highscore+Methods.h"

@implementation Highscore (Methods)

+ (BOOL)newScore:(NSNumber *)score withName:(NSString *)name
{
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    Highscore *entity = (Highscore *)[NSEntityDescription insertNewObjectForEntityForName:@"Highscore" inManagedObjectContext:context];
    
    entity.score = score;
    entity.name = name;

    NSError *error;
    return [context save:&error];
}

+ (NSArray *)highscoreList
{
    NSError *error;
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
        
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Highscore" inManagedObjectContext:context];
        
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects.count > 1)
    {
        fetchedObjects = [fetchedObjects sortedArrayUsingComparator:^NSComparisonResult(id a, id b)
                                {
                                    Highscore *s1 = (Highscore *)a;
                                    Highscore *s2 = (Highscore *)b;
                                    return [s2.score compare:s1.score];
                                }];
    }
    return fetchedObjects;
}

+ (BOOL)clearHighscore
{
    NSError *error;
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Highscore" inManagedObjectContext:context];
    [fetchRequest setIncludesPropertyValues:NO];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    for(NSManagedObject *item in fetchedObjects)
        [context deleteObject:item];
    
    return [context save:&error];
}

@end
