//
//  UserProfil.m
//  mCV
//
//  Created by Damir Peterlik on 26/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import "UserProfil.h"
#import <AFNetworking/AFNetworking.h>

@interface UserProfil ()

@end

@implementation UserProfil

- (void)viewDidLoad {
    [super viewDidLoad];

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
            
            self.activityIndicator.hidden = YES;
            [self.activityIndicator startAnimating];
            self.activityIndicator.hidesWhenStopped = YES;
        
        KeychainItemWrapper *user = [[KeychainItemWrapper alloc] initWithIdentifier:@"token" accessGroup:nil];
        
        NSLog(@"\n User data - name - %@, ID - %@", [user objectForKey:(__bridge id)(kSecAttrAccount)], [user objectForKey:(__bridge id)(kSecValueData)]);
        
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            
            NSString *phpURL = [NSString stringWithFormat:
                                @"http://probaairmcv.site40.net/mCV/userImages/proba6.php?userImageNameID=%@_%@.jpg", [user objectForKey:(__bridge id)(kSecAttrAccount)], [user objectForKey:(__bridge id)(kSecValueData)]];
            
            AFHTTPRequestOperation *operation = [manager POST:phpURL parameters:nil
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
                                                     
                                        UIAlertView *imageOK = [[UIAlertView alloc] initWithTitle:@"Bravo!" message:@"Slika je spremljena!" delegate:self cancelButtonTitle:@"Ok!" otherButtonTitles:nil];
                                                     
                                        [imageOK show];
                                                     
                                        self.userImg.layer.borderWidth = 5.0f;
                                        self.userImg.layer.cornerRadius = 100;
                                        self.userImg.layer.masksToBounds = YES;
                                        self.userImg.layer.borderColor = [[UIColor blueColor] CGColor];
                                                     
                                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                        NSLog(@"\n\nError for failure: %@,\n**** %@\n\n", operation.responseString, error);
                                        [self.activityIndicator performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:YES];
                                                     
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:NO completion:nil];
}

@end
