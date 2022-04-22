//
//  TabcontrollerViewController.m
//  Proyecto5A
//
//  Created by Mac09 on 20/04/22.
//

#import "TabcontrollerViewController.h"

@interface TabcontrollerViewController ()

@end

@implementation TabcontrollerViewController
@synthesize isUario,snomSensor,sDescripcion,sfechacreasion,sfechaactualizacion,sEstado,sGPIO,sIMG,sidSensor;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.ussToken);
    isUario=1;
    sidSensor = [[NSMutableArray alloc] init];
    snomSensor = [[NSMutableArray alloc] init];
    sDescripcion = [[NSMutableArray alloc] init];
    sfechacreasion = [[NSMutableArray alloc] init];
    sfechaactualizacion = [[NSMutableArray alloc] init];
    sEstado = [[NSMutableArray alloc] init];
    sGPIO = [[NSMutableArray alloc] init];
    sIMG = [[NSMutableArray alloc] init];
    [self obtenerArticulos];
    
}

//Obtiene token de sesión del servidor
- (void)obtenerTokenSesion
{
    //Setea la conexión con el host
    NSURLSession *sesion = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest * peticion = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@""]];
    
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
            
            self.ussToken = [[[json objectForKey:@"data"] objectForKey:@"auth"] objectForKey:@"token"];
            [self obtenerArticulos];
        }
    }];
    
    
    [obtenToken resume];
}
- (void)obtenerArticulos
{
    //Setea la conexión con el host
    NSURLSession *sesion = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest * peticion = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://143.244.174.46:42039/mostrarSensores"]];
        
    //Setea el cuerpo de la consulta
    NSString * bearerString = [NSString stringWithFormat:@"Bearer %@", self.ussToken];
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
            
            for (NSDictionary * datos in [json objectForKey:@"data"])
            {
                [self.sidSensor addObject:[datos objectForKey:@"idSensor"]];
                [self.snomSensor addObject:[datos objectForKey:@"Nombre"]];
                [self.sDescripcion addObject:[datos objectForKey:@"Descripcion"]];
                [self.sIMG addObject:[datos objectForKey:@"IMG"]];
                [self.sfechaactualizacion addObject:[datos objectForKey:@"Fechadecreacion"]];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                for (int i=0; i<self.sidSensor.count; i++) {
                    NSLog(@"%@",self.sidSensor[i]);
                    NSLog(@"%@",self.snomSensor[i]);
                    NSLog(@"%@",self.sDescripcion[i]);
                    NSLog(@"%@",self.sIMG[i]);
                    NSLog(@"%@",self.sfechaactualizacion[i]);
                }
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

@end
