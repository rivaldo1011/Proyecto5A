//
//  LoginViewController.m
//  Proyecto5A
//
//  Created by Mac02 on 11/04/22.
//

#import "LoginViewController.h"
#import "WebViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize webs, datos;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    webs = [NSArray arrayWithObjects:@"https://www.acdc.com", nil];
    datos = [Datos sharedDatos];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WebViewController * vc = segue.destinationViewController;
    
    //vc.urlWeb = webs[indice];
}

@end

