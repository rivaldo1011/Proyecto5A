//
//  MovimientoViewController.m
//  Proyecto5A
//
//  Created by Mac02 on 08/04/22.
//

#import "TabcontrollerViewController.h"
#import "MovimientoViewController.h"
//SDWebImage/UIImageView+WebCache.h
#import <SDWebImage/UIImageView+WebCache.h>
@interface MovimientoViewController ()

@end

@implementation MovimientoViewController
@synthesize ussToken,token;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mvkControl loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://143.244.174.46"]]];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"Listsensores"]){
        MovimientoViewController*sgToken=[segue destinationViewController];
        sgToken.ussToken=[self token];//Llistsensores
    }
    
}

@end
