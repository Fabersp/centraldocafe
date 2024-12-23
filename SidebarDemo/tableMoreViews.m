//
//  tableMoreViews.m
//  SidebarDemo
//
//  Created by Fabricio Aguiar de Padua on 08/05/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import "tableMoreViews.h"

#import "SWRevealViewController.h"
#import "CellNews.h"
#import "DatailsNew.h"
#import "MBProgressHUD.h"

#import "Reachability.h"

#import "SystemConfiguration/SystemConfiguration.h"

//#define defUrl @"http://www.promastersolution.com.br/x7890_IOS/central/visitas.php"





@interface tableMoreViews () <MBProgressHUDDelegate> {
    MBProgressHUD *HUD;
    long long expectedLength;
    long long currentLength;
    UIRefreshControl *refreshControl;
    
    
    
    
}


@end

@implementation tableMoreViews

@synthesize ViewApper;


- (void)viewDidLoad {
    [super viewDidLoad];
    [ViewApper setFrame:[[UIScreen mainScreen] bounds]];
    
    [self.navigationController.view addSubview:ViewApper];
    
    // [self.view addSubview:ViewApper];
    
    self.title = @"Mais lidas";
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [self.navigationController.view addSubview:HUD];
    
    HUD.dimBackground = YES;
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.labelText = @"Carrengando...";
    
    
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [self Loading];
    });
    refreshControl = [[UIRefreshControl alloc] init];
    //refreshControl.tintColor = [UIColor redColor];
    [refreshControl addTarget:self action:@selector(Loading) forControlEvents:UIControlEventValueChanged];
    NSMutableAttributedString *refreshString = [[NSMutableAttributedString alloc] initWithString:@"Carrengando..."];
    [refreshString addAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]} range:NSMakeRange(0, refreshString.length)];
    refreshControl.attributedTitle = refreshString;
    [self.tableView addSubview:refreshControl];

}

- (BOOL) isConnectionAvailable
{
    Reachability *network = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [network currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        return FALSE;
    } else {
        return TRUE;
    }
}



-(void)Loading{
//    NSURL * url = [NSURL URLWithString:defUrl];
//    
//    if(!self.isConnectionAvailable) {
//        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
//        
//    } else{
//        
//        NSURLSession * session = [NSURLSession sharedSession];
//        
//        NSURLSessionDownloadTask * task = [session downloadTaskWithURL:url
//                                                     completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
//                                                         
//                                                         NSData * jsonData = [[NSData alloc] initWithContentsOfURL:location];
//                                                         news = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
//                                                         
//                                                         dispatch_async(dispatch_get_main_queue(), ^{
//                                                             [self.tableView reloadData];
//                                                             [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
//                                                             [refreshControl endRefreshing];
//                                                         });
//                                                         
//                                                     }];
//        [task resume];
//    }

}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    HUD = nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Item";
    
    CellNews *cell = (CellNews *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell= [[CellNews alloc]initWithStyle:
               UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.lbTitulo.text = [[news objectAtIndex:indexPath.row] objectForKey:@"titulo"];
    cell.lbTitulo.numberOfLines = 2;
    [cell.lbTitulo sizeToFit];
    cell.lbTitulo.lineBreakMode = NSLineBreakByWordWrapping;
    
    cell.lbDetalhe.text= [[[news objectAtIndex:indexPath.row] objectForKey:@"news"]stringByReplacingOccurrencesOfString:@"<br />"
withString:@" "];;
    cell.lbDetalhe.numberOfLines = 5;
    [cell.lbDetalhe sizeToFit];
    cell.lbDetalhe.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSURL * urlImage = [NSURL URLWithString:[[news objectAtIndex:indexPath.row] objectForKey:@"image_mini"]];
    
    cell.lbTumbImage.image = [UIImage imageNamed:@"image.png"];
    
    
    NSURLSession * session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask * task = [session downloadTaskWithURL:urlImage
                                                 completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                     
                                                     NSData * imageData = [[NSData alloc] initWithContentsOfURL:location];
                                                     UIImage *img = [UIImage imageWithData:imageData];
                                                     
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         cell.lbTumbImage.image = img;
                                                     });
                                                     
                                                 }];
    [task resume];
    
    cell.lbTime.text = [[news objectAtIndex:indexPath.row] objectForKey:@"dataPost"];;
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"details"]) {
        
        DatailsNew * DetailsViewController = segue.destinationViewController;
      //  DetailsViewController.detailsNew = [news objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //details = [news objectAtIndex:indexPath.row];
    
    //NSLog(@"details: %@", details);
    
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
