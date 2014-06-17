//
//  AllCouponStoreViewController.m
//  Account
//
//  Created by wang zhe on 7/22/13.
//1。网站更新，加班
//2.内容新要求
//3。百度主要抓取静态html
//

#import "DiscountStoresListViewController.h"
#import "AllCouponCell.h"
#import "Common.h"
#import "SVProgressHUD.h"
#import "DiscountInfosModel.h"
#import "DiscountStoreListService.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "StoreDetailViewController.h"
#import "StoresModel.h"


@interface DiscountStoresListViewController ()
{
    NSArray *storesCoupon;
    NSMutableArray *discountInfoMutableArray;
    Common *common;
    BOOL internetStatusBool;
    NSInteger pageNumberInt;
    DiscountInfosModel *discountInfosModel;
    DiscountStoreListService *discountStoreListService;
    StoresModel *storeModel;
}
@end

@implementation DiscountStoresListViewController

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
    
    
    [SVProgressHUD dismiss];
    common = [[Common alloc] init];
    discountInfosModel = [[DiscountInfosModel alloc] init];
//    storeModel = [[StoresModel alloc] init];
    discountStoreListService = [[DiscountStoreListService alloc] init];
    discountInfoMutableArray = [[NSMutableArray alloc] init];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top.png"] forBarMetrics:UIBarMetricsDefault];//导航栏背景
    [self.navigationItem setTitle:@"优    惠"];
    
    self.tableView=[[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height-114) pullingDelegate:self];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    self.tableView.headerOnly = NO;
    self.tableView.bottomOnly = NO;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.automaticallyAdjustsScrollViewInsets =YES;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    float iphoneHeight = [[UIScreen mainScreen] bounds].size.height;
    [self.tableView setFrame:CGRectMake(0, 0, 320, iphoneHeight -self.navigationController.navigationBar.frame.size.height-8)];
    
   [common returnButton:self];
    
    pageNumberInt = 1;    
    
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [discountInfosModel setDiscountInfosWithPageNumber:@"1" andStoreID:@""];
        NSArray *discountInfoArray = discountInfosModel.discountInfoArray;
        [discountStoreListService mutableArray:discountInfoMutableArray appendedByArray:discountInfoArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
            self.tableView.scrollEnabled = YES;
        });
    });
}

-(void)viewWillAppear:(BOOL)animated
{
   }

-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //frame应在表格加载完数据源之后再设置
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
    return [discountInfoMutableArray count];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    NSDictionary *discountInfosDictionary = [discountInfoMutableArray objectAtIndex:section];
    [discountInfosModel setPropertysWithDictionary:discountInfosDictionary];
    static NSString *CellTableIdentifier = @"Cell";
    // Configure the cell...
    BOOL nibsRegistered = NO;
    if(!nibsRegistered)
    {
        UINib *nib = [UINib nibWithNibName:@"AllCouponCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
        nibsRegistered = YES;
    }
    AllCouponCell *cell = (AllCouponCell *)[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    //用小图，节省流量
    NSString *imageUrlThumbs;
    imageUrlThumbs =[discountInfosModel.picUrl stringByReplacingOccurrencesOfString:@".jpg" withString:@".thumbs.jpg"];
    imageUrlThumbs =[discountInfosModel.picUrl stringByReplacingOccurrencesOfString:@".png" withString:@".thumbs.png"];
    [cell.discountStroreImage setImageWithURL:[NSURL URLWithString:imageUrlThumbs] placeholderImage:[UIImage imageNamed:@"logoLoading.jpg"]];
     
    cell.storeName.text = discountInfosModel.storeName;
    
    NSString *content = discountInfosModel.content;
    cell.content.text = content;
    CGSize newContentInCellFrame2 = [content sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(164, 2000) lineBreakMode:NSLineBreakByCharWrapping];
    
    if(newContentInCellFrame2.height<60)
        cell.content.frame = CGRectMake(cell.content.frame.origin.x, cell.content.frame.origin.y, newContentInCellFrame2.width, newContentInCellFrame2.height+1);
    else
        cell.content.frame = CGRectMake(cell.content.frame.origin.x, cell.content.frame.origin.y, newContentInCellFrame2.width, 60);
    
    
    NSString *address = discountInfosModel.address;
    cell.discountStoreAdress.text = address;
    CGSize newContentInCellFrame1 = [address sizeWithFont:[UIFont systemFontOfSize:10.0f] constrainedToSize:CGSizeMake(155, 2000.0f) lineBreakMode:NSLineBreakByCharWrapping];
    cell.discountStoreAdress.frame = CGRectMake(cell.discountStoreAdress.frame.origin.x, cell.content.frame.origin.y+cell.content.frame.size.height+5, newContentInCellFrame1.width+1, newContentInCellFrame1.height+1);
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 138;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 12.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320,12)];
    [headerView setBackgroundColor:[UIColor colorWithRed:224/250.0 green:224/250.0 blue:224/250.0 alpha:1.0]];
    return headerView;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    NSDictionary *discountInfosDictionary = [discountInfoMutableArray objectAtIndex:section];

    [discountInfosModel setPropertysWithDictionary:discountInfosDictionary];
    
    StoreDetailViewController *storeDetailViewController = [[StoreDetailViewController alloc] initWithNibName:@"StoreDetailViewController" bundle:nil];
    storeDetailViewController.discountInfosModel = discountInfosModel;
    storeDetailViewController.isDiscountStore = YES;
    [self.navigationController pushViewController:storeDetailViewController animated:YES];
}



#pragma mark - Your actions
//加载更多数据
- (void)loadMoreData
{
    pageNumberInt++;
    NSString *pageNumberString = [NSString stringWithFormat:@"%d", pageNumberInt];
    [discountInfosModel setDiscountInfosWithPageNumber:pageNumberString andStoreID:@""];
    NSArray *discountInfoArray = discountInfosModel.discountInfoArray;
    
    if ([discountInfoArray count] == 0)
    {
        [self.tableView tableViewDidFinishedLoadingWithMessage:@"没有更多数据了!"];
        self.tableView.reachedTheEnd  = YES;
    }
    else
    {
        [discountStoreListService mutableArray:discountInfoMutableArray appendedByArray:discountInfoArray];
        [self.tableView tableViewDidFinishedLoading];
        self.tableView.reachedTheEnd  = NO;
        [self.tableView reloadData];
    }
}

//刷新数据
-(void)refreshData
{
    pageNumberInt = 1;
    [discountInfosModel setDiscountInfosWithPageNumber:@"1" andStoreID:@""];
    NSArray *discountInfoArray = discountInfosModel.discountInfoArray;
    
    if([discountInfoArray count] == 0)
    {
        [self.tableView tableViewDidFinishedLoadingWithMessage:@"没有更多数据了!"];
        self.tableView.reachedTheEnd  = YES;
    }
    else
    {
        [discountInfoMutableArray removeAllObjects];
        [discountStoreListService mutableArray:discountInfoMutableArray appendedByArray:discountInfoArray];
        [self.tableView tableViewDidFinishedLoadingWithMessage:@"刷新成功!"];
        self.tableView.reachedTheEnd = NO;
        [self.tableView reloadData];
    }
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

@end
