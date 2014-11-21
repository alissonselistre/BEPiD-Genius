//
//  GameViewController.h
//  Genius
//
//  Created by Alisson L. Selistre on 10/11/14.
//  Copyright (c) 2014 Alisson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController <UIAlertViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *buttonRed;
@property (weak, nonatomic) IBOutlet UIButton *buttonBlue;
@property (weak, nonatomic) IBOutlet UIButton *buttonOrange;
@property (weak, nonatomic) IBOutlet UIButton *buttonGreen;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIButton *buttonStart;

@end
