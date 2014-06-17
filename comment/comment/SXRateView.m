//
//  SXRateView.m
//  comment
//
//  Created by Sam Xie on 7/15/13.
//  Copyright (c) 2013 Sam Xie. All rights reserved.
//

#import "SXRateView.h"

@implementation SXRateView

@synthesize rate1, rate2, rate3, rate4, rate5;


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setImageUnselected:(NSString *)deselectedImage partlySelected:(NSString *)partSelectedImage fullySelected:(NSString *)fullSelectedImage andDelegate:(id<SXRateViewDelegate>)d
{
    unselectedImage = [UIImage imageNamed:deselectedImage];
    partlySelectedImage = partSelectedImage == nil ? unselectedImage : [UIImage imageNamed:partSelectedImage];
    fullySelectedImage = [UIImage imageNamed:fullSelectedImage];
    viewDelegate = d;
    height = 0.0;
    width = 0.0;
    if (height < [fullySelectedImage size].height) {
        height = [fullySelectedImage size].height;
    }
    if (height < [partlySelectedImage size].height) {
        height = [partlySelectedImage size].height;
    }
    if (height < [unselectedImage size].height) {
        height = [unselectedImage size].height;
    }
    if (width < [fullySelectedImage size].width) {
        width = [fullySelectedImage size].width;
    }
    if (width < [partlySelectedImage size].width) {
        width = [partlySelectedImage size].width;
    }
    if (width < [unselectedImage size].width) {
        width = [unselectedImage size].width;
    }
    
    lastRate = 0;    
    rate1 = [[UIImageView alloc] initWithImage:unselectedImage];
    rate2 = [[UIImageView alloc] initWithImage:unselectedImage];
    rate3 = [[UIImageView alloc] initWithImage:unselectedImage];
    rate4 = [[UIImageView alloc] initWithImage:unselectedImage];
    rate5 = [[UIImageView alloc] initWithImage:unselectedImage];
    
    [rate1 setFrame:CGRectMake(0, 0, width, height)];
    [rate2 setFrame:CGRectMake(width, 0, width, height)];
    [rate3 setFrame:CGRectMake(2*width, 0, width, height)];
    [rate4 setFrame:CGRectMake(3*width, 0, width, height)];
    [rate5 setFrame:CGRectMake(4*width, 0, width, height)];
    
//    [rate1 setUserInteractionEnabled:NO];
//    [rate2 setUserInteractionEnabled:NO];
//    [rate3 setUserInteractionEnabled:NO];
//    [rate4 setUserInteractionEnabled:NO];
//    [rate5 setUserInteractionEnabled:NO];
    
    rate1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    rate2.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    rate3.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    rate4.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    rate5.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self addSubview:rate1];
    [self addSubview:rate2];
    [self addSubview:rate3];
    [self addSubview:rate4];
    [self addSubview:rate5];
    
    CGRect frame = [self frame];
    frame.size.width = width*5;
    frame.size.height = height;
    [self setFrame:frame];
//    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    self.autoresizesSubviews = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    self.transform = CGAffineTransformIdentity;
}

- (void)setImageUnselected:(NSString *)deselectedImage partlySelected:(NSString *)partSelectedImage fullySelected:(NSString *)fullSelectedImage
{
    unselectedImage = [UIImage imageNamed:deselectedImage];
    partlySelectedImage = partSelectedImage == nil ? unselectedImage : [UIImage imageNamed:partSelectedImage];
    fullySelectedImage = [UIImage imageNamed:fullSelectedImage];
    
    height = 14.0;
    width = 14.0;
    
    lastRate = 0;
    rate1 = [[UIImageView alloc] initWithImage:unselectedImage];
    rate2 = [[UIImageView alloc] initWithImage:unselectedImage];
    rate3 = [[UIImageView alloc] initWithImage:unselectedImage];
    rate4 = [[UIImageView alloc] initWithImage:unselectedImage];
    rate5 = [[UIImageView alloc] initWithImage:unselectedImage];
    
    [rate1 setFrame:CGRectMake(0, 0, width, height)];
    [rate2 setFrame:CGRectMake(width, 0, width, height)];
    [rate3 setFrame:CGRectMake(2*width, 0, width, height)];
    [rate4 setFrame:CGRectMake(3*width, 0, width, height)];
    [rate5 setFrame:CGRectMake(4*width, 0, width, height)];
    
    [rate1 setUserInteractionEnabled:NO];
    [rate2 setUserInteractionEnabled:NO];
    [rate3 setUserInteractionEnabled:NO];
    [rate4 setUserInteractionEnabled:NO];
    [rate5 setUserInteractionEnabled:NO];
    
//    rate1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    rate2.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    rate3.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    rate4.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    rate5.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self addSubview:rate1];
    [self addSubview:rate2];
    [self addSubview:rate3];
    [self addSubview:rate4];
    [self addSubview:rate5];
    
    CGRect frame = [self frame];
    frame.size.width = width*5;
    frame.size.height = height;
    [self setFrame:frame];
//    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //    self.autoresizesSubviews = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    //    self.transform = CGAffineTransformIdentity;
}

- (void)displayRate:(float)rate
{
    [rate1 setImage:unselectedImage];
    [rate2 setImage:unselectedImage];
    [rate3 setImage:unselectedImage];
    [rate4 setImage:unselectedImage];
    [rate5 setImage:unselectedImage];

    if (rate >= 0.5) {
        [rate1 setImage:partlySelectedImage];
    }
    if (rate >= 1) {
        [rate1 setImage:fullySelectedImage];
    }
    if (rate >= 1.5) {
        [rate2 setImage:partlySelectedImage];
    }
    if (rate >= 2) {
        [rate2 setImage:fullySelectedImage];
    }
    if (rate >= 2.5) {
        [rate3 setImage:partlySelectedImage];
    }
    if (rate >= 3) {
        [rate3 setImage:fullySelectedImage];
    }
    if (rate >= 3.5) {
        [rate4 setImage:partlySelectedImage];
    }
    if (rate >= 4) {
        [rate4 setImage:fullySelectedImage];
    }
    if (rate >= 4.5) {
        [rate5 setImage:partlySelectedImage];
    }
    if (rate >= 5) {
        [rate5 setImage:fullySelectedImage];
    }
    
    lastRate = rate;
    
    [viewDelegate rateChange];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self];
    float newRate = (float) (pt.x/width) + 0.5;
    if (newRate < 0 || newRate > 5.5) {
        return;
    }
    [self displayRate:newRate];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}

- (float)rate
{
    return lastRate;
}

//返回评分星星样式
- (float)filterRateOneToFive
{
    float newRate = 0.0;
    if (lastRate >= 5) {
        newRate = 5;
    }
    else if (lastRate>= 4.5)
        newRate = 4.5;
    else if (lastRate >= 4.0)
        newRate = 4.0;
    else if (lastRate >= 3.5)
        newRate = 3.5;
    else if (lastRate >= 3)
        newRate = 3;
    else if (lastRate >= 2.5)
        newRate = 2.5;
    else if (lastRate >= 2)
        newRate = 2;
    else if (lastRate >= 1.5)
        newRate = 1.5;
    else if (lastRate >= 1)
        newRate = 1;
    else if (lastRate >= 0.5)
        newRate = 0.5;
    else if (lastRate>= 0)
        newRate = 0;
    return newRate;
}


@end
