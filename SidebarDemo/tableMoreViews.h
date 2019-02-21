//
//  tableMoreViews.h
//  SidebarDemo
//
//  Created by Fabricio Aguiar de Padua on 08/05/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tableMoreViews : UITableViewController{
NSArray * news, * details;
NSMutableData * data;

// Define keys
NSString *title;
NSString *thumbnail;
NSString *detail;
NSString *date;

}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak, nonatomic) IBOutlet UIView *ViewApper;
@end
