//
//  EditUserProfile.h
//  mCV
//
//  Created by Damir Peterlik on 02/09/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"
#import "Helper.h"
#import "Constants.h"

@interface EditUserProfile : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UINavigationItem *navItemEditProfile;
@property (strong, nonatomic) UIImagePickerController *imagePickerEditProfile;
@property (strong, nonatomic) IBOutlet UIImageView *userImgEditProfile;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) IBOutlet UITextField *userForNameField;
@property (strong, nonatomic) IBOutlet UITextField *userSurnameField;
@property (strong, nonatomic) IBOutlet UITextField *userEmailField;
@property (strong, nonatomic) IBOutlet UITextField *userProfesionField;
@property (strong, nonatomic) IBOutlet UITextField *userLocationField;

- (IBAction)uploadUserData:(id)sender;
- (IBAction)pickImage:(id)sender;

@end
