//
//  JobsViewController.m
//  mCV
//
//  Created by Damir Peterlik on 30/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import "JobsViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "Constants.h"
#import "JobData.h"
#import "FilterTableViewController.h"

@interface JobsViewController ()
{
    int selectedIndex;
    BOOL isFiltering;
}

//@property (nonatomic,strong) NSArray *datasource;

@property (nonatomic,strong) UIRefreshControl *refreshControl;

@property (strong,nonatomic) NSArray *filteredArray;
@property (strong,nonatomic) NSArray *accNumbers;
@property (nonatomic,strong) NSMutableArray *datasource2;
@property (nonatomic, strong) NSArray *responseJobGroup;

@end

@implementation JobsViewController


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
    
    //isFiltering = NO;
   // isFiltering = YES;

    self.navigationItem.leftBarButtonItem.enabled = NO;

    [self.tableView reloadData];
    


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
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    NSLog(@"response job grupa apear - %@", self.responseJobGroup);

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tabBarController.navigationItem.title =@"Jobs/Poslovi";
    NSLog(@"response job grupa did apear - %@", self.responseJobGroup);

}
/*
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
 */

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
    [APILayer getJobsWithjobUrl:nil
                     withSucces:^(AFHTTPRequestOperation *operation, id responseObject) {
                         /////proba
                         NSArray *responsPosts = [responseObject objectForKey:@"result"];
                         //NSArray *responsPosts2 = [[responseObject objectForKey:@"result"] valueForKey:@"jobTitle"];
                         //NSArray *responsPosts = [[responseObject objectForKey:@"result"] valueForKey:@"jobGroup"];

                         NSError *error = nil;
                         
                         self.datasource = [JobData arrayOfModelsFromDictionaries:responsPosts error:&error];
                         
    NSArray *responsPosts2 = [[responseObject objectForKey:@"result"] valueForKey:@"jobGroup"];
                         
                        self.datasource2 = [JobData arrayOfModelsFromDictionaries:responsPosts2 error:&error];
                         
                         //NSLog(@"\n\n\n");
                         //NSLog(@"datasource 2 response 2 - %@", self.datasource2);
                         //NSLog(@"datasource 2 value 2 - %@", [self.datasource2 valueForKey:@"jobGroup"]);

                         self.responseJobGroup = [NSArray arrayWithArray:responsPosts2];
                         
                         //NSLog(@"\n\n\n");
                         NSLog(@"response 2 - %@", responsPosts2);
                         NSLog(@"\n\n\n");
                         NSLog(@"response job group properti - %@", self.responseJobGroup);

                         [self.tableView reloadData];
                         [self.refreshControl setEnabled:YES];
                         [self.refreshControl endRefreshing];
                         
                     } andFailure:^(NSError *error) {
                         NSLog(@"error: %@", error);
                         [self.refreshControl setEnabled:NO];

                     }];
}

#pragma mark - Delegate methods

-(void)responseTrnasactionsRecivedWithArray:(NSMutableArray *)array
{
    self.datasource = array;
    NSLog(@"fil datasource- %@", self.datasource);

    [self.tableView reloadData];
    [self getAllAcountNumbers];

}

-(void)returnFilteredData:(FilterData *)data
{
    self.navigationItem.leftBarButtonItem.enabled = YES;
    
    isFiltering = YES;
    
   // JobData *grupa;
    NSMutableArray *compoundPredicate = [NSMutableArray array];
    //NSString *mehanika = @"Mehanika";
    
    //FilterData *number;
    
    NSLog(@"ccc - %@", data.jobGroup);
    
    if(data.jobGroup)
    {
       // NSPredicate *p = [NSPredicate predicateWithFormat:@"SELF.jobGroup CONTAINS[cd] %@", grupa.jobGroup];
        NSPredicate *p = [NSPredicate predicateWithFormat:@"jobGroup CONTAINS[cd] %@", data.jobGroup];

        [compoundPredicate addObject:p];
        
        NSLog(@"predikate - %@", compoundPredicate);
    }
    
    NSPredicate *allPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:compoundPredicate];
    
    
    self.filteredArray = [self.datasource filteredArrayUsingPredicate:allPredicate];
    [self.tableView reloadData];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if(isFiltering){
        return self.filteredArray.count;
    }
    else
    {
        return self.datasource.count;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //expandingCell
    static NSString *identifier = @"expandingCell";

    ExpandingTableViewCell *cell = (ExpandingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
   // JobData *job = [self.datasource objectAtIndex:indexPath.row];
    JobData *job;
    
    if(isFiltering)
    {
        job = [self.filteredArray objectAtIndex:indexPath.row];
    }else
    {
        job = [self.datasource objectAtIndex:indexPath.row];
    }
    
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ExpandingCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.jobTitleExp.text = job.jobTitle;
    cell.jobDescriptionExp.text = job.jobDetail;
    cell.jobGroupExp.text = job.jobGroup;
    cell.jobDescriptionExp.hidden = YES;

    
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //remove the deleted object from your data source.
        //If your data source is an NSMutableArray, do this
        [self.datasource removeObjectAtIndex:indexPath.row];
        [tableView reloadData]; // tell table to refresh now
        NSLog(@"Edit delete");
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        NSLog(@"Edit insert");
    }

}

-(void)getAllAcountNumbers
{
    isFiltering = YES;
    NSMutableArray *array = [NSMutableArray array];
    
    for (JobData *t in self.datasource) {
        isFiltering = YES;

        NSString *acc = t.jobGroup;
        [array addObject:acc];
    }
        isFiltering = YES;
    self.accNumbers = [[NSArray alloc]initWithArray:[[NSSet setWithArray:array] allObjects]];
    NSLog(@"fil array 8- %@", self.filteredArray);
    isFiltering = YES;

}

#pragma mark - Actions

-(IBAction)filterButtonPressed:(id)sender
{
    //storyboardID = FilterTableViewController
    FilterTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FilterTableViewController"];
    vc.delegate = self;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}


@end
