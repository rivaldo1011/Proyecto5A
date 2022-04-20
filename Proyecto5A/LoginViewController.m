//
//  LoginViewController.m
//  Proyecto5A
//
//  Created by Mac02 on 11/04/22.
//

#import "LoginViewController.h"
#import "WebViewController.h"
#import "MovimientoViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize webs, datos,ltxvCorreo,ltxvPassword,token;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    webs = [NSArray arrayWithObjects:@"http://127.0.0.1:3333/Login", nil];
    datos = [Datos sharedDatos];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"Movimiento"]){
        MovimientoViewController*sgToken=[segue destinationViewController];
        sgToken.ussToken=[self token];//Llistsensores
    }
}
-(IBAction)btnInicioSesion {
   //Setea la conexión con el host
   NSURLSession *sesion =
   [NSURLSession sessionWithConfiguration:
   [NSURLSessionConfiguration
   defaultSessionConfiguration]];
   NSMutableURLRequest * peticion =
   [NSMutableURLRequest requestWithURL:
   [NSURL URLWithString:@"http://143.244.174.46:33285/Login"]];

   //Setea el cuerpo de la petición
   NSError * error;

   NSDictionary * body = [NSDictionary
   dictionaryWithObjectsAndKeys:self.ltxvPassword.text,@"password",self.ltxvCorreo.text,@"email",nil];
   NSData * bodyRequest =
   [NSJSONSerialization
   dataWithJSONObject:body
   options:NSJSONWritingPrettyPrinted
   error:&error];
   peticion.HTTPBody = bodyRequest;

   //Setea el cuerpo de la consulta
   [peticion setValue: @"application/json"
   forHTTPHeaderField:@"Content-Type"];
   peticion.HTTPMethod = @"POST";

   NSURLSessionDataTask *iniciarsesion =
   [sesion dataTaskWithRequest:peticion
   completionHandler:^(NSData *data,
   NSURLResponse *response, NSError
   *error)
   {
   NSDictionary * json;

   if (data == nil)

   dispatch_async(dispatch_get_main_queue(),
   ^{

   UIAlertController * alerta =

   [UIAlertController
   alertControllerWithTitle:@"ERROR"
   message:@"Imposible conectarse al servidor"
   preferredStyle:UIAlertControllerStyleAlert];
   UIAlertAction * ok = [UIAlertAction

   actionWithTitle:@"Aceptar"
   style:UIAlertActionStyleCancel handler:nil];

   [alerta addAction:ok];
   [self presentViewController:alerta

   animated:YES completion:nil];

   });
   else
   {
   json = [NSJSONSerialization

   JSONObjectWithData:data
   options:NSJSONReadingAllowFragments
   error:nil];
       self.token=[json objectForKey:@"token"];
       
       NSLog(@"%@",self.token);
       
       if (self.token == nil) {
           NSLog(@"No permitido");
           
           dispatch_async(dispatch_get_main_queue(),
           ^{

           UIAlertController * alertalogin =

           [UIAlertController
           alertControllerWithTitle:@"ERROR"
           message:@"Email o Password incorrectos"
           preferredStyle:UIAlertControllerStyleAlert];
           UIAlertAction * ok = [UIAlertAction

           actionWithTitle:@"Aceptar"
           style:UIAlertActionStyleCancel handler:nil];

           [alertalogin addAction:ok];
           [self presentViewController:alertalogin

           animated:YES completion:nil];

           });
           
       }
       else{
           if(self.token != nil)
           {
           NSLog(@"shi");
           dispatch_async(dispatch_get_main_queue(),
           ^{
           [self performSegueWithIdentifier:@"Movimiento" sender:nil];
           });
           }
           
       }
   }
   }];
   [iniciarsesion resume];
}
@end

