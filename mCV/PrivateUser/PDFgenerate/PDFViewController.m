//
//  PDFViewController.m
//  mCV
//
//  Created by Damir Peterlik on 10/09/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import "PDFViewController.h"

@interface PDFViewController ()

@end

@implementation PDFViewController

- (void)viewDidLoad {
    
   [self drawText];
   [self showPDFFile];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

-(void)drawText
{
    
    NSString* fileName = @"Invoice.PDF";
    
    NSArray *arrayPaths =
    NSSearchPathForDirectoriesInDomains(
                                        NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    NSString* pdfFileName = [path stringByAppendingPathComponent:fileName];
    
   // NSString* textToDraw = @"Hello Dado mCV proba [1] 1234567890 [2] 1234567890 [3] 1234567890 [4] 1234567890 [5] 1234567890 [6] 1234567890 [7] 1234567890 [8] 1234567890.. [9]....abcd1234567890....... [10] 1234567890 [11] 1234567890 [12] 1234567890 \n Hello Dado mCV proba [1] 1234567890 [2] 1234567890 [3] 1234567890 [4] 1234567890 [5] 1234567890 [6] 1234567890 [7] 1234567890 [8] 1234567890 [9] 1234567890 [10] 1234567890 [11] 1234567890 [12] 1234567890";
    
    //CFStringRef stringRef = (__bridge CFStringRef)textToDraw;
    CFStringRef stringRef = (__bridge CFStringRef)self.passedTxt;

    
    // Prepare the text using a Core Text Framesetter.
    CFAttributedStringRef currentText = CFAttributedStringCreate(NULL, stringRef, NULL);
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(currentText);
    
    CGRect frame1 = CGRectMake(10, -10, 350, 50);
   // CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
     //CGRect size = [self.passedTxt boundingRectWithSize:CGSizeMake(192,1000 ) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0f]} context:nil];
   // NSLog(@"%ld",size.size.width);
    //CGRect frame1 = CGRectMake(0, 0, 612, 792);
    
    CGMutablePathRef framePath = CGPathCreateMutable();
    CGPathAddRect(framePath, NULL, frame1);
    
    //Get the frame that will do the rendering.
    //CFRange currentRange = CFRangeMake(0, 0);
    CFRange currentRange = CFRangeMake(0, 0);
    //CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, NULL);
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, NULL);

    CGPathRelease(framePath);
    
    // Create the PDF context using the default page size of 612 x 792.
    UIGraphicsBeginPDFContextToFile(pdfFileName, CGRectZero, nil);
    
    // Mark the beginning of a new page.
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
    
    // Get the graphics context.
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    //CGContextSetRGBFillColor(currentContext, 214.0f/255.0f, 238.0f/255.0f, 204.0f/255.0f, 1.0);
    
    //CGContextFillRect(currentContext, frame1);

    
    // Put the text matrix into a known state. This ensures
    // that no old scaling factors are left in place.
    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);
    
    // Core Text draws from the bottom-left corner up, so flip
    // the current transform prior to drawing.
    // CGContextTranslateCTM(currentContext, 0, 100);
    CGContextTranslateCTM(currentContext, 0, 100);
    
    //CGContextScaleCTM(currentContext, 1.0, -1.0);
    CGContextScaleCTM(currentContext, 1, -1);
    
    // Draw the frame.
    CTFrameDraw(frameRef, currentContext);

    
    CFRelease(frameRef);
    CFRelease(stringRef);
    CFRelease(framesetter);
    
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();
    
}

-(void)showPDFFile
{
    NSString* fileName = @"Invoice.PDF";
    
    NSArray *arrayPaths =
    NSSearchPathForDirectoriesInDomains(
                                        NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    NSString* pdfFileName = [path stringByAppendingPathComponent:fileName];
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectMake(12, 75, 350, 500)];
    //dimension off the web view displaying on the view controller, 12 from the left side, 20 from the top, 350/375 witdh, 625/667 height
    
    NSURL *url = [NSURL fileURLWithPath:pdfFileName];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView setScalesPageToFit:YES];
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
}

@end
