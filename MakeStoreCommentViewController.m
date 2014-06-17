//
//  SXViewController.m
//  comment
//
//  Created by Sam Xie on 7/15/13.
//  Copyright (c) 2013 Sam Xie. All rights reserved.
//

#import "MakeStoreCommentViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "SVProgressHUD.h"
#import "CommentsModel.h"
#import "GlobalVariateModel.h"
#import "UserInfosModel.h"
#import "Common.h"

@interface MakeStoreCommentViewController () {
    
    CommentsModel *commentsModel;
    GlobalVariateModel *globalVariateModel;
    UserInfosModel *userInfosModel;
    Common *common;
}

@end

@implementation MakeStoreCommentViewController

@synthesize storeId;


- (void)viewDidLoad
{
    [super viewDidLoad];
    common = [[Common alloc] init];
    commentsModel = [[CommentsModel alloc] init];
    globalVariateModel = [[GlobalVariateModel alloc] init];
    userInfosModel = [[UserInfosModel alloc] init];
    [userInfosModel setPropertysWithDictionary:[globalVariateModel userInfos]];

    [common returnButton:self];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"用户评论";
    [_scoreRateView setImageUnselected:@"unselected.png" partlySelected:@"partlySelected.png" fullySelected:@"fullySelected.png" andDelegate:self];
    [_scoreRateView displayRate:5];
    [_serviceRateView setImageUnselected:@"unselected.png" partlySelected:@"partlySelected.png" fullySelected:@"fullySelected.png" andDelegate:self];
    [_serviceRateView displayRate:5];
    [_environmentRateView setImageUnselected:@"unselected.png" partlySelected:@"partlySelected.png" fullySelected:@"fullySelected.png" andDelegate:self];
    [_environmentRateView displayRate:5];
    [_tasteRateView setImageUnselected:@"unselected.png" partlySelected:@"partlySelected.png" fullySelected:@"fullySelected.png" andDelegate:self];
    [_tasteRateView displayRate:5];
    _commentField.delegate = self;
    
    
    self.scrollView.userInteractionEnabled = YES;
    UITapGestureRecognizer *scrollViewAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTap:)];
    [self.scrollView addGestureRecognizer:scrollViewAction];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SXRateView delegate methods

- (void)rateChange
{
    
    [_commentField resignFirstResponder];
    [_priceField resignFirstResponder];
    float newRate = [self compareRate:[_scoreRateView rate]];
    _scoreLabel.text = [NSString stringWithFormat:@"%1.1f", newRate];
    float newRate1 = [self compareRate:[_serviceRateView rate]];
    _serviceLabel.text = [NSString stringWithFormat:@"%1.1f", newRate1];
    float newRate2 = [self compareRate:[_environmentRateView rate]];
    _environmentLabel.text = [NSString stringWithFormat:@"%1.1f", newRate2];
    float newRate3 = [self compareRate:[_tasteRateView rate]];
    _tasteLabel.text = [NSString stringWithFormat:@"%1.1f", newRate3];
}

#pragma mark - self methods

//generate commentID using md5
- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    NSMutableString *hash = [NSMutableString stringWithCapacity:16];
    for (int i = 0; i < 16; i ++) {
        [hash appendString:[NSString stringWithFormat:@"%x", result[i]]];
    }
    return hash;
}

//submit the comment after verifying input data
- (IBAction)commitButton:(UIButton *)sender {
    NSString *regex = @"[0-9]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![predicate evaluateWithObject:_priceField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入数字" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [_priceField becomeFirstResponder];
    }
    else if ([_commentField.text length] < 5) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入不少于5字的评论内容" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [_commentField becomeFirstResponder];
    }
    else
    {
        [SVProgressHUD show];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSDate *lastUpdateTime_Date = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-mm-dd"];
            NSString *lastUpdateTime = [dateFormatter stringFromDate:lastUpdateTime_Date];
            NSString *comment = _commentField.text;
            NSString *username = userInfosModel.userName;
            NSString *score = _scoreLabel.text;
            NSString *taste = _tasteLabel.text;
            NSString *environment = _environmentLabel.text;
            NSString *service = _serviceLabel.text;
            NSString *price = _priceField.text;
            NSString *commentID_MD5 = [NSString stringWithFormat:@"%@%@%@%@", username, comment, storeId, lastUpdateTime];
            NSString *commentID = [self md5:commentID_MD5];
            [commentsModel addCommentWithCat:@"1" andStoreID:storeId andCommentID:commentID andComment:comment andScore:score andUsername:username andTaste:taste andEnvironment:environment andService:service andPrice:price];
            NSArray *commentsArray = commentsModel.comments;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
                if ([commentsArray count] > 0)
                {
                    [SVProgressHUD showSuccessWithStatus:@"评论成功"];
                    if(self.doSomethingDelegate)
                    {
                        [self.doSomethingDelegate dosomething];
                    }
                    [self.navigationController popViewControllerAnimated:YES];

                }
                else
                {
                    [SVProgressHUD showSuccessWithStatus:@"评论失败"];
                }
            });
        });
    }
}

- (void)backgroundTap:(UIControl *)sender {
    [_commentField resignFirstResponder];
    [_priceField resignFirstResponder];
}

- (void)viewDidUnload {
    [self setPriceField:nil];
    [self setCommentField:nil];
    [self setScoreRateView:nil];
    [self setScoreLabel:nil];
    [self setServiceRateView:nil];
    [self setServiceLabel:nil];
    [self setEnvironmentRateView:nil];
    [self setEnvironmentLabel:nil];
    [self setTasteLabel:nil];
    [self setTasteRateView:nil];
    [super viewDidUnload];
}

//返回评分星星样式
- (float)compareRate:(float)rate
{
    float newRate = 0.0;
    if (rate >= 5) {
        newRate = 5;
    }
    else if (rate>= 4.5)
        newRate = 4.5;
    else if (rate >= 4.0)
        newRate = 4.0;
    else if (rate >= 3.5)
        newRate = 3.5;
    else if (rate >= 3)
        newRate = 3;
    else if (rate >= 2.5)
        newRate = 2.5;
    else if (rate >= 2)
        newRate = 2;
    else if (rate >= 1.5)
        newRate = 1.5;
    else if (rate >= 1)
        newRate = 1;
    else if (rate >= 0.5)
        newRate = 0.5;
    else if (rate>= 0)
        newRate = 0;
    return newRate;
}

#pragma mark - TextViewDelegate methods

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.commentField.text = @"";
}

- (void) textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
}

- (void) textViewDidChange:(UITextView *)textView
{

}


@end
