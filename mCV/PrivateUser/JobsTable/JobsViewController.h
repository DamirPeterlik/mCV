//
//  JobsViewController.h
//  mCV
//
//  Created by Damir Peterlik on 30/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APILayer.h"
#import "ExpandingTableViewCell.h"
#import "JobDetailTableViewController.h"
#import "FilterTableViewController.h"

@interface JobsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,FilterDataDelegate, UISearchBarDelegate,UISearchDisplayDelegate>


@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;
@property (nonatomic,weak) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *datasource;

@property (nonatomic,strong) id <FilterDataDelegate> delegate;

@end
