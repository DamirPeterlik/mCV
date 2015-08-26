//
//  UserProfil.h
//  mCV
//
//  Created by Damir Peterlik on 26/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"

@interface UserProfil : UITabBarController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UINavigationItem *tbNavTitle;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) IBOutlet UIImageView *userImg;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) IBOutlet UILabel *regUserIDlbl;
@property (strong, nonatomic) IBOutlet UILabel *logUserIDlbl;

@end
