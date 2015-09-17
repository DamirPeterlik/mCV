//
//  createEuropass.m
//  mCV
//
//  Created by Damir Peterlik on 16/09/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import "createEuropass.h"

@interface createEuropass ()

@end

@implementation createEuropass

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"europass";

    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    
    NSURL *jobUrl = [NSURL URLWithString:@"https://europass.cedefop.europa.eu/editors/en/cv/compose"];
    NSURLRequest *jobRequest = [NSURLRequest requestWithURL:jobUrl];
    
    [self.createCV loadRequest:jobRequest];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.activityIndicator.hidden = NO;
    [self.activityIndicator stopAnimating];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.activityIndicator.hidden = NO;
    [self.activityIndicator stopAnimating];
    
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

@end
