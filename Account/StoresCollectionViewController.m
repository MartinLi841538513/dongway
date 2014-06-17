//
//  RestaurantCollectionViewController.m
//  Account
//
//  Created by wang zhe on 7/18/13.
//
//

#import "StoresCollectionViewController.h"
#import "StoresCollectionCell.h"
#import "Common.h"
#import "SVProgressHUD.h"
#import "StoresModel.h"
#import "GlobalVariateModel.h"
#import "UserInfosModel.h"
#import "StoreDetailViewController.h"

@interface StoresCollectionViewController ()
{
    NSMutableArray *storesCollectionArray;
    NSInteger rowForDelete;
    NSIndexPath *indexPathForDelete;
    Common *common;
    StoresModel *storesModel;
    GlobalVariateModel *globalVariateModel;
    UserInfosModel *userInfosModel;
}
@end

@implementation StoresCollectionViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
//    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    self.title = @"商家收藏";
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    common = [[Common alloc] init];
    storesModel = [[StoresModel alloc] init];
    globalVariateModel = [[GlobalVariateModel alloc] init];
    userInfosModel = [[UserInfosModel alloc] init];
    [userInfosModel setPropertysWithDictionary:[globalVariateModel userInfos]];
    
    [common returnButton:self];
    NSString *userName = userInfosModel.userName;
    
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [storesModel setStoresWithUsername:userName];
        storesCollectionArray = [[NSMutableArray alloc] initWithArray:storesModel.stores];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
//    [SVProgressHUD dismiss];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [storesCollectionArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellTableIdentifier = @"CellTableIdentifier";
    NSUInteger section = [indexPath row];
    NSDictionary *storesCollectionInformation = [storesCollectionArray objectAtIndex:section];
    [storesModel setPropertysWithDictionary:storesCollectionInformation];
    
    // Configure the cell...
    BOOL nibsRegistered = NO;
    if(!nibsRegistered)
    {
        UINib *nib = [UINib nibWithNibName:@"StoresCollectionCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
        nibsRegistered = YES;
    }
    
    StoresCollectionCell *cell = (StoresCollectionCell *)[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    cell.storeScore.image = [UIImage imageNamed:[common starName:storesModel.score]];
    cell.storeName.text = storesModel.storeName;
    cell.storeAddress.text = storesModel.address;
    cell.storePrice.text = storesModel.price;
    cell.storeNumber.text = storesModel.telephone;
    
    UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(deleteCell:)];
    longPressGesture.minimumPressDuration = 1.0;
    [cell addGestureRecognizer:longPressGesture];

    return cell;
}


-(void)deleteCell:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        CGPoint location = [gestureRecognizer locationInView:self.tableView];
        indexPathForDelete = [self.tableView indexPathForRowAtPoint:location];
        rowForDelete = [indexPathForDelete row];
        StoresCollectionCell *cell = (StoresCollectionCell *)gestureRecognizer.view;
        //这里把cell做为第一响应(cell默认是无法成为responder,需要重写canBecomeFirstResponder方法)
        [cell becomeFirstResponder];
        UIMenuItem *itCancel = [[UIMenuItem alloc] initWithTitle:@"取消" action:@selector(longHandleCancelCell:)];
        UIMenuItem *itDelete = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(longHandleDeleteCell:)];
        
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuItems:[NSArray arrayWithObjects:itCancel, itDelete,  nil]];
        [menu setTargetRect:cell.frame inView:self.tableView];
        [menu setMenuVisible:YES animated:YES];
        
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 73.0f;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SVProgressHUD show];
    NSUInteger section = [indexPath row];
    
    NSDictionary *storesCollectionInformation = [storesCollectionArray objectAtIndex:section];
    StoreDetailViewController *storeDetailView = [[StoreDetailViewController alloc] initWithNibName:@"StoreDetailViewController" bundle:nil];
    [storesModel setPropertysWithDictionary:storesCollectionInformation];
    storeDetailView.storesModel = storesModel;
    storeDetailView.isDiscountStore = NO;
    storeDetailView.isCollectedStore  = YES;
    [self.navigationController pushViewController:storeDetailView animated:YES];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self swipeHandleDeleteCell:indexPath];
    }
}

- (void)longHandleCancelCell:(id)sender
{
    //取消删除cell
    return;
}
//长按删除
- (void)longHandleDeleteCell:(id)sender
{
    [self handleDeleteCell:indexPathForDelete];
}
//滑动删除
-(void)swipeHandleDeleteCell:(NSIndexPath *)indexPath
{
    [self handleDeleteCell:indexPath];
}

-(void)handleDeleteCell:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSDictionary *storeForDelete = [storesCollectionArray objectAtIndex:row];
    [storesCollectionArray removeObjectAtIndex:row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [NSThread detachNewThreadSelector:@selector(handleDeleteData:) toTarget:self withObject:storeForDelete];
}
-(void)handleDeleteData:(NSDictionary *)storeForDelete
{
    NSString *userName = userInfosModel.userName;
    [storesModel setPropertysWithDictionary:storeForDelete];
    NSString *storeId = storesModel.storeId;
    
    @synchronized(storesModel)
    {
        [storesModel deleteCollectedStoreWithStoreID:storeId andUsername:userName];
        storesCollectionArray = [[NSMutableArray alloc] initWithArray:storesModel.stores];

    }
}

@end
