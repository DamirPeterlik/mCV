//
//  PickUser.m
//  mCV
//
//  Created by Damir Peterlik on 25/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import "PickUser.h"
#import "puLoginRegister.h"
#import "TabBarMain.h"


@interface PickUser ()

@property (nonatomic,weak) IBOutlet UIButton *PUbutton;
@property (nonatomic,weak) IBOutlet UIButton *BUbutton;

-(IBAction)puButtonPressed:(id)sender;
-(IBAction)buButtonPressed:(id)sender;

@end

@implementation PickUser

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"mCV";
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

#pragma mark - Actions

-(IBAction)puButtonPressed:(id)sender
{
    
    puLoginRegister *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PUloginRegisterVcID"];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(IBAction)buButtonPressed:(id)sender
{
    UIAlertController *alert = [Helper returnAlerViewWithTitle:@"Greska!"
                                                   withMessage:@"U radu!!"
                                                 withOKhandler:^(UIAlertAction *action)
                                {
                                    NSLog(@"OK action pressed!");
                                    
                                }];
    [self presentViewController:alert animated:YES completion:^{
        //     [self segueTabBar];
    }];
    
}

-(void) segueTabBar
{
    /*
    TabBarMain *vc = [self.storyboard
                      instantiateViewControllerWithIdentifier:@"tabBar"];
    [self.navigationController pushViewController:vc animated:YES];
    */
    
    [self performSegueWithIdentifier:@"loginRegister" sender:self];

}

@end
