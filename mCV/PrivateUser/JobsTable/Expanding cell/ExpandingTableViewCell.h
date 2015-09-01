//
//  ExpandingTableViewCell.h
//  mCV
//
//  Created by Damir Peterlik on 01/09/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpandingTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *jobTitleExp;
@property (strong, nonatomic) IBOutlet UILabel *jobDescriptionExp;
@property (strong, nonatomic) IBOutlet UILabel *jobGroupExp;

@property (nonatomic, strong) IBOutlet UIButton *jobInfoExp;

@end
