//
//  LoginViewController.h
//  Proyecto5A
//
//  Created by Mac02 on 11/04/22.
//

#import <UIKit/UIKit.h>
#import "Datos.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController
@property (nonatomic, strong) NSArray * webs;
@property (nonatomic, strong) Datos * datos;
@property (nonatomic, strong) NSString * txvusuario;
@property (nonatomic, strong) NSString * token;
@property (weak, nonatomic) IBOutlet UITextField *ltxvCorreo;
@property (weak, nonatomic) IBOutlet UITextField *ltxvPassword;
- (IBAction)btnInicioSesion;
@property (nonatomic, strong) NSString * txvcontrasena;
@end

NS_ASSUME_NONNULL_END
