//
//  JobsViewController.m
//  mCV
//
//  Created by Damir Peterlik on 30/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import "JobsViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "APILayer.h"
#import "JobData.h"
#import "getJobCell.h"
#import "Constants.h"
#import "JobData.h"

@interface JobsViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *datasource;
@property (nonatomic,strong) UIRefreshControl *refreshControl;


@end

@implementation JobsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.navigationItem.backBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;

    self.navItem.title = @"Job/Posao";
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshContent) forControlEvents:UIControlEventValueChanged];
    [self refreshContent];
    // Do any additional setup after loading the view.
    [self getJobs];
}

-(void)refreshContent
{

    [self getJobs];
    [self.refreshControl setEnabled:NO];
    NSLog(@"Refresh");
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tabBarController.navigationItem.title =@"Jobs/Poslovi";


}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
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

- (void) getJobs
{

    NSLog(@"getjobs starting");
    //NSString *url = @"";
    
    [APILayer getJobsWithjobUrl:nil
                     withSucces:^(AFHTTPRequestOperation *operation, id responseObject) {
                         NSLog(@"response: %@", responseObject);

                         /////proba
                         NSArray *responsPosts = [responseObject objectForKey:@"result"];
                         NSError *error = nil;


                         NSLog(@"response: %@", responsPosts);
                         self.datasource = [JobData arrayOfModelsFromDictionaries:responsPosts error:&error];
                         [self.tableView reloadData];
                         [self.refreshControl setEnabled:YES];
                         [self.refreshControl endRefreshing];
                         
                     } andFailure:^(NSError *error) {
                         NSLog(@"error: %@", error);
                         [self.refreshControl setEnabled:NO];

                     }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return  self.datasource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cellJob";
    getJobCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(!cell)
    {
        cell = [[getJobCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    JobData *job = [self.datasource objectAtIndex:indexPath.row];
    
    
    
    cell.jobTitle.text = job.jobTitle;
    cell.jobDescription.text = job.jobDetail;
    
    return cell;

}

@end
