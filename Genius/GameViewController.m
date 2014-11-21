//
//  GameViewController.m
//  Genius
//
//  Created by Alisson L. Selistre on 10/11/14.
//  Copyright (c) 2014 Alisson. All rights reserved.
//

#import "GameViewController.h"
#import "Highscore+Methods.h"

@interface GameViewController ()

@end

enum colors
{
    green = 1,
    red = 2,
    blue = 3,
    orange = 4
};

enum messages
{
    sucess = 0,
    playerTurn = 1,
    start = 2,
    gameOver = 3,
    score = 4,
    start2 = 5,
    saved = 6
};
#define message(messages) [@[@"Good!",@"Your\nturn..",@"START",@"GAME OVER",@"Score\n",@"Go!",@"Score\nsaved"] objectAtIndex:messages]

@implementation GameViewController
{
    NSCharacterSet *allowedCharacters;
    NSMutableArray *sequenceArray;
    int sequenceIndex;
}

#pragma mark - métodos da view

- (void)viewDidLoad {
    [super viewDidLoad];

    allowedCharacters = [[NSCharacterSet letterCharacterSet] invertedSet];
    
    self.backgroundView.layer.cornerRadius = self.backgroundView.bounds.size.width/2;
    self.backgroundView.layer.masksToBounds = YES;
    self.buttonStart.layer.cornerRadius = self.buttonStart.bounds.size.width/2;
    self.buttonStart.layer.masksToBounds = YES;
    self.buttonStart.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.buttonStart.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self prepareToStart];
}

#pragma mark - métodos de ação

- (IBAction)buttonStart:(UIButton *)button {
    
    [button setUserInteractionEnabled:NO];
    
    [self countdownToStart:[NSNumber numberWithInteger:3]];
}

- (IBAction)buttonSequenceTouched:(UIButton *)button {

    [self setButtonsInteractionEnabled:NO];

    [UIView animateWithDuration:0.25 animations:^{
        
        [button setAlpha:1.0];

    }completion:^(BOOL finished){
        
        [UIView animateWithDuration:0.25 animations:^{
            
            [button setAlpha:0.4];
            
        }completion:^(BOOL finished){
            
            //executa os testes depois da animação do botão
            if (sequenceIndex < sequenceArray.count)
            {
                int sequenceColor = [sequenceArray[sequenceIndex] intValue];
                
                if (button.tag == sequenceColor)
                {
                    if (sequenceIndex == sequenceArray.count-1)
                    {
                        [self setButtonsInteractionEnabled:NO];
                        [self.buttonStart setTitle:message(sucess) forState:UIControlStateNormal];
                        [self shineAllButtons];
                        
                        [self performSelector:@selector(executeSequence:) withObject:[NSNumber numberWithInt:0] afterDelay:1.5];
                    }
                    else
                    {
                        sequenceIndex = sequenceIndex+1;
                        [self setButtonsInteractionEnabled:YES];
                    }
                }
                else
                {
                    [self finishGame];
                }
            }
            
        }];
        
    }];
}

#pragma mark - métodos de controle

- (void)setButtonsInteractionEnabled:(BOOL)status
{
    [self.buttonRed setUserInteractionEnabled:status];
    [self.buttonBlue setUserInteractionEnabled:status];
    [self.buttonGreen setUserInteractionEnabled:status];
    [self.buttonOrange setUserInteractionEnabled:status];
}

- (void)prepareToStart
{
    sequenceArray = [[NSMutableArray alloc] init];
    [self setButtonsInteractionEnabled:NO];
    [self.buttonStart setUserInteractionEnabled:YES];
    [self.buttonStart setTitle:message(start) forState:UIControlStateNormal];
}

-(void)executeSequence:(NSNumber *)actual
{
    int sequence = [actual intValue];
    
    if (sequence == 0)
        [self.buttonStart setTitle:@"" forState:UIControlStateNormal];

    if (sequence < sequenceArray.count)
    {
        [self showSequenceWithColor:sequenceArray[sequence]];
        
        int next = sequence+1;
        [self performSelector:@selector(executeSequence:) withObject:[NSNumber numberWithInt:next] afterDelay:1];
    }
    else
    {
        NSNumber *randomColor = [self randomColor];
        [sequenceArray addObject:randomColor];
        [self showSequenceWithColor:randomColor];

        [self performSelector:@selector(playerTurn) withObject:nil afterDelay:1];
    }
}

-(void)playerTurn
{
    sequenceIndex = 0;
    
    [self.buttonStart setTitle:message(playerTurn) forState:UIControlStateNormal];
    [self setButtonsInteractionEnabled:YES];
}

#pragma mark - métodos de animação

- (void)countdownToStart:(NSNumber *)value
{
    if ([value integerValue] >= 0)
    {
        NSString *text = [NSString stringWithFormat:@"%@",value];
        
        if ([value integerValue] == 0)
            text = message(start2);
        
        [self.buttonStart setTitle:text forState:UIControlStateNormal];

        NSInteger newValue = [value integerValue]-1;
        
        [self performSelector:@selector(countdownToStart:) withObject:[NSNumber numberWithInteger:newValue] afterDelay:1];
    }
    else
    {
        [self.buttonStart setTitle:@"" forState:UIControlStateNormal];
        [self executeSequence:[NSNumber numberWithInt:0]];
    }
}

- (void)showSequenceWithColor:(NSNumber *)randomColor
{
    int color = [randomColor intValue];
    switch (color)
    {
        case green:
            
            [self shineOnButton:self.buttonGreen];
            break;
            
        case red:
            
            [self shineOnButton:self.buttonRed];
            break;
            
        case blue:
            
            [self shineOnButton:self.buttonBlue];
            break;
            
        case orange:
            
            [self shineOnButton:self.buttonOrange];
            break;
            
        default:
            
            break;
    }
}

- (void)shineOnButton:(UIButton *)button
{
    [UIView animateWithDuration:0.5 animations:^{
        
        [button setAlpha:1.0];
        
    }completion:^(BOOL finished){
        
        [UIView animateWithDuration:0.5 animations:^{
            
            [button setAlpha:0.4];
            
        }];

    }];
}

- (void)finishGame
{
    [self.buttonStart setTitle:message(gameOver) forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [self.view setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:122.0f/255.0f blue:122.0f/255.0f alpha:1.0f]];
        
    }completion:^(BOOL finished){
        
        [UIView animateWithDuration:0.5 animations:^{
            
            [self.view setBackgroundColor:[UIColor whiteColor]];
            
        }completion:^(BOOL finished){

            if (sequenceArray.count > 1)
            {
                [self showAlertToNewRecord];
            }
            else
            {
                [self performSelector:@selector(prepareToStart) withObject:nil afterDelay:1];
            }

            NSNumber *newScore = [NSNumber numberWithInteger:sequenceArray.count-1];
            NSString *messageScore = [NSString stringWithFormat:@"%@%@",message(score),newScore];
            [self.buttonStart setTitle:messageScore forState:UIControlStateNormal];
            
        }];

    }];
}

- (void)shineAllButtons
{
    [UIView animateWithDuration:0.5 animations:^{
        
        [self.buttonRed setAlpha:1.0];
        [self.buttonBlue setAlpha:1.0];
        [self.buttonGreen setAlpha:1.0];
        [self.buttonOrange setAlpha:1.0];
        
    }completion:^(BOOL finished){
        
        [UIView animateWithDuration:0.5 animations:^{
            
            [self.buttonRed setAlpha:0.4];
            [self.buttonBlue setAlpha:0.4];
            [self.buttonGreen setAlpha:0.4];
            [self.buttonOrange setAlpha:0.4];
            
        }];
        
    }];
}

#pragma mark - alertView delegate and methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        UITextField *textfield = [alertView textFieldAtIndex:0];
        NSString *name = textfield.text.length > 0 ? textfield.text : @"a player";
        NSNumber *score = [NSNumber numberWithInteger:sequenceArray.count-1];
        [Highscore newScore:score withName:name];
        
        [self.buttonStart setTitle:message(saved) forState:UIControlStateNormal];
    }
    
    [self performSelector:@selector(prepareToStart) withObject:nil afterDelay:1.5];
}

-(void)showAlertToNewRecord
{
    NSString *alertTitle = [NSString stringWithFormat:@"Your score is %u.",sequenceArray.count-1];
    UIAlertView *alertNewRecord = [[UIAlertView alloc] initWithTitle:alertTitle message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Register Record", nil];
    [alertNewRecord setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    UITextField *textfield = [alertNewRecord textFieldAtIndex:0];
    [textfield setTextAlignment:NSTextAlignmentCenter];
    [textfield setAutocapitalizationType:UITextAutocapitalizationTypeWords];
    [textfield setDelegate:self];
    textfield.placeholder = @"Insert your name";
    
    [alertNewRecord show];
}

#pragma mark - textfield delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)characters
{
    return ([characters rangeOfCharacterFromSet:allowedCharacters].location == NSNotFound);
}

#pragma mark - utilitários

- (NSNumber *)randomColor
{
    int randomNumber = 1+arc4random_uniform(4);
    return [NSNumber numberWithInt:randomNumber];
}

@end
