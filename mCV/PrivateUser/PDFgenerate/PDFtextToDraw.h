//
//  PDFtextToDraw.h
//  mCV
//
//  Created by Damir Peterlik on 10/09/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFtextToDraw : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textViewToDraw;

-(IBAction)openPDFwebView:(id)sender;

@end
