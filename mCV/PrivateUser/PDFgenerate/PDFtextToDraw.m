//
//  PDFtextToDraw.m
//  mCV
//
//  Created by Damir Peterlik on 10/09/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import "PDFtextToDraw.h"
#import "PDFViewController.h"

@interface PDFtextToDraw ()

@end

@implementation PDFtextToDraw

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)openPDFwebView:(id)sender
{
    PDFViewController *pdfWebView = [self.storyboard instantiateViewControllerWithIdentifier:@"pdfDrawView"];
    
    NSString *passedMessage = [NSString stringWithFormat:@"%@", self.textViewToDraw.text];
    NSLog(@"text field data to pass \n - %@", passedMessage);
    pdfWebView.passedTxt = passedMessage;
    NSLog(@"passed text \n - %@", pdfWebView.passedTxt);
    
   [self.navigationController pushViewController:pdfWebView animated:YES];
    
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
