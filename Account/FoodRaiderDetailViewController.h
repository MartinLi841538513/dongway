//
//  FoodRaiderDetailViewController.h
//  Account
//
//  Created by wang zhe on 7/25/13.
//
//

#import <UIKit/UIKit.h>
#import "UIMenuBar.h"
#import "FGalleryViewController.h"
#import "FoodRaidersModel.h"

@interface FoodRaiderDetailViewController : UIViewController<UIMenuBarDelegate,FGalleryViewControllerDelegate>

@property (strong, nonatomic) FoodRaidersModel *foodRaidersModel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
