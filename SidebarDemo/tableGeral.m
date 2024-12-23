//
//  Geral.m
//  SidebarDemo
//
//  Created by Fabricio Aguiar de Padua on 08/05/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import "tableGeral.h"

#import "SWRevealViewController.h"
#import "CellNews.h"
#import "DatailsNew.h"

@interface tableGeral ()


@end

@implementation tableGeral

@synthesize ViewApper;


- (void)viewDidLoad {
    [super viewDidLoad];
    [ViewApper setFrame:[[UIScreen mainScreen] bounds]];
    
    [self.navigationController.view addSubview:ViewApper];
    
    // [self.view addSubview:ViewApper];
    
    self.title = @"Geral";
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
//    NSURL * url = [NSURL URLWithString:@"http://www.promastersolution.com.br/x7890_IOS/central/geral.php"];
    
//    NSURLSession * session = [NSURLSession sharedSession];
    
//    NSURLSessionDownloadTask * task = [session downloadTaskWithURL:url
//                                                 completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
//                                                     
//                                                     NSData * jsonData = [[NSData alloc] initWithContentsOfURL:location];
//                                                     news = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
//                                                     
//                                                     dispatch_async(dispatch_get_main_queue(), ^{
//                                                         [self.tableView reloadData];
//                                                         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//                                                     });
//                                                     
//                                                 }];
//    [task resume];
    
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
withString:@" "];
    cell.lbDetalhe.numberOfLines = 5;
    [cell.lbDetalhe sizeToFit];
    cell.lbDetalhe.lineBreakMode = NSLineBreakByWordWrapping;
    
    cell.lbTime.text = [[news objectAtIndex:indexPath.row] objectForKey:@"dataPost"];;
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"details"]) {
        
        DatailsNew * DetailsViewController = segue.destinationViewController;
       // DetailsViewController.detailsNew = [news objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
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
