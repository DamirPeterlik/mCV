//
//  UserProfile.h
//  mCV
//
//  Created by Damir Peterlik on 26/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"
#import "Helper.h"
#import "Constants.h"

@interface UserProfile : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) IBOutlet UIImageView *userImg;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) IBOutlet UILabel *userForNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *userSurNamelLbl;
@property (strong, nonatomic) IBOutlet UILabel *userEmailLbl;
@property (strong, nonatomic) IBOutlet UILabel *userProfesionLbl;
@property (strong, nonatomic) IBOutlet UILabel *userLocationLbl;

- (NSString *)magicString;

@end
