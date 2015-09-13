//
//  PDFViewController.h
//  mCV
//
//  Created by Damir Peterlik on 10/09/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface PDFViewController : UIViewController

//@property (nonatomic, strong) UITextField *textPDF;

@property (strong, nonatomic) NSString *passedTxt;
@property (strong, nonatomic) NSString *generateTxt;


@end
