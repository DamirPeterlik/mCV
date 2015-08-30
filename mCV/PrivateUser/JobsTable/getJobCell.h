//
//  getJobCell.h
//  mCV
//
//  Created by Damir Peterlik on 29/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface getJobCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *jobTitle;
@property (strong, nonatomic) IBOutlet UILabel *jobDescription;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
