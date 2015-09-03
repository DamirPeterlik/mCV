//
//  JobDetailTableViewController.h
//  mCV
//
//  Created by Damir Peterlik on 31/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobData.h"
//#import "APILayer.h"


@interface JobDetailTableViewController : UITableViewController

@property (nonatomic, strong) NSString *jobUrlString;

@property (strong, nonatomic) IBOutlet UILabel *jobTitleLbl;
@property (strong, nonatomic) IBOutlet UILabel *jobDetailLbl;
@property (strong, nonatomic) IBOutlet UILabel *jobLocation;
@property (strong, nonatomic) IBOutlet UIButton *jobUrl;
@property (nonatomic, strong) NSMutableArray *jobTitleMarray;

@property (strong,nonatomic) JobData *jobModel;

//
@property int selectedRow;
@property int isBtn;

-(IBAction)openJobUrl:(id)sender;

@end
