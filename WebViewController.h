//
//  WebViewController.h
//  Account
//
//  Created by dongway on 13-12-4.
//
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSString *urlString;
@end
