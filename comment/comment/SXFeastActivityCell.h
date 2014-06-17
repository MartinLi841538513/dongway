//
//  SXFeastActivityCell.h
//  Account
//
//  Created by Sam Xie on 8/22/13.
//
//

#import <UIKit/UIKit.h>

@interface SXFeastActivityCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleInCell;
@property (strong, nonatomic) IBOutlet UILabel *activityTimeInCell;
@property (strong, nonatomic) IBOutlet UILabel *addressInCell;
@property (strong, nonatomic) IBOutlet UILabel *peopleNumberInCell;
@property (strong, nonatomic) IBOutlet UILabel *statusInCell;
@property (strong, nonatomic) IBOutlet UILabel *contentInCell;
@property (strong, nonatomic) IBOutlet UILabel *createTimeInCell;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewInCell;
@property (strong, nonatomic) IBOutlet UIImageView *priseImageView;
@property (strong, nonatomic) IBOutlet UILabel *priseLabel;
@property (strong, nonatomic) IBOutlet UIImageView *shareImageView;
@property (strong, nonatomic) IBOutlet UIImageView *shareWith;
@property (strong, nonatomic) IBOutlet UILabel *shareLabel;

@end
