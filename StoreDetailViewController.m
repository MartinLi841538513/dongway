//
//  StoreDetailViewController.m
//  Account
//
//  Created by wang zhe on 9/17/13.
//
//

#import "StoreDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "StoresModel.h"
#import "Common.h"
#import "SVProgressHUD.h"
#import "MakeOrderViewController.h"
#import "JDNAutoNaviMapViewController.h"
#import "MakeStoreCommentViewController.h"
#import "CommentsModel.h"
#import "UIMenuBarItem.h"
#import "UIMenuBar.h"
#import "StateModel.h"
#import "GlobalVariateModel.h"
#import "UserInfosModel.h"
#import "StoreCommentCell.h"
#import "ReportStoreProblemViewController.h"
#import "StoreAllCommentsViewController.h"
#import "DiscountInfosModel.h"


@interface StoreDetailViewController ()
{
    Common *common;
    CommentsModel *commentsModel;
    UIMenuBar *menuBar;
    StoresModel *storeModel;
    StateModel *stateModel;
    GlobalVariateModel *globalVariateModel;
    UserInfosModel *userInfosModel;
    UITableView *commentTable;
    float commentTableHeight;
    UITextField *commentField;
    UIButton *moreComments;
    UIButton *correction;
    DiscountInfosModel *discountStoreModel;
    UIImageView *sixthView;
    UIImageView *storeDetailTipView;
}

@end


@implementation StoreDetailViewController

@synthesize scrollView;

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
    // Do any additional setup after loading the view from its nib.
    common = [[Common alloc] init];
    commentsModel = [[CommentsModel alloc] init];
    discountStoreModel = [[DiscountInfosModel alloc] init];
    storeModel = [[StoresModel alloc] init];
    stateModel = [[StateModel alloc] init];
    globalVariateModel = [[GlobalVariateModel alloc] init];
    userInfosModel = [[UserInfosModel alloc] init];
    [userInfosModel setPropertysWithDictionary:[globalVariateModel userInfos]];
    
    //这是返回按钮用图片表示的一种做法
    [common returnButton:self];
    
    //如果是商家收藏，和商家列表里出来的。
    if(self.isDiscountStore == NO)
    {
        storeModel = self.storesModel;
        
        //status＝＝20  有优惠
        if([storeModel.status isEqualToString:@"20"])
        {
            
            [SVProgressHUD show];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [discountStoreModel setDiscountStoreInfosWithStoreID:self.storesModel.storeId];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if([discountStoreModel.discountInfoArray count] >0)
                        [discountStoreModel setPropertysWithDictionary:[discountStoreModel.discountInfoArray objectAtIndex:0]];
                    
                    [self loadControl];
                });
            });
        }
        
        else
        {
            [self loadControl];
        }
        
    }
    //如果是优惠商家
    else if(self.isDiscountStore == YES)
    {
        discountStoreModel = self.discountInfosModel;
        
        [SVProgressHUD show];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [storeModel setStoreWithStoreID:discountStoreModel.storeID];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [storeModel setPropertysWithDictionary:[storeModel.stores objectAtIndex:0]];
                
                [self loadControl];
            });
        });
    }

    
}

-(void)viewWillAppear:(BOOL)animated
{
    
   

}

-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}


-(void)loadControl
{
    self.title = storeModel.storeName;
    
    UIButton *collectButton = [[UIButton alloc] init];
    collectButton.frame=CGRectMake(0,0,38,30);
    [collectButton setBackgroundImage:[UIImage imageNamed:@"collection.png"] forState:UIControlStateNormal];
    [collectButton addTarget:self action:@selector(collectAction:) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *collectItem = [[UIBarButtonItem alloc]initWithCustomView:collectButton];
    
    UIButton *shareButton = [[UIButton alloc] init];
    shareButton.frame=CGRectMake(10,0,51,30);
    [shareButton setBackgroundImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithCustomView:shareButton];
    
    self.navigationItem.rightBarButtonItems = @[shareItem,collectItem];
    
    
    //商家图片
    UIImageView *storeImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 218)];
   
   
    [storeImage setImageWithURL:[NSURL URLWithString:storeModel.imageUrl] placeholderImage:[UIImage imageNamed:@"logoLoading.jpg"]];
    [scrollView addSubview:storeImage];
    
    
    //价钱
    UILabel *pricelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 70, 30)];
    pricelabel.text = [NSString stringWithFormat:@"人均:¥%@",storeModel.price];
    [pricelabel setBackgroundColor:[UIColor clearColor]];
    pricelabel.textColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:0 alpha:1];
    [pricelabel setFont:[UIFont systemFontOfSize:15.0f]];
    
    
    //短信邀请好友
    UILabel *inviteLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 150, 25)];
    inviteLabel.text = @"邀请好友用餐";
    [inviteLabel setBackgroundColor:[UIColor clearColor]];
    [inviteLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [inviteLabel setTextColor:[UIColor blueColor]];
    inviteLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *inviteButton = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(inviteAction:)];
    [inviteLabel addGestureRecognizer:inviteButton];
    
    
    //订餐按钮
    UIButton *makeOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [makeOrderButton setFrame:CGRectMake(220, 2, 90, 30)];
    [makeOrderButton setTitle:@"预定" forState:UIControlStateNormal];
    [makeOrderButton setBackgroundColor:[UIColor orangeColor]];
    [makeOrderButton addTarget:self action:@selector(goToOrder)forControlEvents:UIControlEventTouchDown];
    
    //第一块
    UIImageView *firstView = [[UIImageView alloc] initWithFrame:CGRectMake(0, storeImage.frame.origin.y+storeImage.frame.size.height+2, 320, 35)];
    firstView.userInteractionEnabled = YES;
    [firstView setBackgroundColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:251/255.0 alpha:1]];
    [firstView addSubview:pricelabel];
    [firstView addSubview:inviteLabel];
    [firstView addSubview:makeOrderButton];
    [scrollView addSubview:firstView];
    
    
    //地址 懂味
    NSString *addressString =[NSString stringWithFormat:@"地址:%@",storeModel.address];
    CGSize size = [addressString sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(300.0f, 2000.0f) lineBreakMode:NSLineBreakByCharWrapping];
    UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, size.height)];
    address.numberOfLines= 0;
    address.text = addressString;

    [address setBackgroundColor:[UIColor clearColor]];
    [address setFont:[UIFont systemFontOfSize:12.0f]];
    [address setTextColor:[UIColor blueColor]];
    address.userInteractionEnabled = YES;
    UITapGestureRecognizer *mapModelButton = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapModelAction:)];
    [address addGestureRecognizer:mapModelButton];
    
    //公交线和公交站
    NSString *buslinestring = [NSString stringWithFormat:@"公交线:%@",storeModel.busTrips];
    CGSize lineSize = [buslinestring sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(300.0f, 2000.0f) lineBreakMode:NSLineBreakByCharWrapping];
    UILabel *busLine = [[UILabel alloc] initWithFrame:CGRectMake(10, address.frame.origin.y+address.frame.size.height+5, 300, lineSize.height)];
    busLine.numberOfLines = 0;
    busLine.text = buslinestring;
    [busLine setBackgroundColor:[UIColor clearColor]];
    [busLine setFont:[UIFont systemFontOfSize:12.0]];
    
    UILabel *busStation = [[UILabel alloc] initWithFrame:CGRectMake(10, busLine.frame.origin.y+busLine.frame.size.height+5, 150, 25)];
    [busStation setBackgroundColor:[UIColor clearColor]];
    busStation.text = [NSString stringWithFormat:@"公交站:%@",storeModel.busStation];
    [busStation setFont:[UIFont systemFontOfSize:12.0]];
    
    //距离
    UILabel *distance = [[UILabel alloc] initWithFrame:CGRectMake(230, busLine.frame.origin.y+busLine.frame.size.height+5, 80, 25)];
    [distance setBackgroundColor:[UIColor clearColor]];
    distance.text = [NSString stringWithFormat:@"距离我%@",storeModel.distance];
    [distance setFont:[UIFont systemFontOfSize:12.0f]];
    [distance setTextColor:[UIColor grayColor]];
    
    if(self.isDiscountStore == YES||self.isCollectedStore == YES)
    {
        distance.hidden = YES;
    }
    else
    {
        distance.hidden = NO;
    }
    
    //电话
    UILabel *storePhoneNumber = [[UILabel alloc] initWithFrame:CGRectMake(10, busStation.frame.origin.y+busStation.frame.size.height+5, 150, 25)];
    [storePhoneNumber setBackgroundColor:[UIColor clearColor]];
    if([storeModel.telephone isEqualToString:@""]||storeModel.telephone ==nil)
    {
        storeModel.telephone = @"无该商家电话";
    }
    storePhoneNumber.text = [NSString stringWithFormat:@"电话:%@",storeModel.telephone];
    [storePhoneNumber setFont:[UIFont systemFontOfSize:12.0f]];
    [storePhoneNumber setTextColor:[UIColor blueColor]];
    storePhoneNumber.userInteractionEnabled = YES;
    UITapGestureRecognizer *makeCallButton = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeCallAction:)];
    [storePhoneNumber addGestureRecognizer:makeCallButton];
    
    //第二块
    UIImageView *secondView = [[UIImageView alloc] initWithFrame:CGRectMake(0,firstView.frame.origin.y+firstView.frame.size.height+2, 320, 105+size.height)];
    secondView.userInteractionEnabled = YES;
    [secondView setBackgroundColor:[UIColor whiteColor]];
    [secondView addSubview:address];
    [secondView addSubview:busLine];
    [secondView addSubview:busStation];
    [secondView addSubview:distance];
    [secondView addSubview:storePhoneNumber];
    [scrollView addSubview:secondView];
    
    
    //优惠信息
    NSString *discountString;
    discountString =[NSString stringWithFormat:@"优惠:%@",discountStoreModel.content];
    CGSize size2 = [discountString sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(300.0f, 2000.0f) lineBreakMode:NSLineBreakByCharWrapping];
    UILabel *discount = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, size2.width, size2.height)];
    [discount setTextColor:[UIColor colorWithRed:183/255.0 green:18/255.0 blue:19/255.0 alpha:1]];
    [discount setBackgroundColor:[UIColor clearColor]];
    [discount setNumberOfLines:0];
    discount.text = discountString;
    [discount setFont:[UIFont systemFontOfSize:12.0f]];
    
    //第三块
    UIImageView *thirdView = [[UIImageView alloc] initWithFrame:CGRectMake(0,secondView.frame.origin.y+secondView.frame.size.height+2, 320, size2.height+20)];
    [thirdView setBackgroundColor:[UIColor colorWithRed:253/255.0 green:236/255.0 blue:240/155.0 alpha:1]];
    
    if([discountStoreModel.content length]<1 ||discountStoreModel.content==nil)
    {
        discount.text = @"";
        [thirdView setFrame:CGRectMake(0,secondView.frame.origin.y+secondView.frame.size.height, 0, 0)];
    }
    [thirdView addSubview:discount];
    [scrollView addSubview:thirdView];
    
    
    //推荐菜
    NSString *dishRecommendedString = [NSString stringWithFormat:@"推荐菜:%@",storeModel.recommend];
    CGSize size3 = [dishRecommendedString sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(300.0f, 2000.0f) lineBreakMode:NSLineBreakByCharWrapping];
    UILabel *dishRecommended = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, size3.width, size3.height)];
    [dishRecommended setBackgroundColor:[UIColor clearColor]];
    [dishRecommended setNumberOfLines:0];
    dishRecommended.text = dishRecommendedString;
    [dishRecommended setFont:[UIFont systemFontOfSize:12.0f]];
    
    //第四块
    UIImageView *fourthView = [[UIImageView alloc] initWithFrame:CGRectMake(0,thirdView.frame.origin.y+thirdView.frame.size.height+2, 320, size3.height+20)];
    if([storeModel.recommend length] <1 ||storeModel.recommend==nil)
    {
        dishRecommended.text = @"";
        [fourthView setFrame:CGRectMake(0, thirdView.frame.origin.y+thirdView.frame.size.height, 320, 0)];
    }
    [fourthView setBackgroundColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:251/255.0 alpha:1]];
    [fourthView addSubview:dishRecommended];
    [scrollView addSubview:fourthView];
    
    //描述
    NSString *introduceString;
    if([storeModel.introduction length]>=1)
        introduceString = [NSString stringWithFormat:@"描述:%@",storeModel.introduction];
    else
        introduceString = @"";
    CGSize size4 = [introduceString sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(300.0f, 2000.0f) lineBreakMode:NSLineBreakByCharWrapping];
    UILabel *introduce = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, size4.width, size4.height)];
    [introduce setBackgroundColor:[UIColor clearColor]];
    [introduce setNumberOfLines:0];
    introduce.text = introduceString;
    [introduce setFont:[UIFont systemFontOfSize:12.0f]];
    
    //第五块
    UIImageView *fifthView = [[UIImageView alloc] initWithFrame:CGRectMake(0,fourthView.frame.origin.y+fourthView.frame.size.height+2, 320, size4.height+10)];
    if([introduceString length] <1)
    {
        [fifthView setFrame:CGRectMake(0, fourthView.frame.origin.y+fourthView.frame.size.height, 320, 0)];
    }
    [fifthView setBackgroundColor:[UIColor whiteColor]];
    [fifthView addSubview:introduce];
    [scrollView addSubview:fifthView];
    
    //使用优惠券的温馨提示
    NSString *tipString = @"温馨提示:就餐时声明在懂味订餐即可享受优惠！";
    CGSize size5 = [tipString sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(300.0f, 2000.0f) lineBreakMode:NSLineBreakByCharWrapping];
    UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, size5.width, size5.height)];
    [tip setBackgroundColor:[UIColor clearColor]];
    [tip setNumberOfLines:0];
    tip.text = tipString;
    [tip setFont:[UIFont systemFontOfSize:12.0f]];
    
    //第六块
    sixthView = [[UIImageView alloc] initWithFrame:CGRectMake(0,fifthView.frame.origin.y+fifthView.frame.size.height+2, 320, size5.height+20)];
    if([discountStoreModel.content length]<1 ||discountStoreModel.content==nil)
    {
        tip.text = @"";
        [sixthView setFrame:CGRectMake(0,fifthView.frame.origin.y+fifthView.frame.size.height, 320, 0)];
    }
    [sixthView setBackgroundColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:251/255.0 alpha:1]];
    [sixthView addSubview:tip];
    [scrollView addSubview:sixthView];
    
    //评分
    UILabel *score = [[UILabel alloc] initWithFrame:CGRectMake(10, sixthView.frame.origin.y+sixthView.frame.size.height+5, 30, 18)];
    UILabel *service = [[UILabel alloc] initWithFrame:CGRectMake(150, sixthView.frame.origin.y+sixthView.frame.size.height+5, 30, 18)];
    UILabel *environment = [[UILabel alloc] initWithFrame:CGRectMake(10, sixthView.frame.origin.y+sixthView.frame.size.height+25, 30, 18)];
    UILabel *taste = [[UILabel alloc] initWithFrame:CGRectMake(150, sixthView.frame.origin.y+sixthView.frame.size.height+25, 30, 18)];
    score.text = @"总分:";
    service.text = @"服务:";
    environment.text = @"环境:";
    taste.text = @"口味:";
    [score setFont:[UIFont systemFontOfSize:12.0f]];
    [service setFont:[UIFont systemFontOfSize:12.0f]];
    [environment setFont:[UIFont systemFontOfSize:12.0f]];
    [taste setFont:[UIFont systemFontOfSize:12.0f]];
    UIImageView *scoreStar = [[UIImageView alloc] initWithFrame:CGRectMake(40, sixthView.frame.origin.y+sixthView.frame.size.height+7, 90, 15)];
    UIImageView *serviceStar = [[UIImageView alloc] initWithFrame:CGRectMake(180, sixthView.frame.origin.y+sixthView.frame.size.height+7, 90, 15)];
    UIImageView *environmentStar = [[UIImageView alloc] initWithFrame:CGRectMake(40, sixthView.frame.origin.y+sixthView.frame.size.height+27, 90, 15)];
    UIImageView *tasteStar = [[UIImageView alloc] initWithFrame:CGRectMake(180, sixthView.frame.origin.y+sixthView.frame.size.height+27, 90, 15)];
    [scoreStar setImage:[UIImage imageNamed:[common starName:storeModel.score]]];
    [serviceStar setImage:[UIImage imageNamed:[common starName:storeModel.service]]];
    [environmentStar setImage:[UIImage imageNamed:[common starName:storeModel.environment]]];
    [tasteStar setImage:[UIImage imageNamed:[common starName:storeModel.taste]]];
    [scrollView addSubview:score];
    [scrollView addSubview:service];
    [scrollView addSubview:environment];
    [scrollView addSubview:taste];
    [scrollView addSubview:scoreStar];
    [scrollView addSubview:serviceStar];
    [scrollView addSubview:environmentStar];
    [scrollView addSubview:tasteStar];
    
    //评论
    UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, environment.frame.origin.y+environment.frame.size.height+5, 40, 25)];
    commentLabel.text = @"评论";
    [commentLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [commentLabel setTextColor:[UIColor redColor]];
    [scrollView addSubview:commentLabel];
    
    
    commentField = [[UITextField alloc] initWithFrame:CGRectMake(10,commentLabel.frame.origin.y+commentLabel.frame.size.height+5, 300, 30)];
    commentField.layer.borderWidth = 1;
    commentField.layer.borderColor = [[UIColor grayColor] CGColor];
    commentField.layer.cornerRadius = 5.0;
    commentField.placeholder = @"说说我的看法...";
    [commentField setFont:[UIFont systemFontOfSize:12.0f]];
    commentField.delegate = self;
    [scrollView addSubview:commentField];
    
    commentTable = [[UITableView alloc] initWithFrame:CGRectMake(0, commentField.frame.origin.y+commentField.frame.size.height+5, 320, 90) style:UITableViewStylePlain];
    commentTable.delegate = self;
    commentTable.dataSource=self;
    commentTable.userInteractionEnabled = NO;
    commentTable.scrollEnabled = NO;
    [scrollView addSubview:commentTable];
    [self.view addSubview:scrollView];
    [scrollView setFrame:CGRectMake(0, 0, 320, 480)];
    
    moreComments = [[UIButton alloc] init];
    [moreComments setTitle:@"更多评论" forState:UIControlStateNormal];
    [moreComments setTintColor:[UIColor whiteColor]];
    [moreComments setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [moreComments setBackgroundColor:[UIColor orangeColor]];
    [moreComments addTarget:self action:@selector(moreCommentsAction:) forControlEvents:UIControlEventTouchDown];
    [moreComments.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [scrollView addSubview:moreComments];
    moreComments.hidden = YES;
    
    correction = [[UIButton alloc] init];
    [correction setTitle:@"纠错" forState:UIControlStateNormal];
    [correction setTintColor:[UIColor whiteColor]];
    [correction setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [correction setBackgroundColor:[UIColor orangeColor]];
    [correction addTarget:self action:@selector(correctionAction:) forControlEvents:UIControlEventTouchDown];
    [correction.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [scrollView addSubview:correction];
    
    //如果是第一次使用这个软件，展示提示界面
    if(![globalVariateModel.isFirstTimeEnterStoreDetailView isEqualToString:@"no"])
    {
        [UIView animateWithDuration:0.2 animations:^{
            
            storeDetailTipView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"storeDetailTips.jpg"]];
            [storeDetailTipView setFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height-20)];
            [self.scrollView addSubview:storeDetailTipView];
            self.navigationController.navigationBarHidden = YES;
            self.scrollView.scrollEnabled = NO;
            storeDetailTipView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tipViewActionButton = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tipViewAction:)];
            [storeDetailTipView addGestureRecognizer:tipViewActionButton];
        }];
       
    }
    
    [self reloadStoreComments:self];

}

//用户第一次进来的提示，点击就要消失
-(void)tipViewAction:(id)sender
{
    [UIView animateWithDuration:0.6 animations:^{
       
        self.scrollView.scrollEnabled = YES;
        self.navigationController.navigationBarHidden = NO;
        [storeDetailTipView removeFromSuperview];
    }];
    [globalVariateModel setIsFirstTimeEnterStoreDetailView:@"no"];
}
//加载商家评论
-(void)reloadStoreComments:(id)sender
{
    
   
    commentTableHeight = 0;
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        [commentsModel setCommentsWithCat:@"1" andStoreID:storeModel.storeId];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.comments = commentsModel.comments;
            int i;
            if([self.comments count]<=3)
            {
                i = [self.comments count];
            }
            else
            {
                i = 3;
            }
            while (i>0)
            {
                NSDictionary *commentDictionary = [self.comments objectAtIndex:i-1];
                [commentsModel setPropertysWithDictionary:commentDictionary];
                CGSize newContentInCellFrame = [commentsModel.comment sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(249.0f, 2000.0f) lineBreakMode:NSLineBreakByCharWrapping];
                commentTableHeight = commentTableHeight + newContentInCellFrame.height+40;
                i--;
            }
            [commentTable setFrame:CGRectMake(0, commentField.frame.origin.y+commentField.frame.size.height+5, 320, commentTableHeight+13)];
            if([self.comments count]>3)
            {
                [moreComments setFrame:CGRectMake(20, commentTable.frame.origin.y+commentTable.frame.size.height+8, 100, 30)];
                moreComments.hidden = NO;
            }
            [correction setFrame:CGRectMake(200, commentTable.frame.origin.y+commentTable.frame.size.height+8, 100, 30)];
            
            [commentTable reloadData];
            
            [scrollView setContentSize:CGSizeMake(320, commentTable.frame.origin.y+commentTable.frame.size.height+130)];
            [scrollView setFrame:CGRectMake(0, self.view.frame.origin.y, 320, self.view.frame.size.height)];

            [SVProgressHUD dismiss];
        });
    });

}


//更多
-(void)moreFunctionAction:(id)sender
{
    UIMenuBarItem *menuItem1 = [[UIMenuBarItem alloc] initWithTitle:@"收藏" target:self image:[UIImage imageNamed:@"collection.png"] action:@selector(collectStoreAction:)];
    UIMenuBarItem *menuItem2 = [[UIMenuBarItem alloc] initWithTitle:@"分享" target:self image:[UIImage imageNamed:@"reportProblem.png"] action:@selector(shareStore:)];
    UIMenuBarItem *menuItem3 = [[UIMenuBarItem alloc] initWithTitle:@"报告问题" target:self image:[UIImage imageNamed:@"reportProblem.png"] action:@selector(reportProblemAction:)];
    NSMutableArray *items = [NSMutableArray arrayWithObjects:menuItem1, menuItem2, menuItem3,nil];
    menuBar = [[UIMenuBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 240.0f) items:items];
    menuBar.delegate = self;
    menuBar.items = [NSMutableArray arrayWithObjects:menuItem1, menuItem2, menuItem3,nil];
    [menuBar show];
}

//收藏商家
-(void)collectAction:(id)sender
{
    if([common judgeUserIsLoginOrNot:self] == NO)
        return;

    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        scrollView.scrollEnabled = NO;
        NSString *userName = userInfosModel.userName;
        NSString *storeID = storeModel.storeId;

        [storeModel addStoreCollectionWithStoreID:storeID andUsername:userName];
        NSArray *collectStoreArray = storeModel.stores;

        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            if([collectStoreArray count] > 0)
            {
                [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
            }
            else if([collectStoreArray count] == 0)
            {
                [SVProgressHUD showErrorWithStatus:@"请不要重复收藏"];
            }
            scrollView.scrollEnabled = YES;
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


//分享
-(void)shareButtonAction:(id)sender
{
    
    NSString *URL = [NSString stringWithFormat:@"http://www.dongway.com.cn/store/details/detail.htm?storeId=%@",storeModel.storeId];
    NSString *content = [NSString stringWithFormat:@"小伙伴们呀，这家餐厅真心不错哟!!!%@",URL];
    NSURL *url = [NSURL URLWithString:storeModel.imageUrl];
    NSString *title = storeModel.storeName;
    NSString *description;
    //人人网要求description不能                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             为空
    if(!([storeModel.introduction isEqualToString:@""]||storeModel.introduction==nil))
    {
        description = storeModel.introduction;
        
    }
    else if(!([discountStoreModel.content isEqualToString:@""]||discountStoreModel.content==nil))
    {
        description = discountStoreModel.content;
    }
    else if(!([storeModel.recommend isEqualToString:@""]||storeModel.recommend==nil))
    {
        description = storeModel.recommend;
    }
    else if(!([storeModel.address isEqualToString:@""]||storeModel.address==nil))
    {
        description = storeModel.address;
    }
    description = [common description_83:description];
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            //构造分享内容
            id<ISSContent> publishContent = [ShareSDK content:content
                                               defaultContent:content
                                                        image:[ShareSDK pngImageWithImage:image]
                                                        title:title
                                                          url:URL
                                                  description:description
                                                    mediaType:SSPublishContentMediaTypeNews];

            [common shareContent:publishContent andViewController:self];
            
            
            
        });
    });

}

//短信邀请好友用餐
-(void)inviteAction:(id)sender
{
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if (messageClass != nil) {
        // Check whether the current device is configured for sending SMS messages
        if ([messageClass canSendText]) {
            [self displaySMSComposerSheet];
        }
        else {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@""message:@"设备不支持短信功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }
    else {
    }

}

// send message methods
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultCancelled:
            //            if(DEBUG)
            break;
        case MessageComposeResultFailed:
            //            if(DEBUG)
            break;
        case MessageComposeResultSent:
            //            if(DEBUG)
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)displaySMSComposerSheet
{
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate =self;
    NSString *smsBody =[NSString stringWithFormat:@"%@\n电话：%@\n地址：%@",storeModel.storeName,storeModel.telephone,storeModel.address];
    picker.body = smsBody;
    [self presentViewController:picker animated:YES completion:nil];
}

//更多评论
-(void)moreCommentsAction:(id)sender
{
    StoreAllCommentsViewController *storeAllComments = [[StoreAllCommentsViewController alloc] initWithNibName:@"StoreAllCommentsViewController" bundle:nil];
    storeAllComments.comments = self.comments;
    [self.navigationController pushViewController:storeAllComments animated:YES];
}
//纠错
-(void)correctionAction:(id)sender
{
    if([common judgeUserIsLoginOrNot:self] == NO)
        return;
    
    //报告问题
    NSString *userName = userInfosModel.userName;
    ReportStoreProblemViewController *reportViewController = [[ReportStoreProblemViewController alloc] init];
    reportViewController.userName = userName;
    reportViewController.storesModel = storeModel;
    [self.navigationController pushViewController:reportViewController animated:YES];

}


//预订
- (void)goToOrder
{
    if([common judgeUserIsLoginOrNot:self] == NO)
        return;

    int accuracy = [storeModel.accuracy intValue];
    if(accuracy == 1)
    {
        //有桌位，则选桌位
        MakeOrderViewController *makeOrderView = [[MakeOrderViewController alloc] initWithNibName:@"MakeOrderViewController" bundle:nil];
        makeOrderView.storesModel = storeModel;
        [self.navigationController pushViewController:makeOrderView animated:YES];
        makeOrderView.title = @"订      餐";
    }
    else
    {
        //没有桌位，直接拨打电话
        [self makeCallAction:self];
    }
}

//点击 地址 变为地图模式
-(void)mapModelAction:(id)sender
{
    JDNAutoNaviMapViewController *autoNaviMapViewController = [[JDNAutoNaviMapViewController alloc] init];
    autoNaviMapViewController.storeModelFromSingleStore = storeModel;
    autoNaviMapViewController.latitude = self.latitude;
    autoNaviMapViewController.longitude = self.longitude;
    autoNaviMapViewController.locationName = self.locationName;
    autoNaviMapViewController.isFromSignleStore = YES;
    autoNaviMapViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:autoNaviMapViewController animated:YES];
}

//点击电话号码拨打电话,需要在真机上才能有这个功能
-(void)makeCallAction:(id)sender
{
    NSString *telephone = storeModel.telephone;
    if([telephone isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"没有该商家电话"];
        return;
    }
    //过滤空格
    telephone = [telephone stringByReplacingOccurrencesOfString:@" " withString:@""];

    if(![self isMobileNumber:telephone])
    {
        [SVProgressHUD showErrorWithStatus:@"号码不合法"];
        return;
    }
        NSString *tel = [NSString stringWithFormat:@"tel:%@",telephone];
    UIWebView *callWebview = [[UIWebView alloc] init];
    NSURL *telURL = [NSURL URLWithString:tel];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebview];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    if([common judgeUserIsLoginOrNot:self] == NO)
        return;
    MakeStoreCommentViewController *viewController = [[MakeStoreCommentViewController alloc] initWithNibName:@"MakeStoreCommentViewController" bundle:nil];
    viewController.doSomethingDelegate = self;
    viewController.storeId = storeModel.storeId;
    [self.navigationController pushViewController:viewController animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if([self.comments count]<=3)
        return [self.comments count];
    else
        return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];

    static NSString *CellTableIdentifier = @"Cell";
    // Configure the cell...
    StoreCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"StoreCommentCell" owner:self options:nil] lastObject];
    }

    NSDictionary *commentDictionary = [self.comments objectAtIndex:row];
    [commentsModel setPropertysWithDictionary:commentDictionary];
    
    cell.commentContent.text = commentsModel.comment;
    CGSize newContentInCellFrame = [commentsModel.comment sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(249.0f, 2000.0f) lineBreakMode:NSLineBreakByWordWrapping];
    cell.commentContent.frame = CGRectMake(cell.commentContent.frame.origin.x, cell.commentContent.frame.origin.y, newContentInCellFrame.width, newContentInCellFrame.height+7);
    
    cell.time.text = commentsModel.lastUpdateTime;
    if(newContentInCellFrame.height>0)
    {
        [cell.time setFrame:CGRectMake(cell.commentContent.frame.origin.x, cell.commentContent.frame.origin.y+cell.commentContent.frame.size.height+4, 130, 10)];
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSDictionary *commentDictionary = [self.comments objectAtIndex:row];
    [commentsModel setPropertysWithDictionary:commentDictionary];
    CGSize newContentInCellFrame = [commentsModel.comment sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(249.0f, 2000.0f) lineBreakMode:NSLineBreakByCharWrapping];
    if(newContentInCellFrame.height+40>45)
        return newContentInCellFrame.height+40;
    return 45.0f;
}


#pragma mark - SXPassValue Delegate methods
//提交评论后需要刷新商家评论tableview
-(void)dosomething
{
     [self reloadStoreComments:self];
}

///// 手机号码的有效性判断
//检测是否是手机号码
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString * phone = @"(^0(10|2[0-5789]|\\d{3})(-|)|)\\d{7,8}$";
    
//    NSString *phone = @"(^\\d{4}[-]\\d{7,8}$)|(^\\d{4}\\d{7,8}$)|(^\\d{7,8}$)";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestPhone = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phone];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        || ([regextestPhone evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
    }


@end
