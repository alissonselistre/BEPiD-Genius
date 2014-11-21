//
//  RecordsViewController.h
//  Genius
//
//  Created by Alisson L. Selistre on 10/11/14.
//  Copyright (c) 2014 Alisson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordsViewController : UIViewController <UITableViewDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
