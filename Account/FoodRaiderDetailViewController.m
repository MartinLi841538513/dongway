//
//  FoodRaiderDetailViewController.m
//  Account
//
//  Created by wang zhe on 7/25/13.
//
//

#import "FoodRaiderDetailViewController.h"
#import "RaiderCommentViewController.h"
#import "Common.h"
#import "SVProgressHUD.h"
#import "FoodRaidersDetailsModel.h"
#import "StateModel.h"
#import "GlobalVariateModel.h"
#import "UserInfosModel.h"

@interface FoodRaiderDetailViewController ()
{
    UIMenuBar *menuBar;
    NSDictionary *foodRaiderDetailDictionary;
    Common *common;
    NSString *htmlString;
    NSArray *networkCaptions;
    NSArray *networkImages;
    FGalleryViewController *networkGallery;
    FoodRaidersDetailsModel *foodRaiderDetailModel;
    StateModel *stateModel;
    GlobalVariateModel *globalVariateModel;
    UserInfosModel *userInfosModel;
}

@end

@implementation FoodRaiderDetailViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"攻略详情";
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.

    //这是搜索按钮用图片表示的一种做法
    UIButton *moreFunction = [[UIButton alloc] init];
    moreFunction.frame=CGRectMake(0,0,41,10);
    [moreFunction setBackgroundImage:[UIImage imageNamed:@"moreFunction.png"] forState:UIControlStateNormal];
    [moreFunction addTarget:self action:@selector(moreFunctionAction:) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreFunction];
    
    common = [[Common alloc] init];
    foodRaiderDetailModel = [[FoodRaidersDetailsModel alloc] init];
    stateModel = [[StateModel alloc] init];
    globalVariateModel = [[GlobalVariateModel alloc] init];
    userInfosModel = [[UserInfosModel alloc] init];
    [userInfosModel setPropertysWithDictionary:[globalVariateModel userInfos]];
    
    [common returnButton:self];
    
    NSString *frDetailID = self.foodRaidersModel.foodDetailID;
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [foodRaiderDetailModel setFoodRaiderDetailWithFoodRaiderID:frDetailID];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            foodRaiderDetailDictionary = [foodRaiderDetailModel.foodRaidersDetails firstObject];
            [foodRaiderDetailModel setPropertysWithDictionary:foodRaiderDetailDictionary];
            htmlString = foodRaiderDetailModel.content;
            networkImages = [self getImages:htmlString];
            htmlString =[htmlString stringByReplacingOccurrencesOfString:@".jpg" withString:@".thumbs.jpg"];
            htmlString =[htmlString stringByReplacingOccurrencesOfString:@".png" withString:@".thumbs.png"];
            [self.webView loadHTMLString:htmlString baseURL:nil];
            [SVProgressHUD dismiss];
        });
    });
}

- (void)viewDidDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}


-(void)moreFunctionAction:(id)sender
{
    UIMenuBarItem *menuItem1 = [[UIMenuBarItem alloc] initWithTitle:@"评论" target:self image:[UIImage imageNamed:@"comment.png"] action:@selector(goToCommentAction:)];
    UIMenuBarItem *menuItem2 = [[UIMenuBarItem alloc] initWithTitle:@"收藏" target:self image:[UIImage imageNamed:@"collectionMenu.png"] action:@selector(collectFoodRaiderAction:)];
    UIMenuBarItem *menuItem3 = [[UIMenuBarItem alloc] initWithTitle:@"查看大图" target:self image:[UIImage imageNamed:@"checkBigPicture.png"] action:@selector(checkBigPicture:)];
    UIMenuBarItem *menuItem4 = [[UIMenuBarItem alloc] initWithTitle:@"分享" target:self image:[UIImage imageNamed:@"foodRaiderShare.png"] action:@selector(shareAction:)];
    
    NSMutableArray *items = [NSMutableArray arrayWithObjects:menuItem1, menuItem2,menuItem3,menuItem4, nil];
    menuBar = [[UIMenuBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 240.0f) items:items];
    menuBar.delegate = self;
    menuBar.items = [NSMutableArray arrayWithObjects:menuItem1, menuItem2,menuItem3,menuItem4,nil];
    [menuBar show];
    
}
//评论
- (void)goToCommentAction:(id)sender {
    
    [menuBar dismiss];
    //判断是否登陆了，如果登陆了，就可以继续操作；如果没有登陆，则跳转到登陆界面。
    if([common judgeUserIsLoginOrNot:self] == NO)
        return;
    RaiderCommentViewController *raiderCommentViewController = [[RaiderCommentViewController alloc] init];
    raiderCommentViewController.foodRaiderDetailModel = foodRaiderDetailModel;
    self.hidesBottomBarWhenPushed = NO;
    raiderCommentViewController.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:raiderCommentViewController animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

//收藏
-(void)collectFoodRaiderAction:(id)sender
{
    [menuBar dismiss];
    if([common judgeUserIsLoginOrNot:self] == NO)
        return;
    
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *userName = userInfosModel.userName;
        NSString *foodRaidersID = self.foodRaidersModel.ID;
        [stateModel foodRaiderCollectionAddStateWithUsername:userName andFoodRaidersID:foodRaidersID];
        NSString *state = stateModel.state;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            if([state isEqualToString:@"1"])
            {
                [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
            }
            else if([state isEqualToString:@"-1"])
            {
                [SVProgressHUD showErrorWithStatus:@"请不要重复收藏"];
            }
            
        });
    });
}

//查看大图
-(void)checkBigPicture:(id)sender
{
    [menuBar dismiss];
    networkGallery = [[FGalleryViewController alloc] initWithPhotoSource:self];
    [self.navigationController pushViewController:networkGallery animated:YES];
}

//分享
-(void)shareAction:(id)sender
{
    [menuBar dismiss];
    
    [common foodRaiderShareWithFoodRaiderModel:self.foodRaidersModel inViewController:self];

}

#pragma mark - FGalleryViewControllerDelegate Methods


- (int)numberOfPhotosForPhotoGallery:(FGalleryViewController *)gallery
{
	return [networkImages count];
}


- (FGalleryPhotoSourceType)photoGallery:(FGalleryViewController *)gallery sourceTypeForPhotoAtIndex:(NSUInteger)index
{
    return FGalleryPhotoSourceTypeNetwork;
}


- (NSString*)photoGallery:(FGalleryViewController *)gallery captionForPhotoAtIndex:(NSUInteger)index
{
	return [networkCaptions objectAtIndex:index];
}

- (NSString*)photoGallery:(FGalleryViewController *)gallery urlForPhotoSize:(FGalleryPhotoSize)size atIndex:(NSUInteger)index
{
    return [networkImages objectAtIndex:index];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//得到清晰大图的image url
-(NSArray *)getImages:(NSString *)string
{
    NSMutableArray *images = [[NSMutableArray alloc] init];
    NSString *url = nil;
    NSScanner *theScanner = [NSScanner scannerWithString:string];
    [theScanner scanUpToString:@"<img" intoString:nil];
    while(![theScanner isAtEnd]) {
        [theScanner scanUpToString:@"src" intoString:nil];
        NSCharacterSet *charset = [NSCharacterSet characterSetWithCharactersInString:@"\"'"];
        [theScanner scanUpToCharactersFromSet:charset intoString:nil];
        [theScanner scanCharactersFromSet:charset intoString:nil];
        [theScanner scanUpToCharactersFromSet:charset intoString:&url];
        [images addObject:url];
    }
    return images;
}

@end
