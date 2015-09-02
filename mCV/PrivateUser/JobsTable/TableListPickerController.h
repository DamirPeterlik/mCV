//
//  TableListPickerController.h
//  mCV
//
//  Created by Damir Peterlik on 01/09/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableListPickerController;

@protocol TableListPickerDelegate <NSObject>

-(void)getPickedAccountNumber:(NSString*)accNUmber;

@end

@interface TableListPickerController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataSource;
@property (strong,nonatomic) id<TableListPickerDelegate> delegate;

-(IBAction)exitBtn:(id)sender;

@end
