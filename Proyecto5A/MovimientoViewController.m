//
//  MovimientoViewController.m
//  Proyecto5A
//
//  Created by Mac02 on 08/04/22.
//

#import "MovimientoViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface MovimientoViewController ()

@end

@implementation MovimientoViewController
@synthesize susuario,snomSensor,sDescripcion,sfechacreasion,sfechaactualizacion,sEstado,sGPIO,sIMG;
- (void)viewDidLoad {
    [super viewDidLoad];
    susuario = [[NSMutableArray alloc] init];
    snomSensor = [[NSMutableArray alloc] init];
    sDescripcion = [[NSMutableArray alloc] init];
    sfechacreasion = [[NSMutableArray alloc] init];
    sfechaactualizacion = [[NSMutableArray alloc] init];
    sEstado = [[NSMutableArray alloc] init];
    sGPIO = [[NSMutableArray alloc] init];
    sIMG = [[NSMutableArray alloc] init];
    
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
