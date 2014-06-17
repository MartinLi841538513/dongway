//
//  FoodRaidersCell.h
//  Account
//
//  Created by wang zhe on 7/21/13.
//
//

#import <UIKit/UIKit.h>

@interface FoodRaidersCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *imageUrl;
@property (weak, nonatomic) IBOutlet UILabel *typeName;
@property (weak, nonatomic) IBOutlet UILabel *source;
@property (weak, nonatomic) IBOutlet UILabel *tag1;
@property (weak, nonatomic) IBOutlet UILabel *foodAbstract;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (strong, nonatomic) IBOutlet UIImageView *shareImageView;
@property (strong, nonatomic) IBOutlet UIImageView *shareWith;
@property (strong, nonatomic) IBOutlet UILabel *shareLabel;
@end
