//
//  AllCouponCell.h
//  Account
//
//  Created by wang zhe on 7/22/13.
//
//

#import <UIKit/UIKit.h>

@interface AllCouponCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) IBOutlet UIImageView *discountStroreImage;
@property (strong, nonatomic) IBOutlet UILabel *discountStoreAdress;

@end
