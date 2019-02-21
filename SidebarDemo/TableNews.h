//
//  TableNews.h
//  SidebarDemo
//
//  Created by Fabricio Aguiar de Padua on 29/04/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableNews : UITableViewController{
    NSArray * news, * details;
    NSMutableData * data;
    
    // Define keys
    NSString *title;
    NSString *thumbnail;
    NSString *detail;
    NSString *date;
    
    NSString * summaryLabel;
    NSString * remoteHostLabel;
    NSString * remoteHostStatusField;
    NSString * internetConnectionStatusField;
    NSString * localWiFiConnectionStatusField;
    
    NSDictionary * ObjetoJson;
    
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *BtnRefresh;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;


@property (nonatomic, retain) NSString * summaryLabel;
@property (nonatomic, retain) NSString * remoteHostLabel;
@property (nonatomic, retain) NSString * remoteHostStatusField;
@property (nonatomic, retain) NSString * internetConnectionStatusField;
@property (nonatomic, retain) NSString * localWiFiConnectionStatusField;


@property (weak, nonatomic) IBOutlet UIView *ViewApper;


@property (weak, nonatomic) IBOutlet UIView *viewReachability;
@property (weak, nonatomic) IBOutlet UILabel *lbReachability;



@property (nonatomic, retain) NSDictionary * ObjetoJson;


@property (strong, nonatomic) NSMutableArray *pageImages;





@end
