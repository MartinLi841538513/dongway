//
//  CardIntroduceViewController.h
//  Account
//
//  Created by dongway on 13-11-3.
//
//

#import <UIKit/UIKit.h>

@interface CardIntroduceViewController : UIViewController
- (IBAction)switchToCardView:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UILabel *goToBuyCard;
@end
