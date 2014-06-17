//
//  OrderCell.h
//  Account
//
//  Created by wang zhe on 7/21/13.
//
//

#import <UIKit/UIKit.h>

@interface OrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderID;
@property (weak, nonatomic) IBOutlet UILabel *orderedUsername;
@property (weak, nonatomic) IBOutlet UILabel *orderedPhone;
@property (weak, nonatomic) IBOutlet UILabel *orderedTime;
@property (weak, nonatomic) IBOutlet UILabel *orderedDetail;
@property (weak, nonatomic) IBOutlet UILabel *orderedAddress;
@property (weak, nonatomic) IBOutlet UILabel *orderedStorePhone;
@property (weak, nonatomic) IBOutlet UILabel *orderedStoreName;
@property (strong, nonatomic) IBOutlet UILabel *tips;



@end
