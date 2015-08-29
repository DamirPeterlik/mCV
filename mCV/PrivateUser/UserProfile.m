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

@end

@implementation UserProfile

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.userImg.layer.borderWidth = 5.0f;
    self.userImg.layer.cornerRadius = 100;
    self.userImg.layer.masksToBounds = YES;
    self.userImg.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    self.activityIndicator.hidden = YES;
    
    [self getUserImage];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.tabBarController.navigationItem.title =@"User profile";
    
    UIButton *buttonDesign = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonDesign.frame = CGRectMake(10, 0, 30, 30);
    buttonDesign.layer.borderColor = [UIColor blueColor].CGColor;
    buttonDesign.layer.borderWidth = 1.0f;
    //za dizajniranje bordera za buton, istraziti ak bude vremena
    
    //EXIT tab bar buton
    UIBarButtonItem *exit = [[UIBarButtonItem alloc] initWithTitle:@"Exit"
                                                             style:UIBarButtonItemStyleDone
                                                            target:self
                                                            action:@selector(exitBarBtnItem:)];
    
    self.tabBarController.navigationItem.leftBarButtonItem = exit;
    
    //pick image bar buton
    UIBarButtonItem *pickImage = [[UIBarButtonItem alloc] initWithTitle:@"Pick"
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(pushPick:)];
    
    UIBarButtonItem *uploadImage = [[UIBarButtonItem alloc] initWithTitle:@"Upload"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(pushUpload:)];
    
    NSArray *tabBarButtonArray = [[NSArray alloc] initWithObjects:pickImage, uploadImage, nil];
    self.tabBarController.navigationItem.rightBarButtonItems = tabBarButtonArray;
    
}

- (void)exitBarBtnItem:(id)sender
{
    exit(0);
}

- (void)pushPick:(id)sender
{
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.delegate = self;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)pushUpload:(id)sender
{
    NSData *imageData = UIImageJPEGRepresentation(self.userImg.image, 0.9);
    
    if (!imageData)
    {
        NSLog(@"Nema slike \n\n");
        UIAlertView *noImage = [[UIAlertView alloc] initWithTitle:@"Greska!"
                                                          message:@"Slika nije izabrana!"
                                                         delegate:nil cancelButtonTitle:@"Ok!"
                                                otherButtonTitles:nil];
        [noImage show];
    }else{
        NSLog(@"Ima slike \n");
        
        self.activityIndicator.hidden = NO;
        [self.activityIndicator startAnimating];
        
        KeychainItemWrapper *user = [[KeychainItemWrapper alloc] initWithIdentifier:@"token" accessGroup:nil];
        NSLog(@"\n User data - name - %@, ID - %@", [user objectForKey:(__bridge id)(kSecAttrAccount)], [user objectForKey:(__bridge id)(kSecValueData)]);
        
        NSString *userName = [user objectForKey:(__bridge id)(kSecAttrAccount)];
        NSString *userID = [user objectForKey:(__bridge id)(kSecValueData)];
        
        NSString *url = [Helper getValueFromPlistForKey:kConfigAPIPostImageLinkToDB];
        NSString *stringUrl = [NSString stringWithFormat:url,userID,userName,userID];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        AFHTTPRequestOperation *operation = [manager POST:stringUrl parameters:nil
                                constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                             {
                                                 [formData appendPartWithFileData:imageData
                                                                             name:@"userfile"
                                                                         fileName:@"userfile"
                                                                         mimeType:@"image/jpeg"];
                                                 //userfile - kako smo nazvali u php sliku
                                             } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                 NSLog(@"\n\nResponse: %@,\n**** %@\n\n", responseObject, operation.responseString.description);
                                                 [self.activityIndicator performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:YES];
                                                 
                                                 [self.activityIndicator stopAnimating];
                                                 self.activityIndicator.hidesWhenStopped = YES;
                                                 
                                                 UIAlertView *imageOK = [[UIAlertView alloc] initWithTitle:@"Bravo!"
                                                                                                   message:@"Slika je spremljena!"
                                                                                                  delegate:self
                                                                                         cancelButtonTitle:@"Ok!"
                                                                                         otherButtonTitles:nil];
                                                 
                                                 [imageOK show];
                                                 
                                                 self.userImg.layer.borderWidth = 5.0f;
                                                 self.userImg.layer.cornerRadius = 100;
                                                 self.userImg.layer.masksToBounds = YES;
                                                 self.userImg.layer.borderColor = [[UIColor blueColor] CGColor];
                                                 
                                             }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                 NSLog(@"\n\nError for failure: %@,\n**** %@\n\n", operation.responseString, error);
                                                 [self.activityIndicator performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:YES];
                                                 
                                                 [self.activityIndicator stopAnimating];
                                                 self.activityIndicator.hidesWhenStopped = YES;
                                                 
                                                 UIAlertView *error1 = [[UIAlertView alloc] initWithTitle:@"Greska!"
                                                                                                  message:@"Provjerite internet!"
                                                                                                 delegate:self
                                                                                        cancelButtonTitle:@"Ok!"
                                                                                        otherButtonTitles:nil];
                                                 [error1 show];
                                             }];
        [operation start];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (!picker)
    {
        NSLog(@"Nema slike!");
    }
    NSLog(@"Ima slike");
    NSData *dataImage = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"],1);
    UIImage *img = [[UIImage alloc] initWithData:dataImage];
    
    [self.userImg setImage:img];
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.navigationItem.title =nil;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
    self.tabBarController.navigationItem.rightBarButtonItems = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:NO completion:nil];
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
                          
                          NSLog(@"Success");
                          NSLog(@"Get image data - \n%@", responseObject);
                          
                          NSString *imageLink = [responseObject objectForKey:@"imageLink"];
                          NSLog(@"Image link: %@", imageLink);
                          [self.userImg sd_setImageWithURL:[NSURL URLWithString:imageLink]
                                          placeholderImage:nil
                                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
                           {
                               
                               if(!error)
                               {
                                   NSLog(@"Ima linka za sliku");
                                   [self.activityIndicator stopAnimating];
                                   self.activityIndicator.hidesWhenStopped = YES;
                                   self.userImg.layer.borderWidth = 5.0f;
                                   self.userImg.layer.cornerRadius = 100;
                                   self.userImg.layer.masksToBounds = YES;
                                   self.userImg.layer.borderColor = [[UIColor blueColor] CGColor];
                               }
                               else
                               {
                                   NSLog(@"Nema linka slike");
                                   [self.activityIndicator stopAnimating];
                                   self.activityIndicator.hidesWhenStopped = YES;
                               }
                               
                               
                           }];
                          
                      } andFailure:^(NSError *error) {
                          
                          NSLog(@"Error %@", error);
                          [self.activityIndicator stopAnimating];
                          self.activityIndicator.hidesWhenStopped = YES;
                          
                          
                          
                      }];
    
    //[UIImage imageNamed:@"imgPlaceholder"]
    
}

@end