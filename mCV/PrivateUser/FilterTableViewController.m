//
//  FilterTableViewController.m
//  AssecoPraksa
//
//  Created by MTLab on 28/04/15.
//  Copyright (c) 2015 asseco. All rights reserved.
//

#import "FilterTableViewController.h"
#import "TableListPickerController.h"
#import "TableListPickerLocationsViewController.h"

@interface FilterTableViewController ()
{
    BOOL keyboardIsShown;
}

@property (strong, nonatomic) IBOutlet UILabel *accNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *accLocationLabel;

- (IBAction)confirmButton:(id)sender;

- (IBAction)cancelButton:(id)sender;


@end

@implementation FilterTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    
    /*
     // register for keyboard notifications
     [[NSNotificationCenter defaultCenter] addObserver:self
     selector:@selector(keyboardWillShow:)
     name:UIKeyboardWillShowNotification
     object:self.view.window];
     // register for keyboard notifications
     [[NSNotificationCenter defaultCenter] addObserver:self
     selector:@selector(keyboardWillHide:)
     name:UIKeyboardWillHideNotification
     object:self.view.window];
     keyboardIsShown = NO;
     */
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:gestureRecognizer];
    
    self.accFilterGroups = [NSArray arrayWithObjects:@"IT, telekomunikacije", @"Mehanika", @"Umjetnost", @"Vozac", @"Zdravstvo", @"Ugostiteljstvo", @"Skolstvo", @"Turizam", nil];
    
    self.accFilterLocations = [NSArray arrayWithObjects:@"Varazdin", @"Zagreb", @"Rijeka", @"Zadar", @"Dragalic", nil];
}
- (void) hideKeyboard {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"filtrira se bb");
    
    //FilterData *job;
    
    //[self.delegate returnFilteredData:job]; hm?

    if(indexPath.section == 0){
        if(indexPath.row == 0){
            NSLog(@"filtrira se cc");

            TableListPickerController *tlpVc = [TableListPickerController new];//nib is the same name so i can use New
            tlpVc.delegate = self;
            tlpVc.dataSource = self.accFilterGroups;
            [tlpVc.view setAlpha:0];
            [tlpVc.view setFrame:self.view.bounds];
            
            [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionTransitionCurlDown animations:^{
                [self.view addSubview:tlpVc.view];
                [self addChildViewController:tlpVc];
                [tlpVc.view setAlpha:1];
                [self.view layoutIfNeeded];
            } completion:nil];
            NSLog(@"filtrira se gg");
        }
    }
    
    if(indexPath.section == 1){
        if(indexPath.row == 0){
            
            TableListPickerLocationsViewController *tlpVc = [TableListPickerLocationsViewController new];//nib is the same name so i can use New
            tlpVc.delegate = self;
            tlpVc.dataSource = self.accFilterLocations;
            [tlpVc.view setAlpha:0];
            [tlpVc.view setFrame:self.view.bounds];
            
            [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionTransitionCurlDown animations:^{
                [self.view addSubview:tlpVc.view];
                [self addChildViewController:tlpVc];
                [tlpVc.view setAlpha:1];
                [self.view layoutIfNeeded];
            } completion:nil];
        }
    }
    
    
}

-(void)getPickedAccountNumber:(NSString *)jobGroup
{
    self.accNumberLabel.text = jobGroup;
    [self.tableView reloadData];
}

-(void)getPickedLocation:(NSString *)accLocation
{
    self.accLocationLabel.text = accLocation;
    [self.tableView reloadData];
}

- (void)keyboardWillHide:(NSNotification *)n
{
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // resize the scrollview
    CGRect viewFrame = self.view.frame;
    viewFrame.size.height += (keyboardSize.height - 20);
    [self.view setFrame:viewFrame];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    [self.view.superview layoutIfNeeded];
    [UIView commitAnimations];
    
    keyboardIsShown = NO;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    if (keyboardIsShown) {
        return;
    }
    
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // resize the noteView
    CGRect viewFrame = self.view.frame;
    viewFrame.size.height -= (keyboardSize.height - 20);
    [self.view setFrame:viewFrame];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.view.superview layoutIfNeeded];
    [UIView commitAnimations];
    keyboardIsShown = YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)confirmButton:(id)sender {
    
    FilterData *fData = [[FilterData alloc]init];
   
    [fData setJobGroup:[self.accNumberLabel.text isEqualToString:@"..." ] ? nil : self.accNumberLabel.text ];
    NSLog(@"acc num confirm button %@", fData.jobGroup);
    
    [fData setJobLocation:[self.accLocationLabel.text isEqualToString:@"..." ] ? nil : self.accLocationLabel.text ];
    NSLog(@"acc num confirm button %@", fData.jobLocation);
    
    [self.delegate returnFilteredData:fData]; /// trebas vratiti samo string po kojem zelis filtrirat
    NSLog(@"delegate - %@", self.delegate);

    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"confirm kliked");

}

- (IBAction)cancelButton:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"cancel kliked");
    
}


@end
