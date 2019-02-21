//
//  ViewContato.m
//  SidebarDemo
//
//  Created by Fabricio Aguiar de Padua on 08/05/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import "ViewContato.h"
#import "SWRevealViewController.h"
#import <sys/utsname.h>


@interface ViewContato ()

@end

@implementation ViewContato

@synthesize contato;
@synthesize contarumamigo;
@synthesize site;
@synthesize pageImages;

@synthesize ViewApper;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    contato.layer.cornerRadius = 10.0f;
    contato.layer.masksToBounds = YES;
    
    contarumamigo.layer.cornerRadius = 10.0f;
    contarumamigo.layer.masksToBounds = YES;

    site.layer.cornerRadius = 10.0f;
    site.layer.masksToBounds = YES;
    
    UIImageView* imglog = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoCentraldoCafe"]];
    self.navigationItem.titleView = imglog;
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
    //	[self dismissModalViewControllerAnimated:YES];
    [self becomeFirstResponder];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)btnContato:(id)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        //[[mailer navigationBar] setTintColor:[UIColor whiteColor]];
        
        [mailer setSubject:@"Contato - App Central do Café"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"fabricio_0505_@hotmail.com", nil];
        [mailer setToRecipients:toRecipients];
        // only for iPad
        mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentViewController:mailer animated:YES completion:^{NSLog (@"Action Completed");}];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Falha"
                                                        message:@"Este dispositivo não suporta o envio de e-mail."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
}

- (IBAction)btnContarAmigo:(id)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        //[[mailer navigationBar] setTintColor:[UIColor whiteColor]];
        
        [mailer setSubject:@"App Central do Café"];
        
        NSString *emailBody = @"Olá,\n\n Estou utilizando o App Central do Café \n\n Baixe ele na Itunes.";
        
        [mailer setMessageBody:emailBody isHTML:YES];
        
        // only for iPad
        mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentViewController:mailer animated:YES completion:^{NSLog (@"Action Completed");}];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Falha"
                                                        message:@"Este dispositivo não suporta o envio de e-mail."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
}

- (IBAction)btnSite:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.promastersolution.com.br"]];
    
}
- (IBAction)btnDownload:(id)sender {
    
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

    
    
}

- (IBAction)btnBuscarDados:(id)sender {
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
