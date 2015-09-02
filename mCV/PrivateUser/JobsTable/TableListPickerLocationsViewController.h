//
//  TableListPickerLocationsViewController.h
//  mCV
//
//  Created by Damir Peterlik on 02/09/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableListPickerLocationsViewController;

@protocol TableListPickerLocationsViewControllerDelegate <NSObject>

-(void)getPickedLocation:(NSString*)accLocation;

@end

@interface TableListPickerLocationsViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataSource;
@property (strong,nonatomic) id<TableListPickerLocationsViewControllerDelegate> delegate;

-(IBAction)exitBtn:(id)sender;

@end
