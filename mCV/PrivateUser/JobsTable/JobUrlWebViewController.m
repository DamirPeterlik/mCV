//
//  JobUrlWebViewController.m
//  mCV
//
//  Created by Damir Peterlik on 01/09/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import "JobUrlWebViewController.h"
#import "JobData.h"
//#import "JobDetailTableViewController.h"


@interface JobUrlWebViewController ()

@end

@implementation JobUrlWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getUrl];
    
    //NSString * urlString = self.jobUrlString;
    
    //  NSLog(@"job url string - %@", self.jobUrlString);

    self.webUrl = self.passedUrl;
    
    NSLog(@"link - %@", self.webUrl);
    
    //NSURL *jobUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", self.jobModel.jobUrl]];
    NSURL *jobUrl = [NSURL URLWithString:self.webUrl];
    NSURLRequest *jobRequest = [NSURLRequest requestWithURL:jobUrl];
    
    [self.jobUrlWebView loadRequest:jobRequest];

    
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

-(void)getUrl
{
    [APILayer getJobsWithjobUrl:nil
                     withSucces:^(AFHTTPRequestOperation *operation, id responseObject) {
                         NSLog(@"response: %@", responseObject);
                         
                         /////proba
                         NSArray *responsPosts = [[responseObject objectForKey:@"result"] valueForKey:@"jobUrl"];
                         
                         
                         NSLog(@"response: %@", responsPosts);

                         
                     } andFailure:^(NSError *error) {
                         NSLog(@"error: %@", error);
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Greska!"
                                                                         message:@"Podatci nisu ucitani!"
                                                                        delegate:nil
                                                               cancelButtonTitle:@"Ok!"
                                                               otherButtonTitles:nil];
                         [alert show];
                         
                     }];
    
}

@end
