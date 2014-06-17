//
//  CouponCell.h
//  Account
//
//  Created by wang zhe on 7/21/13.
//
//

#import <UIKit/UIKit.h>

@interface CouponCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *storeID;
@property (weak, nonatomic) IBOutlet UIImageView *storeImage;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *tel;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end
