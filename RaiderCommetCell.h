//
//  RaiderCommetCell.h
//  Account
//
//  Created by wang zhe on 8/2/13.
//
//

#import <UIKit/UIKit.h>

@interface RaiderCommetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageUrl;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userTitle;
@property (weak, nonatomic) IBOutlet UILabel *commentContent;
@property (weak, nonatomic) IBOutlet UILabel *createTime;

@end
