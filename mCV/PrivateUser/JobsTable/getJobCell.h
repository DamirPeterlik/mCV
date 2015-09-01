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

@end

//ovu klasu ne koristimo vise jer smo napravili novu s nib fajlom za expandible view