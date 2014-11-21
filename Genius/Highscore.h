//
//  Highscore.h
//  Genius
//
//  Created by Alisson L. Selistre on 12/11/14.
//  Copyright (c) 2014 Alisson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Highscore : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * score;

@end
