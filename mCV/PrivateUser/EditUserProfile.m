//
//  EditUserProfile.m
//  mCV
//
//  Created by Damir Peterlik on 02/09/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import "EditUserProfile.h"
#import <AFNetworking/AFNetworking.h>
#import "APILayer.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "User.h"
#import "Constants.h"
#import "Configuration.h"
#import "Helper.h"

@interface EditUserProfile ()

@end

@implementation EditUserProfile

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navItemEditProfile.title =@"Uredi profil";
    
    self.userImgEditProfile.layer.borderWidth = 5.0f;
    self.userImgEditProfile.layer.cornerRadius = 100;
    self.userImgEditProfile.layer.masksToBounds = YES;
    self.userImgEditProfile.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    self.activityIndicator.hidden = YES;
    
//    [self getUserImage];
    
    Configuration *config = [Configuration sharedConfiguration];
   // config.user = userNew;
    
   // self.conf = [Configuration sharedConfiguration];
    self.userForNameField.text = config.user.userForeName;
    self.userSurnameField.text = config.user.userSurName;
    self.userEmailField.text = config.user.email;
    self.userLocationField.text = config.user.userLocation;
    self.userProfesionField.text = config.user.userProfesion;

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.userForNameField resignFirstResponder];
    [self.userSurnameField resignFirstResponder];
    [self.userEmailField resignFirstResponder];
    [self.userProfesionField resignFirstResponder];
    [self.userLocationField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)uploadUserData:(id)sender
{
    NSLog(@"upload button klik!");
    
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    
    if (self.userForNameField.text.length >= 4
         && self.userSurnameField.text.length >= 4
          && self.userEmailField.text.length >= 4
           && self.userProfesionField.text.length >= 4
            && self.userLocationField.text.length >=4)
        
    {
        NSData *imageData = UIImageJPEGRepresentation(self.userImgEditProfile.image, 0.9);
        
        if (!imageData)
        {
            NSLog(@"Nema slike \n\n");
            UIAlertView *noImage = [[UIAlertView alloc] initWithTitle:@"Greska!"
                                                              message:@"Slika nije izabrana!"
                                                             delegate:nil cancelButtonTitle:@"Ok!"
                                                    otherButtonTitles:nil];
            [noImage show];
            [self.activityIndicator stopAnimating];
            self.activityIndicator.hidesWhenStopped = YES;
        }else
        {
        //izvrsi upload na server
        //podataka i slike

        [self pushUpload];
        }
        
    }else
    {
        UIAlertController *alert = [Helper returnAlerViewWithTitle:@"Greska!"
                                                       withMessage:@"Minimalan broj znakova 4!"
                                                     withOKhandler:^(UIAlertAction *action)
                                    {
                                        NSLog(@"Min 4 znaka!");
                                        NSLog(@"OK action pressed!");
                                    }];
        [self presentViewController:alert animated:YES completion:nil];
        [self.activityIndicator stopAnimating];
        self.activityIndicator.hidesWhenStopped = YES;
    }
    
}

- (IBAction)pickImage:(id)sender
{
    self.imagePickerEditProfile = [[UIImagePickerController alloc] init];
    self.imagePickerEditProfile.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePickerEditProfile.delegate = self;
    [self presentViewController:self.imagePickerEditProfile animated:YES completion:nil];
}

- (void)pushUpload
{
    NSData *imageData = UIImageJPEGRepresentation(self.userImgEditProfile.image, 0.9);

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
                                                 
                                                 self.userImgEditProfile.layer.borderWidth = 5.0f;
                                                 self.userImgEditProfile.layer.cornerRadius = 100;
                                                 self.userImgEditProfile.layer.masksToBounds = YES;
                                                 self.userImgEditProfile.layer.borderColor = [[UIColor colorWithRed:181.0f/255.0f green:244.0f/255.0f blue:234.0f/255.0f alpha:1.0] CGColor];
                                                 
                                                 [self registerToDB];

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

-(void) registerToDB
{
    //self.registerActivityIndicator.hidden = NO;
   // [self.registerActivityIndicator startAnimating];
    
    //1. nacin, povezivanje pomocu network library-a, AFNetworking, radi s blokovima, brzi, jednostavniji, efikasniji
    //nacin izveden nasljeđivanjem/povezivanjem klase APILayer
    
    KeychainItemWrapper *user = [[KeychainItemWrapper alloc] initWithIdentifier:@"token" accessGroup:nil];
    NSLog(@"\n User data - name - %@, ID - %@", [user objectForKey:(__bridge id)(kSecAttrAccount)], [user objectForKey:(__bridge id)(kSecValueData)]);
    
   // NSString *userName = [user objectForKey:(__bridge id)(kSecAttrAccount)];
    NSString *userID = [user objectForKey:(__bridge id)(kSecValueData)];
    
    [APILayer updateUserWithUserID:userID withUserForName:self.userForNameField.text withSurName:self.userSurnameField.text withemail:self.userEmailField.text withProfesion:self.userProfesionField.text andLocation:self.userLocationField.text
     
                            withSucces:^(AFHTTPRequestOperation *operation, id responseObject)
     
    {
         NSLog(@"Succes!");
         NSLog(@"Response UPDATE: %@", responseObject);
     /*
         KeychainItemWrapper *user = [[KeychainItemWrapper alloc] initWithIdentifier:@"token" accessGroup:nil];
         [user setObject:@"Myappstring" forKey: (__bridge id)kSecAttrService];
         [user setObject:userName forKey:(__bridge id)(kSecAttrAccount)];
         [user setObject:userID forKey:(__bridge id)(kSecValueData)];
         
         NSLog(@"\n User data - name - %@, ID - %@", [user objectForKey:(__bridge id)(kSecAttrAccount)], [user objectForKey:(__bridge id)(kSecValueData)]);
         */
         if ([[responseObject objectForKey:@"message"] isEqualToString:@"Success"])
         {
            // [self.registerActivityIndicator stopAnimating];
             //self.registerActivityIndicator.hidesWhenStopped = YES;
             
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Uspjeh!"
                                                             message:[NSString stringWithFormat:@"Korisink %@ azuriran, slika spremljena!", self.userForNameField.text]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok!"
                                                   otherButtonTitles:nil];
             [alert show];
             //[self segueTabBar];
         } else
         {
             UIAlertController *alert = [Helper returnAlerViewWithTitle:@"Greska!"
                                                            withMessage:@"Pokuštajte ponovno!"
                                                          withOKhandler:^(UIAlertAction *action)
                                         {
                                             NSLog(@"OK action pressed!");
                                             [self.activityIndicator stopAnimating];
                                             self.activityIndicator.hidesWhenStopped = YES;
                                         }];
             [self presentViewController:alert animated:YES completion:nil];
             
         }
         
     } andFailure:^(NSError *error) {
         NSLog(@"Failure!");
         NSLog(@"EROR: %@", error);
         UIAlertController *alert = [Helper returnAlerViewWithTitle:@"Greska!"
                                                        withMessage:@"Provjerite vezu s internetom!"
                                                      withOKhandler:^(UIAlertAction *action)
                                     {
                                         NSLog(@"OK action pressed!");
                                        [self.activityIndicator stopAnimating];
                                        self.activityIndicator.hidesWhenStopped = YES;
                                     }];
         [self presentViewController:alert animated:YES completion:nil];
     }];
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
    
    [self.userImgEditProfile setImage:img];
    [self.imagePickerEditProfile dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.navigationItem.title =nil;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
    self.tabBarController.navigationItem.rightBarButtonItems = nil;
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:NO completion:nil];
}


@end
