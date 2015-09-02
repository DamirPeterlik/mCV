//
//  FilterTableViewController.h
//  AssecoPraksa
//
//  Created by MTLab on 28/04/15.
//  Copyright (c) 2015 asseco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableListPickerController.h"
#import "TableListPickerLocationsViewController.h"
#import "FilterData.h"

@class FilterTableViewController;

@protocol FilterDataDelegate <NSObject>

-(void)returnFilteredData:(FilterData*)data;

@end

@interface FilterTableViewController : UITableViewController <TableListPickerDelegate, TableListPickerLocationsViewControllerDelegate, UITextFieldDelegate>

@property (nonatomic,strong) NSArray *accFilterGroups;
@property (nonatomic,strong) NSArray *accFilterLocations;


@property (nonatomic,strong) id <FilterDataDelegate> delegate;

@end
