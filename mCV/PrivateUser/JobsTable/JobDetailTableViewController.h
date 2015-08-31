//
//  JobDetailTableViewController.h
//  mCV
//
//  Created by Damir Peterlik on 31/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobData.h"
#import "APILayer.h"


@interface JobDetailTableViewController : UITableViewController


@property (strong, nonatomic) IBOutlet UILabel *jobTitleLbl;
@property (strong, nonatomic) IBOutlet UILabel *jobDetailLbl;

@property (strong, nonatomic) IBOutlet UILabel *jobLocation;

@property (nonatomic, strong) NSMutableArray *jobTitleMarray;

@property (strong,nonatomic) JobData *jobModel;


@end
