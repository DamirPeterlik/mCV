//
//  JobDetailTableViewController.m
//  mCV
//
//  Created by Damir Peterlik on 31/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import "JobDetailTableViewController.h"
//#import "APILayer.h"
#import "JobData.h"
#import "JobUrlWebViewController.h"

@interface JobDetailTableViewController ()

@property (nonatomic,strong) NSMutableArray *datasource;

@end

@implementation JobDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Detalji";

    //self.jobTitleLbl.text = @"proba";
    
    //[self showJobDetail];
    
    self.jobTitleLbl.text =  [NSString stringWithFormat:@"%@", self.jobModel.jobTitle];
    self.jobDetailLbl.text =  [NSString stringWithFormat:@"%@", self.jobModel.jobDetail];
    self.jobLocation.text =  [NSString stringWithFormat:@"%@", self.jobModel.jobLocation];
    

    
    NSLog(@"job url - %@", self.jobModel.jobUrl);
    
    self.jobUrlString = [NSString stringWithFormat:@"%@", self.jobModel.jobUrl];
    
    NSLog(@"job url string - %@", self.jobUrlString);

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)openJobUrl:(id)sender
{
    JobUrlWebViewController *webView = [self.storyboard instantiateViewControllerWithIdentifier:@"jobUrlWebView"];
    
    NSString *passedMessage = [NSString stringWithFormat:@"%@", self.jobModel.jobUrl];
    NSLog(@"job url passed - %@", passedMessage);
    webView.passedUrl = passedMessage;
    //[webView setDelegate:self];
    
    [self.navigationController pushViewController:webView animated:YES];

    
  //  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.jobModel.jobUrl]]];
    
}


@end
