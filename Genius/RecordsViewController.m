//
//  RecordsViewController.m
//  Genius
//
//  Created by Alisson L. Selistre on 10/11/14.
//  Copyright (c) 2014 Alisson. All rights reserved.
//

#import "RecordsViewController.h"
#import "Highscore+Methods.h"

@interface RecordsViewController ()

@end

@implementation RecordsViewController
{
    NSArray *highscoreList;
}

#pragma mark - métodos da view

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.layer.cornerRadius = 7;
    self.tableView.layer.masksToBounds = YES;
    
    highscoreList = [Highscore highscoreList];
}

#pragma mark - métodos de ação

- (IBAction)buttonClearHighscorePressed:(id)sender
{
    if (highscoreList.count > 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"All highscore will be erased permanently" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Clear Highscore", nil];
        [alert show];
    }
}

#pragma mark - tableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return highscoreList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellScore" forIndexPath:indexPath];
    
    Highscore *record = highscoreList[indexPath.row];
    UILabel *labelName = (UILabel *)[cell viewWithTag:1];
    UILabel *labelScore = (UILabel *)[cell viewWithTag:2];
    
    labelName.text = record.name;
    labelScore.text = [record.score stringValue];
    
    return cell;
}

#pragma mark - alertView delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [Highscore clearHighscore];
        highscoreList = @[];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
