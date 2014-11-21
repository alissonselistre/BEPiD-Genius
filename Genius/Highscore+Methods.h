//
//  Highscore+Methods.h
//  Genius
//
//  Created by Alisson L. Selistre on 12/11/14.
//  Copyright (c) 2014 Alisson. All rights reserved.
//

#import "Highscore.h"

@interface Highscore (Methods)

+ (BOOL)newScore:(NSNumber *)score withName:(NSString *)name;
+ (NSArray *)highscoreList;
+ (BOOL)clearHighscore;

@end
