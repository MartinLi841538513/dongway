//
//  StoresCollectionCell.h
//  Account
//
//  Created by wang zhe on 7/19/13.
//
//

#import <UIKit/UIKit.h>

@interface StoresCollectionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *storePrice;
@property (weak, nonatomic) IBOutlet UILabel *storeNumber;
@property (weak, nonatomic) IBOutlet UILabel *storeAddress;
@property (weak, nonatomic) IBOutlet UIImageView *storeScore;

@end
