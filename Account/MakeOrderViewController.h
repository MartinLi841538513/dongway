//
//  MakeOrderViewController.h
//  Account
//
//  Created by wang zhe on 7/23/13.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "StoresModel.h"

@interface MakeOrderViewController : UIViewController<UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *hallRadio;
@property (weak, nonatomic) IBOutlet UILabel *hallText;
@property (weak, nonatomic) IBOutlet UIImageView *roomRadio;
@property (weak, nonatomic) IBOutlet UILabel *roomText;
@property (weak, nonatomic) IBOutlet UIImageView *lunch;
@property (weak, nonatomic) IBOutlet UILabel *lunchText;
@property (weak, nonatomic) IBOutlet UIImageView *dinner;
@property (weak, nonatomic) IBOutlet UILabel *dinnerText;
- (IBAction)goToSelectDate:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *date;
@property (strong, nonatomic) IBOutlet UITableView *tableShowView;
@property (strong, nonatomic) IBOutlet UIImageView *findTableTipView;

- (IBAction)findSeat:(id)sender;

@property (weak, nonatomic) StoresModel *storesModel;
@end
