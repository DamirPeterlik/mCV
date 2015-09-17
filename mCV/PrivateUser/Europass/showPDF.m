//
//  showPDF.m
//  mCV
//
//  Created by Damir Peterlik on 16/09/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import "showPDF.h"

@interface showPDF ()

@end

@implementation showPDF

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"CV";

    // Do any additional setup after loading the view.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DamirPeterlik" ofType:@"pdf"];

    NSURL *pdfPath = [NSURL fileURLWithPath:path];
    NSURLRequest *webViewPDF = [NSURLRequest requestWithURL:pdfPath];
    
    [self.showPDF loadRequest:webViewPDF];

    
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
