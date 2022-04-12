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
@property (nonatomic, strong) NSString * token;
@property (nonatomic, strong) NSMutableArray * sensores;
@end

NS_ASSUME_NONNULL_END
