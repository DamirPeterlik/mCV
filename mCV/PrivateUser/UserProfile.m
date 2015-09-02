//
//  UserProfile.m
//  mCV
//
//  Created by Damir Peterlik on 26/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import "UserProfile.h"
#import <AFNetworking/AFNetworking.h>
#import "APILayer.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "User.h"
#import "Configuration.h"

@interface UserProfile ()

@property (nonatomic,strong) Configuration *conf;

@end

@implementation UserProfile


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navItem.title =@"Profil korisnika";

    self.userImg.layer.borderWidth = 5.0f;
    self.userImg.layer.cornerRadius = 100;
    self.userImg.layer.masksToBounds = YES;
    self.userImg.layer.borderColor = [[UIColor colorWithRed:207.0f/255.0f green:226.0f/255.0f blue:243.0f/255.0f alpha:1.0] CGColor];
    
    self.activityIndicator.hidden = YES;
    [self.userImg reloadInputViews];

    [self getUserImage];
    [self.userImg reloadInputViews];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIButton *buttonDesign = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonDesign.frame = CGRectMake(10, 0, 30, 30);
    buttonDesign.layer.borderColor = [UIColor colorWithRed:207.0f/255.0f green:226.0f/255.0f blue:243.0f/255.0f alpha:1.0].CGColor;
    buttonDesign.layer.borderWidth = 1.0f;
    //za dizajniranje bordera za buton, istraziti ak bude vremena
    
    [self getUserImage];
    [self.userImg reloadInputViews];


}

- (IBAction)exitMCV:(id)sender
{
    exit(0);
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self getUserImage];
    [self.userImg reloadInputViews];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) getUserImage
{
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    
    KeychainItemWrapper *user = [[KeychainItemWrapper alloc] initWithIdentifier:@"token" accessGroup:nil];
    NSLog(@"\n User data - name - %@, ID - %@", [user objectForKey:(__bridge id)(kSecAttrAccount)], [user objectForKey:(__bridge id)(kSecValueData)]);
    NSString *userID = [user objectForKey:(__bridge id)(kSecValueData)];
    
    [APILayer getImageWithUserID:userID
                      withSucces:^(AFHTTPRequestOperation *operation, id responseObject) {
                          
                          
                          //______NOVO____PROBA____CONFIGURATION&USER_______//
                          
                          NSLog(@"----Proba!!!----");
                          
                        //  NSDictionary *userDict = responseObject[kApiResponseConstant];
                          NSError *error = nil;
                          User *userNew = [[User alloc]initWithDictionary:responseObject error:&error];
                          
                          NSLog(@"response prije slike: %@", responseObject);
                          
                          if(error==nil)
                          {
                              Configuration *config = [Configuration sharedConfiguration];
                              config.user = userNew;
                              
                              NSLog(@"Serialization OK! User: %@",userNew);
                          }
                          else{
                              NSLog(@"Serialization Failed!ERROR:%@",error);
                          }
                          
                          //______NOVO____PROBA____CONFIGURATION&USER_______//
                          
                          //gets user data, needs to have response of connection to get the data
                          [self getUserData];

                          NSLog(@"Success");
                          NSLog(@"Get image data - \n%@", responseObject);
                          
                          SDImageCache *imageCache = [SDImageCache sharedImageCache];
                          [imageCache clearMemory];
                          [imageCache clearDisk];
                          
                          NSString *imageLink = [responseObject objectForKey:@"imageLink"];
                          NSLog(@"Image link: %@", imageLink);
                          [self.userImg sd_setImageWithURL:[NSURL URLWithString:imageLink]];

                          NSLog(@"Ima linka za sliku");
                                   [self.activityIndicator stopAnimating];
                                   self.activityIndicator.hidesWhenStopped = YES;
                                   self.userImg.layer.borderWidth = 5.0f;
                                   self.userImg.layer.cornerRadius = 100;
                                   self.userImg.layer.masksToBounds = YES;
                                   self.userImg.layer.borderColor = [[UIColor colorWithRed:207.0f/255.0f green:226.0f/255.0f blue:243.0f/255.0f alpha:1.0] CGColor];
                           // else
                           //    {
                            //       NSLog(@"Nema linka slike");
                            //       [self.activityIndicator stopAnimating];
                                   self.activityIndicator.hidesWhenStopped = YES;
                            //   }

                          
                      } andFailure:^(NSError *error) {
                          
                          NSLog(@"Error %@", error);
                          [self.activityIndicator stopAnimating];
                          self.activityIndicator.hidesWhenStopped = YES;
                          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Greska!"
                                                                          message:@"Provjerite internet!"
                                                                         delegate:nil
                                                                cancelButtonTitle:@"Ok!"
                                                                otherButtonTitles:nil];
                          [alert show];
                          
                          
                      }];
    
    //[UIImage imageNamed:@"imgPlaceholder"]
    
}

-(void) getUserData
{
    self.conf = [Configuration sharedConfiguration];

    self.userForNameLbl.text = self.conf.user.userForeName;
    self.userSurNamelLbl.text = self.conf.user.userSurName;
    self.userEmailLbl.text = self.conf.user.email;
    self.userProfesionLbl.text = self.conf.user.userProfesion;
    self.userLocationLbl.text = self.conf.user.userLocation;

}


@end