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
#import "JobDetailTableViewController.h"

#import "ExpandingTableViewCell.h"

@interface JobsViewController () <UITableViewDataSource,UITableViewDelegate>
{
    
   int selectedIndex;
    
}
@property (nonatomic,weak) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *datasource;
//@property (nonatomic,strong) NSArray *datasource;

@property (nonatomic,strong) UIRefreshControl *refreshControl;
//@property (nonatomic, strong) int *selectedIndex;
@property (nonatomic,strong) UIButton *jobInfoBtn;

@property (nonatomic, strong) NSMutableArray *favorites;

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
    
    selectedIndex = -1;

    self.navigationItem.backBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;

    self.navItem.title = @"Job/Posao";
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshContent) forControlEvents:UIControlEventValueChanged];
    [self refreshContent];
    // Do any additional setup after loading the view.
    [self getJobs];
    
    //proba favorites

    
    
    
    
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return  self.datasource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //expandingCell
    static NSString *identifier = @"expandingCell";
    JobData *job = [self.datasource objectAtIndex:indexPath.row];


    ExpandingTableViewCell *cell = (ExpandingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ExpandingCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    cell.jobTitleExp.text = job.jobTitle;
    cell.jobDescriptionExp.text = job.jobDetail;
    cell.jobGroupExp.text = job.jobGroup;
    cell.jobDescriptionExp.hidden = YES;
    
    self.jobInfoBtn = cell.jobInfoExp;
    self.jobInfoBtn.tag = indexPath.row;
    
    
    if(selectedIndex == indexPath.row)
    {
        cell.contentView.backgroundColor = [UIColor lightGrayColor];
        cell.jobTitleExp.textColor = [UIColor whiteColor];
        cell.jobTitleExp.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
        cell.jobDescriptionExp.textColor = [UIColor whiteColor];
        cell.jobGroupExp.textColor = [UIColor whiteColor];
        cell.jobDescriptionExp.hidden = NO;

    }
    else {
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.jobTitleExp.textColor = [UIColor blackColor];
        cell.jobTitleExp.font = [UIFont systemFontOfSize:17];
        cell.jobDescriptionExp.textColor = [UIColor blackColor];
        cell.jobGroupExp.textColor = [UIColor blackColor];
    }
    
    /*
    static NSString *identifier = @"cellJob";
    getJobCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(!cell)
    {
        cell = [[getJobCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    JobData *job = [self.datasource objectAtIndex:indexPath.row];
    
    
    
    cell.jobTitle.text = job.jobTitle;
    cell.jobDescription.text = job.jobDetail;
    */
    
    
    return cell;
    

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (selectedIndex == indexPath.row) {
        return 100;
    } else
        {
            return 67;
        }
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(selectedIndex == indexPath.row)
    {
        selectedIndex = -1;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        return;
    }
    
    if(selectedIndex != -1)
    {
        NSIndexPath *prevPart = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        selectedIndex = indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:prevPart] withRowAnimation:UITableViewRowAnimationFade];

    }
    
    selectedIndex = indexPath.row;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    //favorites proba


    
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    JobDetailTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"jobDetailVC"];
    vc.jobModel = [self.datasource objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //remove the deleted object from your data source.
        //If your data source is an NSMutableArray, do this
        [self.datasource removeObjectAtIndex:indexPath.row];
        [tableView reloadData]; // tell table to refresh now
    
       } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }

}


@end
