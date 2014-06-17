//
//  SXStoreCell.h
//  Account
//
//  Created by Sam Xie on 8/20/13.
//
//

#import <UIKit/UIKit.h>

@interface SXStoreCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UIImageView *scoreRate;
@property (strong, nonatomic) IBOutlet UILabel *orderSymbol;
@property (strong, nonatomic) IBOutlet UILabel *discountSymbol;
@property (weak, nonatomic) IBOutlet UILabel *priceInCell;
@property (weak, nonatomic) IBOutlet UILabel *distanceInCell;
@property (weak, nonatomic) IBOutlet UILabel *addressInCell;
//@property (strong, nonatomic) IBOutlet UITableViewCell *storeCell;

@end
