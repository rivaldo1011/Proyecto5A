//
//  TabcontrollerViewController.h
//  Proyecto5A
//
//  Created by Mac09 on 20/04/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TabcontrollerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *srcSensores;
@property (nonatomic, strong) NSString * ussToken;
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
