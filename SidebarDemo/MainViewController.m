//
//  ViewController.m
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "MainViewController.h"

#import "SWRevealViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize ViewApper;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [ViewApper setFrame:[[UIScreen mainScreen] bounds]];

    [self.navigationController.view addSubview:ViewApper];
    
   // [self.view addSubview:ViewApper];
   
    self.title = @"News";
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
