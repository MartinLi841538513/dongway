//
//  RecommendStoreViewController.m
//  Account
//
//  Created by wang zhe on 7/23/13.
//
//
#import <Foundation/Foundation.h>

#import "NearbyViewController.h"
#import "NearbyStoreCell.h"
#import "FoodRaiderViewController.h"
#import "Common.h"
#import "SVProgressHUD.h"
#import "StoresModel.h"
#import "GlobalVariateModel.h"
#import "StoreDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDWebImageManager.h>
#import <SDWebImage/SDImageCache.h>

#import "AdvancedSearchViewController.h"
#import "JDNAutoNaviMapViewController.h"
#define IphoneHeight [UIScreen mainScreen].applicationFrame.size.height


@interface NearbyViewController ()
{
    NSMutableArray *recommendStoresMutableArray;
    Common *common;
    NSInteger pageNumberInt;
    float introductionHeight;
    NSString *cat;
    NSString *latitude;
    NSString *longitude;
    NSString *radius;
    NSString *sort;
    NSString *page;
    NSString *price;
    NSString *term;
    NSArray *recommendStoresArray;
    StoresModel *storesModel;
    GlobalVariateModel *globalVariateModel;
    UIImageView *advancedSearch;
    UIActivityIndicatorView *activityIndicatorView;
    float tableviewHeight;
    UIImageView *tipView;
}
@end



@implementation NearbyViewController
@synthesize locationName;

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
    //这是重新定位按钮用图片表示的一种做法
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top.png"] forBarMetrics:UIBarMetricsDefault];//导航栏背景
    [self.navigationController.navigationBar setBackgroundColor:[UIColor orangeColor]];

    //这是搜索按钮用图片表示的一种做法
    UIButton *searchButton = [[UIButton alloc] init];
    searchButton.frame=CGRectMake(0,0,31,25);
    [searchButton setBackgroundImage:[UIImage imageNamed:@"mapModel.png"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(mapModelAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    
    //高级搜索
    advancedSearch = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"advancedSearch.png"]];
    [self.view insertSubview:advancedSearch atIndex:1];
    advancedSearch.userInteractionEnabled = YES;
    UITapGestureRecognizer *advancedSearchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(advancedSearchTap:)];
    [advancedSearch addGestureRecognizer:advancedSearchTap];
    
    self.tableView=[[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height-60) pullingDelegate:self];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view insertSubview:self.tableView atIndex:0];
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    self.tableView.headerOnly = NO;
    self.tableView.bottomOnly = NO;

    
    common = [[Common alloc] init];
    
    storesModel = [[StoresModel alloc] init];
    globalVariateModel = [[GlobalVariateModel alloc] init];
    recommendStoresMutableArray = [[NSMutableArray alloc] init];
    activityIndicatorView = [[UIActivityIndicatorView alloc] init];

    if(self.hidesBottomBarWhenPushed == YES)
    {
        [common returnButton:self];
    }
    

    tableviewHeight = IphoneHeight -self.navigationController.navigationBar.frame.size.height-2;
    float advanceLogo = IphoneHeight - 130;
    //普通搜索，分类搜索
    if(self.isAdvancedSearch == YES)
    {
        cat = self.catForPass;
        radius = self.radiusForPass;
        sort = self.sortForPass;
        price = self.priceForPass;
        latitude = self.latitudeForPass;
        longitude = self.longitudeForPass;
        page = self.pageForPass;
        term = self.termForPass;
        
    }
    //附近搜索(推荐商家)
    else
    {
        [self setValueForRecommendStores];
        tableviewHeight = tableviewHeight-self.tabBarController.tabBar.frame.size.height;
        advanceLogo = advanceLogo -self.tabBarController.tabBar.frame.size.height;
    }
    [advancedSearch setFrame:CGRectMake(10, advanceLogo, 81, 45)];
    [self.tableView setFrame:CGRectMake(0, 0,320 , tableviewHeight)];

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.automaticallyAdjustsScrollViewInsets =YES;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

   //    //以下经纬度是测试数据，最后要删除 力力渔港
//    latitude = @"28.195279";
//    longitude = @"112.976317";
    
    
    if(!self.isAdvancedSearch)
    {
        //如果定位失败，默认用五一广场为自己坐标
        if(![globalVariateModel.locationIsAvailabelOnPhone isEqualToString:@"yes"])
        {
            latitude = @"28.195279";
            longitude = @"112.976317";
            self.locationName = @"定位失败，默认你在五一广场";
        }
        else
        {
            latitude = [globalVariateModel latitude];
            longitude = [globalVariateModel longitude];
            self.locationName = [common userAddress];
        }
    }
    
    self.tableView.hidden = YES;
    
    //如果是第一次使用这个软件，展示欢迎界面
    if(![globalVariateModel.isFirstTimeEnterNearbyView isEqualToString:@"no"])
    {
        //如果是第一次使用这个软件，展示提示界面
        [UIView animateWithDuration:0.2 animations:^{
            
            tipView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"neabyTips.jpg"]];
            [tipView setFrame:CGRectMake(0, 20, 320, [UIScreen mainScreen].bounds.size.height-20)];
            [self.navigationController.tabBarController.view addSubview:tipView];
            self.navigationController.navigationBarHidden = YES;
            self.tabBarController.tabBar.hidden = YES;
            tipView.userInteractionEnabled = YES;
            self.tableView.hidden = YES;
            UITapGestureRecognizer *tipViewActionButton = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tipViewAction:)];
            [tipView addGestureRecognizer:tipViewActionButton];
        }];
        
    }

    [self loadNearbyStores];
}

//加载附近商家
-(void)loadNearbyStores
{
    

    [SVProgressHUD addActivityView:activityIndicatorView toViewController:self];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //普通搜索，分类搜索
        if(self.isAdvancedSearch == YES)
        {
            [storesModel setStoresWithCat:cat andLatitude:latitude andLongitude:longitude andRadius:radius andSort:sort andPage:page andPrice:price andTerm:term];
        }
        //取得推荐商家(附近商家)
        else
        {
            [storesModel setRecommendedStoresWithCat:cat andLatitude:latitude andLongitude:longitude andRadius:radius andSort:sort andPage:page andPrice:price];
        }
        
        recommendStoresArray = storesModel.stores;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [activityIndicatorView stopAnimating];
            if([recommendStoresArray count] == 0)
            {
                [SVProgressHUD showImage:nil status:@"没有搜索到商家"];
                self.tip.hidden = NO;
                self.refreshButton.hidden = NO;
                self.tableView.hidden = YES;
                
            }
            else
            {
                self.tip.hidden = YES;
                self.refreshButton.hidden = YES;
                //如果是第一次进来neabyview，显示提示信息
                if(![globalVariateModel.isFirstTimeEnterNearbyView isEqualToString:@"no"])
                {
                    
                }
                else
                {
                    self.tableView.hidden = NO;
                }
                for(int i = 0;i < [recommendStoresArray count];i++)
                {
                    [recommendStoresMutableArray addObject:[recommendStoresArray objectAtIndex:i]];
                }
                
                [self.tableView reloadData];
                [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
                self.tableView.scrollEnabled = YES;
            }
            
        });
    });

}

-(void)tipViewAction:(id)sender
{
    [UIView animateWithDuration:0.6 animations:^{
        
        self.navigationController.navigationBarHidden = NO;
        //如果是普通搜索，分类搜索
        if(self.isAdvancedSearch == YES)
        {
            self.tabBarController.tabBar.hidden = YES;
        }
        //附近商家
        else
        {
            self.tabBarController.tabBar.hidden = NO;
        }

        self.tableView.hidden = NO;
        [tipView removeFromSuperview];
    }];
    [globalVariateModel setIsFirstTimeEnterNearbyView:@"no"];
}

-(void)viewWillAppear:(BOOL)animated
{
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

//地图模式
-(void)mapModelAction:(id)sender
{
    JDNAutoNaviMapViewController *mapModelViewController = [[JDNAutoNaviMapViewController alloc] init];
    mapModelViewController.recommendStoresArray = recommendStoresMutableArray;
    mapModelViewController.isFromListStores = YES;
    mapModelViewController.latitude = latitude;
    mapModelViewController.longitude = longitude;
    mapModelViewController.locationName = self.locationName;
    mapModelViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mapModelViewController animated:YES];
}

//高级搜索
-(void)advancedSearchTap:(id)sender
{
    
    
//    CAKeyframeAnimation *animation = nil;
//    NSMutableArray *arrTransform = [NSMutableArray arrayWithCapacity:0];
//    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//    animation.duration = 0.5f;
//    animation.calculationMode = kCAAnimationLinear;
//    [arrTransform addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1.0)]];
//    [arrTransform addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5, 1.0)]];
//    [arrTransform addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
//    [arrTransform addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
//    animation.values = arrTransform;
//    
//    [advancedSearch.layer addAnimation:animation forKey:@"bounce"];
    
    AdvancedSearchViewController *advancedSearchViewController = [[AdvancedSearchViewController alloc] initWithNibName:@"AdvancedSearchViewController" bundle:nil];
    advancedSearchViewController.delegate = self;
    
    [UIView animateWithDuration:0.8 animations:^{
        
        [self addChildViewController:advancedSearchViewController];
        
        [self.view addSubview:advancedSearchViewController.view];
    
    } completion:^(BOOL finished){
        
    }];
    
}

#pragma mark - Your actions
- (void)loadMoreData
{
    pageNumberInt = [page integerValue];
    pageNumberInt++;
    page = [NSString stringWithFormat:@"%d", pageNumberInt];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //普通搜索，分类搜索,高级搜索
        if(self.isAdvancedSearch == YES)
        {
            [storesModel setStoresWithCat:cat andLatitude:latitude andLongitude:longitude andRadius:radius andSort:sort andPage:page andPrice:price andTerm:term];
        }
        //推荐商家
        else
        {
            [storesModel setRecommendedStoresWithCat:cat andLatitude:latitude andLongitude:longitude andRadius:radius andSort:sort andPage:page andPrice:price];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSArray *recommendStoreArray = storesModel.stores;
            
            if ([recommendStoreArray count] == 0)
            {
                [self.tableView tableViewDidFinishedLoadingWithMessage:@"没有更多数据了!"];
                self.tableView.reachedTheEnd  = YES;
            } else {
                for(int i = 0;i < [recommendStoreArray count];i++)
                {
                    [recommendStoresMutableArray addObject:[recommendStoreArray objectAtIndex:i]];
                }
                [self.tableView tableViewDidFinishedLoading];
                self.tableView.reachedTheEnd  = NO;
                [self.tableView reloadData];
            }
        });
    });
}

//刷新回到推荐商家数据
-(void)refreshData
{
    [self setValueForRecommendStores];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [storesModel setRecommendedStoresWithCat:cat andLatitude:latitude andLongitude:longitude andRadius:radius andSort:sort andPage:page andPrice:price];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            recommendStoresArray = storesModel.stores;
            if([recommendStoresArray count] == 0)
            {
                [self.tableView tableViewDidFinishedLoadingWithMessage:@"没有更多数据了!"];
                self.tableView.reachedTheEnd  = YES;
            }
            else
            {
                [recommendStoresMutableArray removeAllObjects];
                for(int i = 0;i < [recommendStoresArray count];i++)
                {
                    [recommendStoresMutableArray addObject:[recommendStoresArray objectAtIndex:i]];
                }
                [self.tableView tableViewDidFinishedLoadingWithMessage:@"刷新成功,取得附近商家数据!"];
                self.tableView.reachedTheEnd = NO;
                [self.tableView reloadData];
                
            }
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [recommendStoresMutableArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    NSDictionary *recommendStore = [recommendStoresMutableArray objectAtIndex:section];
    [storesModel setPropertysWithDictionary:recommendStore];
    static NSString *CellTableIdentifier = @"Cell";
    // Configure the cell...
    NearbyStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NearbyStoreCell" owner:self options:nil] lastObject];
    }
    
    cell.storeName.text = storesModel.storeName;
    cell.starRating.image = [UIImage imageNamed:[common starName:storesModel.score]];
    cell.price.text =[NSString stringWithFormat:@"人均：%@ 元",storesModel.price];
    cell.address.text = storesModel.address;
    cell.distance.text = storesModel.distance;
    NSString *introductionString;
    if([storesModel.introduction isEqualToString:@""])
    {
        introductionString = storesModel.introduction;
    }
    else
    {
        introductionString = [NSString stringWithFormat:@"描述:%@",storesModel.introduction];
    }
    cell.introduction.text = introductionString;
    CGSize newContentInCellFrame = [introductionString sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(300.0f, 2000.0f) lineBreakMode:NSLineBreakByCharWrapping];
    cell.introduction.frame = CGRectMake(cell.introduction.frame.origin.x, cell.introduction.frame.origin.y, newContentInCellFrame.width, newContentInCellFrame.height+5);
    
    
    //accuracy=1有桌位  //status=20有优惠
    int accuracy = [storesModel.accuracy intValue];
    int status = [storesModel.status intValue];
    if(accuracy == 1)
    {
        cell.accuracy.hidden = NO;
    }
    else
    {
        cell.accuracy.hidden = YES;
    }
    if(status == 20)
    {
        cell.status.hidden = NO;
    }
    else
    {
        cell.status.hidden = YES;
    }
    
    NSString *imageurl = storesModel.imageUrl;
    imageurl = [imageurl stringByReplacingOccurrencesOfString:@".jpg" withString:@".thumbs.jpg"];
    imageurl = [imageurl stringByReplacingOccurrencesOfString:@".png" withString:@".thumbs.png"];
    
    [cell.storeImage setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"logoLoading.jpg"]];

    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    NSDictionary *recommendStore = [recommendStoresMutableArray objectAtIndex:section];
    [storesModel setPropertysWithDictionary:recommendStore];
    NSString *introductionString;
    //高级搜索的商家introduce为空
    if([storesModel.introduction isEqualToString:@""]||storesModel.introduction == nil)
    {
        introductionString = @"";
    }
    else
    {
        introductionString = [NSString stringWithFormat:@"描述:%@",storesModel.introduction];
    }
    CGSize newContentInCellFrame = [introductionString sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(300.0f, 2000.0f) lineBreakMode:NSLineBreakByCharWrapping];
   
    if([introductionString isEqualToString:@""])
    {
        return 110.0f;
    }
    else
    {
        return 125.0 + newContentInCellFrame.height;
    }
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    NSDictionary *recommendStoreDictionary = [recommendStoresMutableArray objectAtIndex:section];
    StoreDetailViewController *storeDetailView = [[StoreDetailViewController alloc] initWithNibName:@"StoreDetailViewController" bundle:nil];
    [storesModel setPropertysWithDictionary:recommendStoreDictionary];
    storeDetailView.storesModel = storesModel;
    storeDetailView.latitude = latitude;
    storeDetailView.longitude = longitude;
    storeDetailView.locationName = self.locationName;
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    storeDetailView.hidesBottomBarWhenPushed = YES;
    storeDetailView.isDiscountStore = NO;
    [self.navigationController pushViewController:storeDetailView animated:YES];
}

#pragma mark - PullingRefreshTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    self.refreshing = YES;
    [self performSelector:@selector(refreshData) withObject:nil afterDelay:1.f];
}

- (NSDate *)pullingTableViewRefreshingFinishedDate{
    NSDateFormatter *df = [[NSDateFormatter alloc] init ];
    df.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *date = [df dateFromString:@"2012-05-03 10:10"];
    
    
    return date;
}

- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    [self performSelector:@selector(loadMoreData) withObject:nil afterDelay:1.f];
}

#pragma mark - Scroll

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

//Mydelegate,高级搜索在此刷新数据
-(void)passValue:(NSString *)passCat andLatitude:(NSString *)passLatitude andLongitude:(NSString *)passLongitude andRadius:(NSString *)passRadius andSort:(NSString *)passSort andPrice:(NSString *)passPrice andTerm:(NSString *)passTerm andIsAdvanedSearch:(BOOL)passIsAdvanedSearch andLocationName:(NSString *)locationNam
{
    cat = passCat;
    latitude = passLatitude;
    longitude = passLongitude;
    radius = passRadius;
    sort = passSort;
    page = @"1";
    price = passPrice;
    term = @"";
    self.isAdvancedSearch = YES;

    self.tableView.scrollEnabled = NO;
    self.locationName = locationNam;
    
    self.tip.hidden = YES;
    self.refreshButton.hidden = YES;
    self.tableView.hidden = YES;
    
    [SVProgressHUD addActivityView:activityIndicatorView toViewController:self];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [storesModel setStoresWithCat:cat andLatitude:latitude andLongitude:longitude andRadius:radius andSort:sort andPage:page andPrice:price andTerm:term];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [activityIndicatorView stopAnimating];
            recommendStoresArray = storesModel.stores;
            if([recommendStoresArray count] == 0)
            {
                [SVProgressHUD showImage:nil status:@"没有搜索到商家"];
                self.tableView.hidden = YES;
                self.tip.hidden = NO;
                self.refreshButton.hidden = NO;
            }
            else
            {
                self.tableView.hidden = NO;
                self.tip.hidden = YES;
                self.refreshButton.hidden = YES;
                [recommendStoresMutableArray removeAllObjects];
                for(int i = 0;i < [recommendStoresArray count];i++)
                {
                    [recommendStoresMutableArray addObject:[recommendStoresArray objectAtIndex:i]];
                }
                [self.tableView reloadData];
                [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
                self.tableView.scrollEnabled = YES;
            }
        });
    });

}

//设置高级搜索的参数值
-(void)setValueForAdvancedSearch
{
    
}

//设置推荐商家的参数值
-(void)setValueForRecommendStores
{
    cat = @"1";
    radius = @"2500";
    term = @"";
    sort = @"1";
    price = @"1";
    page = @"1";
    
    //如果定位失败，默认用五一广场为自己坐标
    if(![globalVariateModel.locationIsAvailabelOnPhone isEqualToString:@"yes"])
    {
        latitude = @"28.195279";
        longitude = @"112.976317";
        self.locationName = @"定位失败，默认你在五一广场";
    }
    else
    {
        latitude = [globalVariateModel latitude];
        longitude = [globalVariateModel longitude];
        self.locationName = globalVariateModel.userAddress;
    }
    
    self.isAdvancedSearch = NO;
}


- (IBAction)refreshAction:(id)sender {
    
    [self setValueForRecommendStores];
    self.tip.hidden = YES;
    self.refreshButton.hidden = YES;
    [self loadNearbyStores];
}
@end
