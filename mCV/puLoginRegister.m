//
//  puLoginRegister.m
//  mCV
//
//  Created by Damir Peterlik on 25/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import "puLoginRegister.h"
#import "APILayer.h"
#import "Constants.h"


@interface puLoginRegister ()

@end

@implementation puLoginRegister

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"mCV";
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"Pick user";
    self.navigationController.navigationBar.topItem.backBarButtonItem = barButton;
    
    self.registerActivityIndicator.hidden = YES;
    self.loginActivityIndicator.hidden = YES;
    
    
    self.userNameFieldRegister.delegate = self;
    self.passFieldRegister.delegate = self;
    self.userNameFieldLogin.delegate = self;
    self.passFieldLogin.delegate = self;
    
    self.loginView.hidden = NO;
    self.registerView.hidden = YES;
    self.navigationItem.title = @"Login";
    
    // Do any additional setup after loading the view.
    
    [self switchSavedData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.userNameFieldLogin resignFirstResponder];
    [self.passFieldLogin resignFirstResponder];
    [self.userNameFieldRegister resignFirstResponder];
    [self.emailFieldRegister resignFirstResponder];
    [self.passFieldRegister resignFirstResponder];
    [self.reEnterPassFieldRegister resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - Actions

- (IBAction)loginTransitionTabBar:(id)sender
{
    NSLog(@"Login button klik!");
    
    if ([self.userNameFieldLogin.text isEqualToString:@""] || [self.passFieldLogin.text isEqualToString:@""])
    {
        UIAlertController *alert = [Helper returnAlerViewWithTitle:@"Greska!"
                                                       withMessage:@"Popunite polja!"
                                                     withOKhandler:^(UIAlertAction *action)
                                    {
                                        NSLog(@"Prazna polja!");
                                        NSLog(@"OK action pressed!");
                                    }];
        
        [self presentViewController:alert animated:YES completion:nil];
    }else
        {
            self.registerActivityIndicator.hidden = NO;
            [self.registerActivityIndicator startAnimating];
            
            [APILayer loginUserWithUserName:self.userNameFieldLogin.text andPassword:self.passFieldLogin.text withSucces:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 NSLog(@"Succes!");
                 NSLog(@"Response: %@", responseObject);
                 
                 if ([[responseObject objectForKey:@"message"] isEqualToString:@"Success"])
                 {
                     UIAlertController *alert = [Helper returnAlerViewWithTitle:@"Ok!"
                                                                    withMessage:@"Ulogirani ste!"
                                                                  withOKhandler:^(UIAlertAction *action){
                                                                      NSLog(@"OK action pressed!");
                                                        [self.registerActivityIndicator stopAnimating];
                                                        self.registerActivityIndicator.hidesWhenStopped = YES;
                                                                  }];
                     [self presentViewController:alert animated:YES completion:nil];
                     
                 } else
                 {
                     UIAlertController *alert = [Helper returnAlerViewWithTitle:@"Greska!"
                                                                    withMessage:@"Krivi podatci!"
                                                                  withOKhandler:^(UIAlertAction *action)
                                                 {
                                                     NSLog(@"OK action pressed!");
                                                     [self.registerActivityIndicator stopAnimating];
                                                     self.registerActivityIndicator.hidesWhenStopped = YES;
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
                                                 [self.registerActivityIndicator stopAnimating];
                                                 self.registerActivityIndicator.hidesWhenStopped = YES;
                                             }];
                 [self presentViewController:alert animated:YES completion:nil];
             }];
        }
}

- (IBAction)registerTransitionTabBar:(id)sender
{
    NSLog(@"Register button klik!");
    
    if (self.emailFieldRegister.text.length >= 4 && self.userNameFieldRegister.text.length >= 4 && self.passFieldRegister.text.length >= 4 && self.reEnterPassFieldRegister.text.length >= 4)
    {
        [self checkPasswordsMatchAndRegOnDB];

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
        }

}

- (void) checkPasswordsMatchAndRegOnDB
{
    
    if ([self.passFieldRegister.text isEqualToString: self.reEnterPassFieldRegister.text])
    {
        NSLog(@"Lozinke se podudaraju!");
        [self registerToDB];
    }
    else
    {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Greška!"
                                                        message:@"Lozinke se ne podudaraju"
                                                       delegate:self cancelButtonTitle:@"Ok!"
                                              otherButtonTitles:nil];
        [error show];
    }
}

-(void) registerToDB
{
    self.registerActivityIndicator.hidden = NO;
    [self.registerActivityIndicator startAnimating];
    
    //1. nacin, povezivanje pomocu network library-a, AFNetworking, radi s blokovima, brzi, jednostavniji, efikasniji
    //nacin izveden nasljeđivanjem/povezivanjem klase APILayer
    
    [APILayer registerUserWithUserName:self.userNameFieldRegister.text withemail:self.emailFieldRegister.text andPassword:self.passFieldRegister.text
                            withSucces:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Succes!");
         NSLog(@"Response: %@", responseObject);
         
         if ([[responseObject objectForKey:@"message"] isEqualToString:@"Success"])
         {
             UIAlertController *alert = [Helper returnAlerViewWithTitle:@"Ok!"
                                                            withMessage:@"Korisnik dodan!"
                                                          withOKhandler:^(UIAlertAction *action){
                                                              NSLog(@"OK action pressed!");
                                                              [self.registerActivityIndicator stopAnimating];
                                                              self.registerActivityIndicator.hidesWhenStopped = YES;
                                                          }];
             [self presentViewController:alert animated:YES completion:nil];
             
         } else
         {
             UIAlertController *alert = [Helper returnAlerViewWithTitle:@"Greska!"
                                                            withMessage:@"Pokuštajte drugo korisnicko ime!"
                                                          withOKhandler:^(UIAlertAction *action)
                                         {
                                             NSLog(@"OK action pressed!");
                                             [self.registerActivityIndicator stopAnimating];
                                             self.registerActivityIndicator.hidesWhenStopped = YES;
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
                                         [self.registerActivityIndicator stopAnimating];
                                         self.registerActivityIndicator.hidesWhenStopped = YES;
                                     }];
         [self presentViewController:alert animated:YES completion:nil];
     }];
}

- (IBAction)segmentControlValueChanged:(id)sender
{
    switch (self.segmentControlLoginRegister.selectedSegmentIndex) {
            
        case 0:
            self.loginView.hidden = NO;
            self.registerView.hidden = YES;
            
            if (self.segmentControlLoginRegister.selectedSegmentIndex == 0)
            {
                NSLog(@"Segment LOGIN picked!");
                self.navigationItem.title = @"Login proces";
            }
            break;
        case 1:
            self.loginView.hidden = YES;
            self.registerView.hidden = NO;
            
            if (self.segmentControlLoginRegister.selectedSegmentIndex == 1)
            {
                NSLog(@"Segment REGISTER picked!");
                self.navigationItem.title = @"Registration proces";
            }
            break;
        default:
            break;
    }
}

- (IBAction)switchRememberMeAction:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([self.userNameFieldLogin.text isEqualToString:@""] || [self.passFieldLogin.text isEqualToString:@""])
    {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                        message:@"Fill fields!"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok!"
                                              otherButtonTitles:nil];
        self.switchRememberMe.on = NO;
        [error show];
    }//if
    else
    {
        if (self.switchRememberMe.tag == 0)
        {
            if (self.switchRememberMe.on == 1)
            {
                [defaults setObject:@"ON" forKey:@"keyName"];
                
                KeychainItemWrapper *keychainWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"UN_PASS" accessGroup:nil];
                [keychainWrapper setObject:self.userNameFieldLogin.text forKey:(__bridge id)(kSecAttrAccount)];
                [keychainWrapper setObject:self.passFieldLogin.text forKey:(__bridge id)(kSecValueData)];
                
                NSLog(@"\n___SAVED!___ \nusername_pass: %@,%@", [keychainWrapper objectForKey:(__bridge id)(kSecAttrAccount)],[keychainWrapper objectForKey:(__bridge id)(kSecValueData)]);
                UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Good!"
                                                                message:@"Saved!"
                                                               delegate:self
                                                      cancelButtonTitle:@"Ok!"
                                                      otherButtonTitles:nil];
                [error show];
                [defaults setObject:self.userNameFieldLogin.text forKey:@"username"];
                [defaults setObject:self.passFieldLogin.text forKey:@"password"];
                //spremanje u NSUD
                
                [defaults setBool:YES forKey:@"registered"];
                [defaults synchronize];
            }
            else if (self.switchRememberMe.on == 0)
            {
                [defaults setObject:@"OFF" forKey:@"keyName"];
                self.userNameFieldLogin.text = nil;
                self.passFieldLogin.text = nil;
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
                
                NSLog(@"\nObrisani su podatci!");
                KeychainItemWrapper *keychainWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"UN_PASS" accessGroup:nil];
                
                [keychainWrapper resetKeychainItem];
                NSLog(@"\n___OBRISANO!___ \n\nusername_pass: %@,%@", [keychainWrapper objectForKey:(__bridge id)(kSecAttrAccount)],[keychainWrapper objectForKey:(__bridge id)(kSecValueData)]);
            }//else if
        }//if
        [defaults synchronize];
    }//else

}

- (void) switchSavedData
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.userNameFieldLogin.text = [defaults objectForKey:@"username"];
    self.passFieldLogin.text = [defaults objectForKey:@"password"];
    //podatke koje upisujemo u user&pass field se spremaju u NSUD pod kljuceve username i pass
    
    if ([[defaults stringForKey:@"keyName"] isEqualToString:@"ON"])
    {
        self.switchRememberMe.on = YES;
    }
    else if([[defaults stringForKey:@"keyName"] isEqualToString:@"OFF"])
    {
        self.switchRememberMe.on = NO;
    }
    // Do any additional setup after loading the view.
    
    KeychainItemWrapper *keychainWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"UN_PASS" accessGroup:nil];
    NSLog(@"Saved data - user - %@, pass - %@", [keychainWrapper objectForKey:
                                                 (__bridge id)(kSecAttrAccount)],[keychainWrapper objectForKey:
                                                                                  (__bridge id)(kSecValueData)]);
 
}

@end


//2. nacin, pozivanje asinkrone funkcije bez library-a
/*
 [self postUserName:self.userNameFieldRegister.text
 withMail:self.emailFieldRegister.text
 withPass:self.passFieldRegister.text];
 
 NSLog(@"END! %@", self.userNameFieldRegister.text);
 */

/*
 3. nacin, slican 2. nacinu, ali bez povezivanje drugih klasa
 
 NSString *apiUrlPart = [Helper getValueFromPlistForKey:kConfigAPIRegisterURL];
 AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
 NSString *phpURL = [NSString stringWithFormat:apiUrlPart, self.emailFieldRegister.text, self.userNameFieldRegister.text, self.passFieldRegister.text];
 manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
 
 [manager POST:phpURL
 parameters:nil
 success:^(AFHTTPRequestOperation *operation, id responseObject)
 {
 NSLog(@"%@", responseObject);
 }
 failure:^(AFHTTPRequestOperation *operation, NSError *error)
 {
 NSLog(@"Error: %@", error);
 }];
 
 
 #define userName @"userName"
 #define email @"email"
 #define pass @"password"
 //#define passCheck @"Lozinka_provjera"
 
 -(void) postUserName:(NSString*) userNameReg withMail:(NSString*) emailReg withPass:(NSString*) passwordReg
 {
 
 NSMutableString *postString= [NSMutableString stringWithString:@"http://probaairmcv.site40.net/mCV/new1.php"];
 //postString je http://www.mcv.herobo.com/proba2reg.php?Korisnicko_ime=Dado znaci php skripta + uneseno kor ime u text fild
 
 [postString appendString:[NSString stringWithFormat:@"?%@=%@", userName, userNameReg]];
 [postString appendString:[NSString stringWithFormat:@"&%@=%@", email, emailReg]];
 [postString appendString:[NSString stringWithFormat:@"&%@=%@", pass, passwordReg]];
 //[postString appendString:[NSString stringWithFormat:@"&%@=%@", passCheck, lozinka_check]];
 [postString setString:[postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
 
 //------------------------------
 
 NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:postString]];
 
 [request setHTTPMethod:@"POST"];
 
 //regCon = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
 //radi i bez regCon=... ali nekad krivi odg iz phpa kupi, pa bolje bez
 
 NSLog(@"Upis se salje!");
 NSMutableData *body=[NSMutableData data];
 [request setHTTPBody:body];
 //radi ispravno i s iznad dvije naredbe i bez
 //NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:&err];
 
 [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
 {
 
 NSError* error;
 NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
 NSLog(@"json - %@", json);
 
 NSString *userRegisterData = [json objectForKey:@"message"];
 NSLog(@"userRegisterData - %@", userRegisterData);
 
 if (!connectionError && [data length] > 0)
 {
 NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
 NSLog(@"Response string jedan = %@", responseString);
 
 if ([[json objectForKey:@"message"] isEqualToString:@"Success"])
 {
 NSLog(@"Dodan!");
 UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Uspjeh!"
 message:@"Registracija uspješna!"
 delegate:self cancelButtonTitle:@"Ok!"
 otherButtonTitles:nil];
 [error show];
 
 }//if
 else
 {
 UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Greška!"
 message:@"Registracija neuspješna, pokušajte drugačije korisničko ime!"
 delegate:self
 cancelButtonTitle:@"Ok!"
 otherButtonTitles:nil];
 [error show];
 NSLog(@"Nije dodan!");
 }//else
 }//if (!connectionError && [data length] > 0)
 [_registerActivityIndicator performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:YES];
 
 }];
 //}//if (kor_ime != nil && mail != nil && lozinka != nil && lozinka_check != nil)
 }//void
 */
