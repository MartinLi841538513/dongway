//
//  IndexViewController.m
//  Account
//
//  Created by wang zhe on 9/9/13.
//
//

#import "IndexViewController.h"
#import "IndexCell.h"
#import "FoodRaiderViewController.h"
#import "FeastActivityViewController.h"
#import "Common.h"
#import "GlobalVariateModel.h"
#import "CategoryViewController.h"
#import "DiscountStoresListViewController.h"
#import "CardIntroduceViewController.h"
#import "IndexDatasModel.h"
#import "SVProgressHUD.h"
#import "WebViewController.h"
#define IphoneHeiht [[UIScreen mainScreen] bounds].size.height

@interface IndexViewController ()
{
    NSMutableArray *images;
    NSMutableArray *titles;
    NSMutableArray *details;
    Common *common;
    UILabel *userAddress;
    UIImageView *addressView;
    GlobalVariateModel *globalVariateModel;
    NSString *longitude;
    NSString *latitude;
    IndexDatasModel *indexDatasModel;
    NSMutableArray *urls;
    NSMutableArray *imgUrls;
    EAIntroView *intro;
    UIImageView *tipView;
    EScrollerView *scroller;
}

@end

@implementation IndexViewController

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
    
   
    common = [[Common alloc] init];
    globalVariateModel = [[GlobalVariateModel alloc] init];
    indexDatasModel = [[IndexDatasModel alloc] init];
   

    // Do any additional setup after loading the view from its nib.
    
    self.title = @"首页";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top.png"] forBarMetrics:UIBarMetricsDefault];//导航栏背景
    
    //这是搜索按钮用图片表示的一种做法
    UIButton *searchButton = [[UIButton alloc] init];
    searchButton.frame=CGRectMake(0,0,28,28);
    [searchButton setBackgroundImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    
    //这是重新定位按钮用图片表示的一种做法
    UIButton *relocationButton = [[UIButton alloc] init];
    relocationButton.frame=CGRectMake(0,0,28,42);
    [relocationButton setBackgroundImage:[UIImage imageNamed:@"location.png"] forState:UIControlStateNormal];
    [relocationButton addTarget:self action:@selector(relocationAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:relocationButton];
    
    self.tableview.scrollEnabled = NO;
    

    addressView = [[UIImageView alloc] init];
    [addressView setBackgroundColor:[UIColor orangeColor]];
    [addressView setFrame:CGRectMake(0, self.tabBarController.tabBar.frame.origin.y, 320, 30)];
    userAddress = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 300, 25)];
    [userAddress setFont:[UIFont systemFontOfSize:12.0]];
    [userAddress setBackgroundColor:[UIColor clearColor]];
    [addressView addSubview:userAddress];
    [self.view addSubview:addressView];
    
    urls = [[NSMutableArray alloc] init];
    imgUrls = [[NSMutableArray alloc] init];
    
    images = [[NSMutableArray alloc] initWithObjects:@"foodRaider.png",@"activities.png",@"discount.png",@"card.png",nil];
    titles = [[NSMutableArray alloc] initWithObjects:@"美食攻略",@"懂味活动",@"美食优惠",@"美食达人卡", nil];
    details = [[NSMutableArray alloc] initWithObjects:@"攻略在手，美食跟我走",@"各种免费试吃活动",@"优惠在手，美食跟我走",@"优惠在手，美食跟我走", nil];
    
    //如果是第一次使用这个软件，展示欢迎界面
    if(![globalVariateModel.isFirstTimeUseApp isEqualToString:@"no"])
    {
        [self showIntroWithCrossDissolve];
    }
    
    if(![globalVariateModel.isFirstTimeEnterIndexView isEqualToString:@"no"])
    {
        //如果是第一次使用这个软件，展示提示界面
        [UIView animateWithDuration:0.2 animations:^{
            
            tipView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"indexTips.jpg"]];
            [tipView setFrame:CGRectMake(0, 20, 320, [UIScreen mainScreen].bounds.size.height-20)];
            [self.navigationController.tabBarController.view addSubview:tipView];
            self.navigationController.navigationBarHidden = YES;
            tipView.userInteractionEnabled = YES;
            scroller.hidden = YES;
            self.tabBarController.tabBar.hidden = YES;
            
            UITapGestureRecognizer *tipViewActionButton = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tipViewAction:)];
            [tipView addGestureRecognizer:tipViewActionButton];
        }];

    }
    else
    {
        //就是banner
        [self setupViews];
    }
    //定位
    [self relocationAction:self];
}



-(void)viewWillAppear:(BOOL)animated
{
    
    //如果定位成功，就直接出现popup
    [self addressLabelPopUp:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tipViewAction:(id)sender
{
    [UIView animateWithDuration:0.6 animations:^{
        
        self.navigationController.navigationBarHidden = NO;
        scroller.hidden = NO;
        [tipView removeFromSuperview];
        self.tabBarController.tabBar.hidden = NO;
        [self setupViews];
    }];
    [globalVariateModel setIsFirstTimeEnterIndexView:@"no"];
}

//搜索
-(void)searchAction:(id)sender
{
    CategoryViewController *categoryViewController = [[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil];
    categoryViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:categoryViewController animated:YES];
}

//重新定位
-(void)relocationAction:(id)sender
{
    [common relocation:sender];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addressLabelPopUp:) name:@"IndexViewController_addressLabelPopUp" object:nil];

}
-(void)addressLabelPopUp:(id)sender
{
   
    userAddress.text = [common userAddress];
       
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        //弹出窗口的渐变过程
        [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            [addressView setFrame:CGRectMake(0, self.tabBarController.tabBar.frame.origin.y-30, 320, 30)];
            addressView.alpha = 0.9;
            
        } completion:^(BOOL bl){
            
            //消失窗口的渐变过程
            [UIView animateWithDuration:0.5 delay:3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                [addressView setFrame:CGRectMake(0, self.tabBarController.tabBar.frame.origin.y, 320, 30)];
                
            } completion:^(BOOL bl){
                
            }];
            
        }];
    }
    else
    {
        //弹出窗口的渐变过程
        [UIView animateWithDuration:1 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            [addressView setFrame:CGRectMake(0, self.tabBarController.tabBar.frame.origin.y-93, 320, 30)];
            addressView.alpha = 0.9;
            
        } completion:^(BOOL bl){
            
            //消失窗口的渐变过程
            [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                [addressView setFrame:CGRectMake(0, self.tabBarController.tabBar.frame.origin.y-60, 320, 30)];
                
            } completion:^(BOOL bl){
                
            }];
            
        }];
    }
}

#pragma mark -
- (void)setupViews
{
   
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [indexDatasModel setIndexDatasWithBid:@"1"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSInteger count = [indexDatasModel.IndexDatas count];
            if(count>0)
            {
                NSMutableArray *objects = [[NSMutableArray alloc] init];
                int j=0;
                for(int i=0;i<count;i++)
                {
                    [indexDatasModel setPropertysWithDictionary:[indexDatasModel.IndexDatas objectAtIndex:i]];
                    //type>0表示当前有xiao
                    if([indexDatasModel.type intValue]>0)
                    {
                        
                        //过滤空格
                        indexDatasModel.url = [indexDatasModel.url stringByReplacingOccurrencesOfString:@" " withString:@""];
                        indexDatasModel.picUrl =[indexDatasModel.picUrl stringByReplacingOccurrencesOfString:@".jpg" withString:@".mobile.jpg"];
                        indexDatasModel.picUrl =[indexDatasModel.picUrl stringByReplacingOccurrencesOfString:@".png" withString:@".mobile.png"];
                        indexDatasModel.picUrl =[indexDatasModel.picUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
                        
                        [urls addObject:indexDatasModel.url];
                        [imgUrls addObject:indexDatasModel.picUrl];
                        [objects addObject:[NSString stringWithFormat:@"%d",j++]];
                    }
                }

                
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
                {
                    
                    scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height, 320, 150)
                                                           ImageArray:imgUrls
                                                           TitleArray:objects];
                    
                }
                else
                {
                    scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 0, 320, 150)
                                                           ImageArray:imgUrls
                                                           TitleArray:objects];
                }
            
                scroller.delegate=self;
                [self.view addSubview:scroller];
        
            }
            
        });
    });
}

#pragma mark -
-(void)EScrollerViewDidClicked:(NSUInteger)index
{

//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[urls objectAtIndex:index-1]]];
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[urls objectAtIndex:index-1]]];
    NSString *urlString;
    if(index == urls.count+1)
    {
        urlString = [urls objectAtIndex:0];
        [indexDatasModel setPropertysWithDictionary:[indexDatasModel.IndexDatas objectAtIndex:0]];
    }
    else
    {
        urlString = [urls objectAtIndex:index - 1];
        [indexDatasModel setPropertysWithDictionary:[indexDatasModel.IndexDatas objectAtIndex:index - 1]];
    }
    WebViewController *webViewController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    webViewController.urlString = urlString;
    webViewController.title = indexDatasModel.alt;
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController animated:YES];
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [titles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    NSString *title = [titles objectAtIndex:section];
    NSString *detail = [details objectAtIndex:section];
    NSString *image = [images objectAtIndex:section];
    static NSString *CellTableIdentifier = @"Cell";
    // Configure the cell...
    IndexCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"IndexCell" owner:self options:nil] lastObject];
    }
    
    cell.title.text = title;
    cell.detail.text = detail;
    [cell.image setImage:[UIImage imageNamed:image]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 55.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ([UIScreen mainScreen].bounds.size.height-self.tabBarController.tabBar.frame.size.height - 64 -150 - 4*55)/5.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, (self.tabBarController.tabBar.frame.origin.y - self.navigationController.navigationBar.frame.origin.y - self.navigationController.navigationBar.frame.size.height -150 - 4*55)/5.0)];
    [headerView setBackgroundColor:[UIColor colorWithRed:224/250.0 green:224/250.0 blue:224/250.0 alpha:1.0]];
    return headerView;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    if(section == 0)
    {
        FoodRaiderViewController *foodRaiderViewController = [[FoodRaiderViewController alloc] initWithNibName:@"FoodRaiderViewController" bundle:nil];
        foodRaiderViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:foodRaiderViewController animated:YES];
    }
    else if(section == 1)
    {
        FeastActivityViewController *feastActivityViewController = [[FeastActivityViewController alloc] initWithNibName:@"FeastActivityViewController" bundle:nil];
        feastActivityViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:feastActivityViewController animated:YES];
    }
    else if(section == 2)
    {
        DiscountStoresListViewController *discountStoresList = [[DiscountStoresListViewController alloc] initWithNibName:@"DiscountStoresListViewController" bundle:nil];
        discountStoresList.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:discountStoresList animated:YES];
    }
    else if(section == 3)
    {
        [self jumpToCardIntroduceViewController:self];
    }
}

//跳到美食达人卡界面
-(void)jumpToCardIntroduceViewController:(id)sender
{
    CardIntroduceViewController *cardIntroduceViewController = [[CardIntroduceViewController alloc] initWithNibName:@"CardIntroduceViewController" bundle:nil];
    cardIntroduceViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cardIntroduceViewController animated:YES];
    NSLog(@"1");
}

//展示欢迎界面+
- (void)showIntroWithCrossDissolve
{
    EAIntroPage *page1 = [EAIntroPage page];
    EAIntroPage *page2 = [EAIntroPage page];
    EAIntroPage *page3 = [EAIntroPage page];
    EAIntroPage *page4 = [EAIntroPage page];
    
    //如果是iphone5 5s 5c
    if(IphoneHeiht>=568)
    {
        page1.titleImage = [UIImage imageNamed:@"welcom_guide_page1136_1"];
        page2.titleImage = [UIImage imageNamed:@"welcom_guide_page1136_2"];
        page3.titleImage = [UIImage imageNamed:@"welcom_guide_page1136_3"];
        page4.titleImage = [UIImage imageNamed:@"welcom_guide_page1136_4"];
    }
    //如果是iphone4 4s
    else if(IphoneHeiht <568)
    {
        page1.titleImage = [UIImage imageNamed:@"welcom_guide_page960_1"];
        page2.titleImage = [UIImage imageNamed:@"welcom_guide_page960_2"];
        page3.titleImage = [UIImage imageNamed:@"welcom_guide_page960_3"];
        page4.titleImage = [UIImage imageNamed:@"welcom_guide_page960_4"];
    }
    
    intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4]];
    
    [intro setDelegate:self];
    [intro showInView:self.tabBarController.view.window animateDuration:0.0];
    self.tabBarController.view.hidden = YES;
    self.tabBarController.view.window.backgroundColor = [UIColor whiteColor];
}
//欢迎界面完了，调用下面方法
- (void)introDidFinish
{
    [UIView animateWithDuration:0.6 animations:^{
        
        self.tabBarController.view.hidden = NO;
        [self addressLabelPopUp:self];
        //lauch image set full screen ,indexViewController setback statusBar is visibled
       [globalVariateModel setIsFirstTimeUseApp:@"no"];
    }completion:nil];
}


@end
