//
//  WebViewController.m
//  Proyecto5A
//
//  Created by Mac02 on 11/04/22.
//

#import "WebViewController.h"


@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.mvkRegistrar loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://143.244.174.46"]]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)btnRegresar
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
