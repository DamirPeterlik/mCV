//
//  JobUrlWebViewController.h
//  mCV
//
//  Created by Damir Peterlik on 01/09/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobData.h"
#import "APILayer.h"

//@protocol passUrl <NSObject>

//-(void)setUrl:(NSString *) jobUrl;

//@end

@interface JobUrlWebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *jobUrlWebView;
@property (strong,nonatomic) JobData *jobModel;

@property (strong, nonatomic) NSString *webUrl;
@property (strong, nonatomic) NSString *passedUrl;

//@property (retain) id <passUrl> delegate;
//@property (nonatomic, strong) NSString *jobUrlString;

@end
