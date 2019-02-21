//
//  DatailsNew.h
//  SidebarDemo
//
//  Created by Fabricio Aguiar de Padua on 06/05/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PageContentViewController.h"

@interface DatailsNew : UIViewController <UIPageViewControllerDataSource>{
    
    NSDictionary * ObjetoJson;
}

- (IBAction)startWalkthrough:(id)sender;
@property (strong, nonatomic) UIPageViewController *pageViewController;

//@property (strong, nonatomic) NSMutableArray *pageImages;
@property (strong, nonatomic) NSArray *pageImages;
@property (strong, nonatomic) NSMutableArray *Pages;


@property (nonatomic, retain) NSDictionary * ObjetoJson;



@end
