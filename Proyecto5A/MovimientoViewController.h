//
//  MovimientoViewController.h
//  Proyecto5A
//
//  Created by Mac02 on 08/04/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovimientoViewController : UIViewController
- (IBAction)btnAvansar:(id)sender;
- (IBAction)btnReversa:(id)sender;
- (IBAction)btnIZQ:(id)sender;
- (IBAction)btnDER:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *srcSensores;
@property (nonatomic, strong) NSString * uToken;
@property (nonatomic) int isUario;
@property (nonatomic, strong) NSMutableArray * sidSensor;
@property (nonatomic, strong) NSMutableArray * snomSensor;
@property (nonatomic, strong) NSMutableArray * sDescripcion;
@property (nonatomic, strong) NSMutableArray * sfechacreasion;
@property (nonatomic, strong) NSMutableArray * sfechaactualizacion;
@property (nonatomic, strong) NSMutableArray * sEstado;
@property (nonatomic, strong) NSMutableArray * sGPIO;
@property (nonatomic, strong) NSMutableArray * sIMG;
@end

NS_ASSUME_NONNULL_END
