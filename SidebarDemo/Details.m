//
//  Details.m
//  SidebarDemo
//
//  Created by Fabricio Aguiar de Padua on 09/05/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import "Details.h"

@interface Details ()

@end

@implementation Details@synthesize imageFull;
@synthesize lbDetailsPublish;
@synthesize lbTextFull;
@synthesize detailsNew;
@synthesize lbtitle;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView* imglog = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoCentraldoCafe"]];
    self.navigationItem.titleView = imglog;
    
    
    NSString * Concat = [NSString stringWithFormat:@"Publicado por %@ | Edital %@ | %@ ", [detailsNew objectForKey:@"postBy"], [detailsNew objectForKey:@"editorial"], [detailsNew objectForKey:@"dataPost"]];
    
    lbDetailsPublish.text = Concat;
    
    lbtitle.text = [detailsNew objectForKey:@"titulo"];
    lbtitle.numberOfLines = 2;
    [lbtitle sizeToFit];
    lbtitle.lineBreakMode = NSLineBreakByWordWrapping;
    
    lbTextFull.text  = [[detailsNew objectForKey:@"news"] stringByReplacingOccurrencesOfString:@"<br />"
                                                                                    withString:@" "];
    NSURL *url = [NSURL URLWithString:[detailsNew objectForKey:@"image"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [UIImage imageWithData:data];
    
    imageFull.image = img;
    
    [self.view addSubview:lbTextFull];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
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
