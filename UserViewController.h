//
//  userViewController.h
//  Account
//
//  Created by wang zhe on 7/16/13.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIMenuBar.h"
@interface UserViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIMenuBarDelegate>
{
    
}

@property (weak, nonatomic) IBOutlet UILabel *userTitle;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UIImageView *imageUrl;

@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;


@end
