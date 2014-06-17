//
//  SXViewController.h
//  comment
//
//  Created by Sam Xie on 7/15/13.
//  Copyright (c) 2013 Sam Xie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXRateView.h"
#import "MyDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "MyDelegate.h"


@interface MakeStoreCommentViewController : UIViewController<UITextViewDelegate, SXRateViewDelegate>

@property (nonatomic, retain) IBOutlet SXRateView *scoreRateView;
@property (nonatomic, retain) IBOutlet UILabel *scoreLabel;
@property (retain, nonatomic) IBOutlet SXRateView *serviceRateView;
@property (weak, nonatomic) IBOutlet UILabel *serviceLabel;
@property (retain, nonatomic) IBOutlet SXRateView *environmentRateView;
@property (weak, nonatomic) IBOutlet UILabel *environmentLabel;
@property (retain, nonatomic) IBOutlet SXRateView *tasteRateView;
@property (weak, nonatomic) IBOutlet UILabel *tasteLabel;
@property (weak, nonatomic)IBOutlet UITextField *priceField;
@property (weak, nonatomic) IBOutlet UITextView *commentField;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)commitButton:(UIButton *)sender;


@property (weak, nonatomic) NSObject<MyDelegate> *doSomethingDelegate;
@property (weak, nonatomic) NSString *storeId;


- (void)rateChange;

@end
