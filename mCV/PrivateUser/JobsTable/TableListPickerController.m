//
//  TableListPickerController.m
//  mCV
//
//  Created by Damir Peterlik on 01/09/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import "TableListPickerController.h"

@interface TableListPickerController ()

@property (nonatomic,strong) IBOutlet UITableView *tableView;


@end

@implementation TableListPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(dissmisView)];
    //[self.view addGestureRecognizer:tapGesture];
    
}

-(void)dissmisView
{
    [UIView animateWithDuration:.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.view setAlpha:0];
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self.view.superview layoutIfNeeded];
        [self removeFromParentViewController];
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataSource count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *jobGroup = [self.dataSource objectAtIndex:indexPath.row];
    
    [self dissmisView];
    
    [self.delegate getPickedAccountNumber:jobGroup];
}


@end
