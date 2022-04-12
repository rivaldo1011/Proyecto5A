//
//  WebViewController.h
//  Proyecto5A
//
//  Created by Mac02 on 11/04/22.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : UIViewController <WKNavigationDelegate>
@property (nonatomic, strong) NSString * urlWeb;
@property (weak, nonatomic) IBOutlet WKWebView *mvkRegistrar;

- (IBAction)btnRegresar;

@end

NS_ASSUME_NONNULL_END
