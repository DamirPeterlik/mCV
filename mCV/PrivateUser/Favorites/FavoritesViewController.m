//
//  FavoritesViewController.m
//  mCV
//
//  Created by Damir Peterlik on 01/09/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import "FavoritesViewController.h"
#import "FavoritesCell.h"

@interface FavoritesViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *datasource;

@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSLog (@"number of roows");
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog (@"cell for roows");
    static NSString *identifier = @"cellFavorites";
    
    FavoritesCell *cell = (FavoritesCell *)[tableView dequeueReusableCellWithIdentifier:identifier];

    
    return cell;
}


@end
