//
//  SXRateView.h
//  comment
//
//  Created by Sam Xie on 7/15/13.
//  Copyright (c) 2013 Sam Xie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SXRateViewDelegate

@optional
- (void)rateChange;

@end

@interface SXRateView : UIView {
    UIImageView *rate1, *rate2, *rate3, *rate4, *rate5;
    UIImage *unselectedImage, *partlySelectedImage, *fullySelectedImage;
    id<SXRateViewDelegate> viewDelegate;
    float lastRate;
    float height, width;
}

@property (nonatomic, retain) UIImageView *rate1;
@property (nonatomic, retain) UIImageView *rate2;
@property (nonatomic, retain) UIImageView *rate3;
@property (nonatomic, retain) UIImageView *rate4;
@property (nonatomic, retain) UIImageView *rate5;

- (void) setImageUnselected:(NSString *)deselectedImage partlySelected:(NSString *)partSelectedImage fullySelected:(NSString *)fullSelectedImage andDelegate:(id<SXRateViewDelegate>)d;
- (void) setImageUnselected:(NSString *)deselectedImage partlySelected:(NSString *)partSelectedImage fullySelected:(NSString *)fullSelectedImage;
-(void) displayRate:(float) rate;
-(float) rate;
- (float)filterRateOneToFive;
@end
