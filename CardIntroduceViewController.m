//
//  CardIntroduceViewController.m
//  Account
//
//  Created by dongway on 13-11-3.
//
//

#import "CardIntroduceViewController.h"
#import "CardViewController.h"
#import "Common.h"
#import "UserInfosModel.h"
#import "CardHighLightViewController.h"
#import "GlobalVariateModel.h"

@interface CardIntroduceViewController ()
{
    Common *common;
    UserInfosModel *userInfosModel;
    GlobalVariateModel *globalVariateModel;
}

@end

@implementation CardIntroduceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //这是返回按钮用图片表示的一种做法
    common = [[Common alloc] init];
    globalVariateModel = [[GlobalVariateModel alloc] init];
    userInfosModel = [[UserInfosModel alloc] init];
    [common returnButton:self];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"美食达人卡";
    
    [self.scrollView setContentSize:CGSizeMake(320, 600)];
    self.goToBuyCard.userInteractionEnabled = YES;
    UITapGestureRecognizer *goToBuyCardButton = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToBuyCardAction:)];
    [self.goToBuyCard addGestureRecognizer:goToBuyCardButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)switchToCardView:(id)sender {
    
    if([common judgeUserIsLoginOrNot:self] == NO)
        return;
    [userInfosModel setPropertysWithDictionary:globalVariateModel.userInfos];
    
    NSString *isVIP = userInfosModel.is_vip;
    //0表示没有绑定达人卡，1表示已经绑定了达人卡
    if([isVIP isEqualToString:@"0"])
    {
        CardViewController *cardViewController = [[CardViewController alloc] initWithNibName:@"CardViewController" bundle:nil];
        [self.navigationController pushViewController:cardViewController animated:YES];
    }
    else if([isVIP isEqualToString:@"1"])
    {
        CardHighLightViewController *cardViewCotroller = [[CardHighLightViewController alloc] initWithNibName:@"CardHighLightViewController" bundle:nil];
        cardViewCotroller.userInfosModel = userInfosModel;
        [self.navigationController pushViewController:cardViewCotroller animated:YES];
    }
    else
    {
        
    }
}

//去淘宝买卡
-(void)goToBuyCardAction:(id)sender
{
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.dongway.com.cn/help/reserve.htm"]];
}
@end
