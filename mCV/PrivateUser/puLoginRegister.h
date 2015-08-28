//
//  puLoginRegister.h
//  mCV
//
//  Created by Damir Peterlik on 25/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"
#import "Helper.h"


@interface puLoginRegister : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControlLoginRegister;

//LOGIN
@property (strong, nonatomic) IBOutlet UIView *loginView;
@property (strong, nonatomic) IBOutlet UITextField *userNameFieldLogin;
@property (strong, nonatomic) IBOutlet UITextField *passFieldLogin;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loginActivityIndicator;
@property (strong, nonatomic) IBOutlet UISwitch *switchRememberMe;

//REGISTER
@property (strong, nonatomic) IBOutlet UIView *registerView;
@property (strong, nonatomic) IBOutlet UITextField *userNameFieldRegister;
@property (strong, nonatomic) IBOutlet UITextField *emailFieldRegister;
@property (strong, nonatomic) IBOutlet UITextField *passFieldRegister;
@property (strong, nonatomic) IBOutlet UITextField *reEnterPassFieldRegister;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *registerActivityIndicator;

//ACTIONS
- (IBAction)loginTransitionTabBar:(id)sender;
- (IBAction)registerTransitionTabBar:(id)sender;
- (IBAction)segmentControlValueChanged:(id)sender;
- (IBAction)switchRememberMeAction:(id)sender;

@end
