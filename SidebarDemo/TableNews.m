//
//  TableNews.m
//  SidebarDemo
//
//  Created by Fabricio Aguiar de Padua on 29/04/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import "TableNews.h"

#import "SWRevealViewController.h"
#import "CellNews.h"
#import "DatailsNew.h"

#import "MBProgressHUD.h"

#import "SystemConfiguration/SystemConfiguration.h"
#import "Reachability.h"

@interface TableNews ()<MBProgressHUDDelegate> {
    MBProgressHUD *HUD;
    long long expectedLength;
    long long currentLength;
    UIRefreshControl *refreshControl;
}

@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) Reachability *wifiReachability;

@end

@implementation TableNews

@synthesize summaryLabel;
@synthesize remoteHostLabel;
@synthesize remoteHostStatusField;
@synthesize internetConnectionStatusField;
@synthesize localWiFiConnectionStatusField;
@synthesize ViewApper;

@synthesize pageImages;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //****** teste das conexao ******//
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
//    NSString * remoteHostName = @"www.promastersolution.com.br";
//    
//    // reachability is host avaliable.
//    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
//    [self.hostReachability startNotifier];
//    [self updateInterfaceWithReachability:self.hostReachability];
//    
//    // reachability is internet avaliable.
//    self.internetReachability = [Reachability reachabilityForInternetConnection];
//    [self.internetReachability startNotifier];
//    [self updateInterfaceWithReachability:self.internetReachability];
//    
//    // reachability is internet avaliable.
//    self.wifiReachability = [Reachability reachabilityForLocalWiFi];
//    [self.wifiReachability startNotifier];
//    [self updateInterfaceWithReachability:self.wifiReachability];
//    
//    NSString * message = [NSString stringWithFormat:@"summaryLabel: %@ \n remoteHostLabel: %@ \n remoteHostStatusField: %@ \n internetConnectionStatusField: %@ \n localWiFiConnectionStatusField: %@ \n", summaryLabel, remoteHostLabel, remoteHostStatusField, internetConnectionStatusField, localWiFiConnectionStatusField];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mesagem Conexão final" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alert show];
//    
    
    
    //******* fim da verificação das conexões ********//
    
    [ViewApper setFrame:[[UIScreen mainScreen] bounds]];
    [self.navigationController.view addSubview:ViewApper];
    self.title = @"News";
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController) {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

    
    [self Loading];
    
    

    
    
    
    
//    HUD.dimBackground = YES;
//    
//    // Regiser for HUD callbacks so we can remove it from the window at the right time
//
    
    
//    if (connetion) {
//        HUD.labelText = @"Carregando...";
//        
//    } else {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"rede Indisponível" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//   */
}

- (void) reachabilityChanged:(NSNotification *)note{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}


- (void)updateInterfaceWithReachability:(Reachability *)reachability {
    
    if (reachability == self.hostReachability) {
        [self configureTextField:self.remoteHostStatusField reachability:reachability];
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        BOOL connectionRequired = [reachability connectionRequired];
        
        if (netStatus != ReachableViaWWAN) {
            summaryLabel = @"";
        }
        NSString * baseLabelText = @"";
        
        if (connectionRequired) {
            baseLabelText = NSLocalizedString(@"Cellular data network is available.\nInternet traffic will be routed through it after a connection is established.", @"Reachability text if a connection is required");
        } else {
            baseLabelText = NSLocalizedString(@"Cellular data network is active.\nInternet traffic will be routed through it.", @"Reachability text if a connection is not required");
        }
        summaryLabel = baseLabelText;
    }
    
    if (reachability == self.internetReachability) {
        [self configureTextField:self.internetConnectionStatusField reachability:reachability];
    }
    
    if (reachability == self.wifiReachability) {
        [self configureTextField:self.localWiFiConnectionStatusField reachability:reachability];
    }
}

- (void)configureTextField:(NSString *)textField reachability:(Reachability *)reachability {
    
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL connectionRequired = [reachability connectionRequired];
    NSString * statusString = @"";
    
    switch (netStatus) {
        case NotReachable:{
            statusString = NSLocalizedString(@"Access Not Available", @"Text field text for access is not available");
            /*
             Minor interface detail- connectionRequired may return YES even when the host is unreachable. We cover that up here...
             */
            connectionRequired = NO;
            break;
        }
            
        case ReachableViaWWAN:        {
            statusString = NSLocalizedString(@"Reachable WWAN", @"");
            
            break;
        }
        case ReachableViaWiFi:        {
            statusString= NSLocalizedString(@"Reachable WiFi", @"");
            
            break;
        }
    }
    
    if (connectionRequired) {
        NSString *connectionRequiredFormatString = NSLocalizedString(@"%@, Connection Required", @"Concatenation of status string with connection requirement");
        statusString = [NSString stringWithFormat:connectionRequiredFormatString, statusString];
    }
    textField = statusString;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

-(void)Loading{
    NSURL * url = [NSURL URLWithString:@"http://www.promastersolution.com.br/x7890_IOS/revistas/cultura/newsios.php"];
    NSURLSession * session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask * task =
    [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            NSData * jsonData = [[NSData alloc] initWithContentsOfURL:location];
            news = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
                 
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
                [refreshControl endRefreshing];
            });
        }];
    [task resume];
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
    
    cell.lbTitulo.text = [[news objectAtIndex:indexPath.row] objectForKey:@"EDICAO"];
    
    cell.lbDetalhe.text = [[news objectAtIndex:indexPath.row] objectForKey:@"MODELO"];
    
    NSURL * urlImage = [NSURL URLWithString:[[news objectAtIndex:indexPath.row] objectForKey:@"URLIMAGEM"]];
   
    cell.lbTumbImage.image = [UIImage imageNamed:@"image.png"];
    
    
    cell.btnDownload.tag = [[ObjetoJson objectForKey:@"ID"] integerValue];
    [cell.btnDownload addTarget:self action:@selector(btnDownloadClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
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
    
    cell.lbTime.text = [[news objectAtIndex:indexPath.row] objectForKey:@"DETALHE"]; 
    
    return cell;
}

-(void) btnDownloadClick:(id) sender {

//    ObjetoJson = [news objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
//    
//    // iniciar o download das imagens //
//    NSString * pastaEdicao = [NSString stringWithFormat:@"Revista/%@",[ObjetoJson objectForKey:@"PASTA"]];
//    
//    NSString * URLRevista  = [ObjetoJson objectForKey:@"URLREVISTA"];
//    NSInteger npaginas     = [[ObjetoJson objectForKey:@"num_paginas"] integerValue];
//    

    NSString * pastaEdicao = @"Revista/Edicao22";
    
    NSString * URLRevista  = @"http://www.promastersolution.com.br/x7890_IOS/revistas/cultura/edicao23/";
    NSInteger npaginas     = 36;

    
    
    pageImages = [[NSMutableArray alloc] init];
    
    // verificar se a pasta não existe //
    if (![self checkIfDirectoryAlreadyExists:@"Revista"]) {
        [self criarPasta:@"Revista"];
    }
    
    if (![self checkIfDirectoryAlreadyExists:pastaEdicao]) {
        [self criarPasta:pastaEdicao];
        
        
            // montar o array das urls das imagens //
            for ( NSInteger i = 0; i < npaginas; i++){
                
                NSString * Contador = [NSString stringWithFormat:@"%.3ld", (long)i + 1];
                
                NSString * UrlMontadada = [NSString stringWithFormat:@"%@/%@.png", URLRevista, Contador];
                
                [self downloadImageFromURL:UrlMontadada : pastaEdicao];
                
            }
            
        
        NSLog(@"Array: %@ ", pageImages);
        
        
    } else {
        
        //[self buscarDados:pastaEdicao];
        
        
        NSLog(@"Array: %@ ", pageImages);
        
        // se foi feito o download buscar na pasta //
        
    }

    
    
    
    
    
//    
//    UIButton * senderButton = (UIButton *) sender ;
//    NSLog(@"Row: ")
//
    NSLog(@"Botao Clicado:" );

}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"details"]) {
        
        // perguntar se quer fazer o donwload //
        
                
       // _pageImages = [_Pages copy];
      
        DatailsNew * DetailsViewController = segue.destinationViewController;
        DetailsViewController.ObjetoJson = [news objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        
    }
}

-(void) criarPasta:(NSString * ) pasta {
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:pasta];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
}



-(BOOL)checkIfDirectoryAlreadyExists:(NSString *)name{
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:name];
    
    BOOL isDir;
    BOOL fileExists = [fileManager fileExistsAtPath:dataPath isDirectory:&isDir];
    
    if (fileExists){
        NSLog(@"Existe Arquivo...");
        
        if (isDir) {
            NSLog(@"Folder already exists...");
        }
    }
    return fileExists;
}

-(void) downloadImageFromURL :(NSString *)imageUrl  :(NSString * )Pasta{
    //download the file in a seperate thread.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul), ^{
        
        NSURL  *url = [NSURL URLWithString:imageUrl];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        if ( urlData ) {
            
            // pega o nome do arquivo //
            NSArray *parts = [imageUrl componentsSeparatedByString:@"/"];
            NSString *filename = [parts lastObject];
            
            // busca a pasta oficial do App //
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            
            // add na frente da pasta ofical o caminho ex: /Revista/Edicao22  //
            NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:Pasta];
            // monta o caminho para ser salvo os aquivos //
            NSString *filePath = [NSString stringWithFormat:@"%@/%@", dataPath, filename];
            // salva os aquivos na pasta //
            //saving is done on main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                [urlData writeToFile:filePath atomically:YES];
                [pageImages addObject:filePath];
            });
            
        } else {
            NSLog(@"Erro no download...");
        }
    });
    
}


//- (void)verificarArquivos {
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    //NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:pastaEdicao];
//    
//    NSArray * dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dataPath error:NULL];
//    [dirs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        NSString *filename = (NSString *)obj;
//        NSString *extension = [[filename pathExtension] lowercaseString];
//        if ([extension isEqualToString:@"png"]) {
//            [pageImages addObject:[dataPath stringByAppendingPathComponent:filename]];
//        }
//    }];
//    
//    NSLog(@"Array: %@ ", pageImages);
//    
//    
//}











@end
