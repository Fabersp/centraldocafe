//
//  CellNews.h
//  SidebarDemo
//
//  Created by Fabricio Aguiar de Padua on 29/04/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellNews : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbTitulo;
@property (weak, nonatomic) IBOutlet UILabel *lbDetalhe;
@property (weak, nonatomic) IBOutlet UIImageView *lbTumbImage;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;

@property (weak, nonatomic) IBOutlet UIButton *btnDownload;



@end
