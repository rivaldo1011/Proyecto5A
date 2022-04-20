//
//  MovimientoViewController.m
//  Proyecto5A
//
//  Created by Mac02 on 08/04/22.
//

#import "MovimientoViewController.h"
//SDWebImage/UIImageView+WebCache.h
#import <SDWebImage/UIImageView+WebCache.h>
@interface MovimientoViewController ()

@end

@implementation MovimientoViewController
@synthesize isUario,snomSensor,sDescripcion,sfechacreasion,sfechaactualizacion,sEstado,sGPIO,sIMG,sidSensor;
- (void)viewDidLoad {
    [super viewDidLoad];
    isUario=1;
    sidSensor = [[NSMutableArray alloc] init];
    snomSensor = [[NSMutableArray alloc] init];
    sDescripcion = [[NSMutableArray alloc] init];
    sfechacreasion = [[NSMutableArray alloc] init];
    sfechaactualizacion = [[NSMutableArray alloc] init];
    sEstado = [[NSMutableArray alloc] init];
    sGPIO = [[NSMutableArray alloc] init];
    sIMG = [[NSMutableArray alloc] init];
    [self obtenerTokenSesion];
}
//Obtiene token de sesión del servidor
- (void)obtenerTokenSesion
{
    //Setea la conexión con el host
    NSURLSession *sesion = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest * peticion = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.vanko.mx/v1/auth/login"]];
    
    //Setea el cuerpo de la petición
    NSError * error;
    NSString * UUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSDictionary * body = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",nil];
    NSData * bodyRequest = [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error:&error];
    peticion.HTTPBody = bodyRequest;
        
    //Setea el cuerpo de la consulta
    [peticion setValue: @"application/json" forHTTPHeaderField:@"Content-Type"];
    peticion.HTTPMethod = @"POST";

    
    NSURLSessionDataTask *obtenToken = [sesion dataTaskWithRequest:peticion completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
     
    {
        NSDictionary * json;
        
        if (data == nil)
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController * alerta = [UIAlertController alertControllerWithTitle:@"ERROR" message:@"Imposible conectarse al servidor" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * ok = [UIAlertAction actionWithTitle:@"Aceptar" style:UIAlertActionStyleCancel handler:nil];
                
                [alerta addAction:ok];
                [self presentViewController:alerta animated:YES completion:nil];
            });
        else
        {
            json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            self.uToken = [[[json objectForKey:@"data"] objectForKey:@"auth"] objectForKey:@"token"];
            [self obtenerArticulos];
        }
    }];
    
    [obtenToken resume];
}
- (void)obtenerArticulos
{
    //Setea la conexión con el host
    NSURLSession *sesion = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest * peticion = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://127.0.0.1:3333/smostrarSensores"]];
        
    //Setea el cuerpo de la consulta
    NSString * bearerString = [NSString stringWithFormat:@"Bearer %@", self.uToken];
    [peticion setValue: bearerString forHTTPHeaderField:@"Authorization"];
    peticion.HTTPMethod = @"GET";

    
    NSURLSessionDataTask *obtenArticulos = [sesion dataTaskWithRequest:peticion completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSDictionary * json;
        
        if (data == nil)
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController * alerta = [UIAlertController alertControllerWithTitle:@"ERROR" message:@"Imposible conectarse al servidor" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * ok = [UIAlertAction actionWithTitle:@"Aceptar" style:UIAlertActionStyleCancel handler:nil];
                
                [alerta addAction:ok];
                [self presentViewController:alerta animated:YES completion:nil];
            });
        else
        {
            json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"%@",json);
            for (NSDictionary * datos in json)
            {
                [self.sidSensor addObject:[datos objectForKey:@"idSensor"]];
                [self.snomSensor addObject:[datos objectForKey:@"NombreSensor"]];
                [self.sDescripcion addObject:[datos objectForKey:@"Descripcion"]];
                [self.sfechacreasion addObject:[datos objectForKey:@"Fechadecreacion"]];
                [self.sfechaactualizacion addObject:[datos objectForKey:@"Fechadeactualisacion"]];
                [self.sEstado addObject:[datos objectForKey:@"Estado"]];
                [self.sGPIO addObject:[datos objectForKey:@"GPIO"]];
                [self.sIMG addObject:[datos objectForKey:@"IMG"]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dibujarArticulos];
            });
        }
    }];
    
    [obtenArticulos resume];
}
- (void)dibujarArticulos
{
    int posY = 0;

    for (int i = 0; i < snomSensor.count; i++, posY += 110)
    {
        UIView * vwsensores = [[UIView alloc] initWithFrame:CGRectMake(10, posY, self.view.frame.size.width - 20, 100)];
        vwsensores.backgroundColor = [UIColor lightGrayColor];
        
        UILabel * lblsnomSensor = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, vwsensores.frame.size.width - 105, 55)];
        lblsnomSensor.text = snomSensor[i];
        [lblsnomSensor setTextColor:[UIColor blackColor]];
        [lblsnomSensor setFont:[UIFont boldSystemFontOfSize:23]];
        lblsnomSensor.numberOfLines = 2;
        /*
        UILabel * lblAutor = [[UILabel alloc] initWithFrame:CGRectMake(100, 65, vwArticulo.frame.size.width - 105, 30)];
        lblAutor.text = autores[i];
        [lblAutor setTextColor:[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1.0]];
        [lblAutor setFont:[UIFont systemFontOfSize:22]];
        lblAutor.textAlignment = NSTextAlignmentRight;
        
        UIImageView * imvArticulo = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 90, 90)];
        [imvArticulo sd_setImageWithURL:imagenes[i]];
        imvArticulo.contentMode = UIViewContentModeScaleAspectFit;
        */
        UIButton * btnDetalle = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, vwsensores.frame.size.width, vwsensores.frame.size.height)];
        btnDetalle.tag = i;
        //[btnDetalle addTarget:self action:@selector(mandarDetalle:) forControlEvents:UIControlEventTouchUpInside];
        
        [vwsensores addSubview:lblsnomSensor];
        //[vwsensores addSubview:imvArticulo];
        //[vwsensores addSubview:lblAutor];
        //[vwsensores addSubview:btnDetalle];
        [self.srcSensores addSubview:vwsensores];
    }
    
    self.srcSensores.contentSize = CGSizeMake(0, posY);
}
- (IBAction)btnDER:(id)sender {
}

- (IBAction)btnIZQ:(id)sender {
}

- (IBAction)btnReversa:(id)sender {
}

- (IBAction)btnAvansar:(id)sender {
}
@end
