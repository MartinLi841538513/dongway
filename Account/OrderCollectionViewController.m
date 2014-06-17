//
//  OrderCollectionViewController.m
//  Account
//
//  Created by dongway on 13-11-4.
//
//

#import "OrderCollectionViewController.h"
#import "OrderCell.h"
#import "MakeStoreCommentViewController.h"
#import "Common.h"
#import "SVProgressHUD.h"
#import "OrderInfosModel.h"
#import "GlobalVariateModel.h"
#import "UserInfosModel.h"
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface OrderCollectionViewController ()
{
    
    BOOL currentOrderIsSelected;
    BOOL historyOrderIsSelected;
    NSArray *ordersArray;
    UIBarButtonItem *orderSwitchButton;
    NSString *type;
    NSString *userName;
    OrderInfosModel *orderInfosModel;
    GlobalVariateModel *globalVariateModel;
    UserInfosModel *userInfosModel;
    Common *common;
    UIActivityIndicatorView *activityIndicatorView;
//    NSArray *currentOrders;
//    NSArray *historyOrders;
}

@end

@implementation OrderCollectionViewController

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
    common =[[Common alloc] init];
    [common returnButton:self];
    
    currentOrderIsSelected = YES;
    historyOrderIsSelected = NO;
    type = @"";//@“”当前有效订单 @“2”历史订单
    

    
    self.segement.segmentedControlStyle = UISegmentedControlStyleBar;
    self.segement.tintColor = [UIColor redColor];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [self.segement setFrame:CGRectMake(20, self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height+10, 280, 30)];
    }
    else
    {
        [self.segement setFrame:CGRectMake(20, 10, 280, 30)];
    }

    
    orderInfosModel = [[OrderInfosModel alloc] init];
    globalVariateModel = [[GlobalVariateModel alloc] init];
    userInfosModel = [[UserInfosModel alloc] init];
    [userInfosModel setPropertysWithDictionary:[globalVariateModel userInfos]];
    activityIndicatorView = [[UIActivityIndicatorView alloc] init];
    userName = userInfosModel.userName;
    
    self.tableView.hidden = YES;
    self.tip.hidden = YES;
    
    [SVProgressHUD addActivityView:activityIndicatorView toViewController:self];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [orderInfosModel setOrderByUserWithUsername:userName andType:type];
        ordersArray = orderInfosModel.orderInfos;
        dispatch_async(dispatch_get_main_queue(), ^{
            [activityIndicatorView stopAnimating];
            if([ordersArray count] == 0)
            {
                [SVProgressHUD showImage:nil status:@"你没有当前订单"];
                self.tip.text = @"没有当前订单";
                self.tip.hidden = NO;
                self.tableView.hidden = YES;
            }
            else
            {
                self.tip.hidden = YES;
                self.tableView.hidden = NO;
                 [self.tableView reloadData];
            }
            

        });
    });
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [self.tableView setFrame:CGRectMake(0, self.segement.frame.origin.y+self.segement.frame.size.height+5, 320, self.view.frame.size.height-110)];
    }
    else
    {
        [self.tableView setFrame:CGRectMake(0, self.segement.frame.origin.y+self.segement.frame.size.height+5, 320, self.view.frame.size.height-55)];
    }

}



-(void)orderSwitchAction:(id)sender
{
    self.tableView.hidden= YES;
    self.tip.hidden = YES;
    [SVProgressHUD addActivityView:activityIndicatorView toViewController:self];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        if(currentOrderIsSelected == YES)
        {
            currentOrderIsSelected = NO;
            historyOrderIsSelected = YES;
            type = @"2";
            
        }
        else if(historyOrderIsSelected == YES)
        {
            currentOrderIsSelected = YES;
            historyOrderIsSelected = NO;
            type = @"";
            
        }
        
        [orderInfosModel setOrderByUserWithUsername:userName andType:type];
        ordersArray = orderInfosModel.orderInfos;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [activityIndicatorView stopAnimating];
            if([ordersArray count] == 0)
            {
                [SVProgressHUD showImage:nil status:@"你没有当前订单"];
                if(currentOrderIsSelected==YES)
                {
                    self.tip.text = @"没有当前订单";
                }
                else
                {
                    self.tip.text = @"没有历史订单";
                }
               
                self.tip.hidden = NO;
                self.tableView.hidden = YES;
            }
            else
            {
                self.tip.hidden = YES;
                self.tableView.hidden = NO;
                if(currentOrderIsSelected == YES)
                {
                    self.title = @"当前订单";
                    orderSwitchButton.title = @"历史订单";
                }
                else if(historyOrderIsSelected == YES)
                {
                    self.title = @"历史订单";
                    orderSwitchButton.title = @"当前订单";
                }

            }

            
            [self.tableView reloadData];
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
    return [ordersArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellTableIdentifier = @"CellTableIdentifier";
    NSUInteger section = [indexPath section];
    NSDictionary *orderInformationDictionary = [ordersArray objectAtIndex:section];
    [orderInfosModel setPropertysWithDictionary:orderInformationDictionary];
    // Configure the cell...
    BOOL nibsRegistered = NO;
    if(!nibsRegistered)
    {
        UINib *nib = [UINib nibWithNibName:@"OrderCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier: CellTableIdentifier];
        nibsRegistered = YES;
    }
    OrderCell *cell = (OrderCell *)[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    
    NSString *time = [orderInfosModel.orderTime substringWithRange:NSMakeRange(0, 16)];;
    
    cell.orderID.text = orderInfosModel.md5ID;
    cell.orderedUsername.text = [NSString stringWithFormat:@"预定人:   %@",orderInfosModel.orderName];
    cell.orderedPhone.text = [NSString stringWithFormat:@"电    话:  %@",orderInfosModel.orderTel];
    cell.orderedTime.text = [NSString stringWithFormat:@"时    间:  %@",time];
    cell.orderedStoreName.text = orderInfosModel.storeName;
    cell.orderedDetail.text = orderInfosModel.tableInfo;
    cell.orderedAddress.text = orderInfosModel.address;
    cell.orderedStorePhone.text = orderInfosModel.storeTel;
    if(orderInfosModel.note==nil||[orderInfosModel.note isEqualToString:@""])
    {
        cell.tips.text = @"无";
    }
    else
    {
        cell.tips.text = orderInfosModel.note;
    }
    
    if(currentOrderIsSelected == YES)
        cell.backgroundColor = [UIColor whiteColor];
    else if(historyOrderIsSelected == YES)
        cell.backgroundColor = [UIColor colorWithRed:227/255.0 green:224/255.0 blue:101/255.0 alpha:1];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 211.0f;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIActionSheet *actionSheet;
    if(currentOrderIsSelected == YES)
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"短信邀请朋友共聚美餐吧!" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定!" otherButtonTitles:nil];
    else if(historyOrderIsSelected == YES)
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"是否对该商家进行评论!" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定!" otherButtonTitles:nil];
    else
    {
        //提示报错（按道理是不会错的，防止万一）
    }
    actionSheet.tag = indexPath.section;
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //如果是当前订单，则单击短信邀请好友
    if(currentOrderIsSelected == YES)
    {
        if(buttonIndex == [actionSheet destructiveButtonIndex])
        {
            [self sendMessage:[ordersArray objectAtIndex:actionSheet.tag]];
        }
        else if(buttonIndex == [actionSheet cancelButtonIndex])
        {
            return;
        }
    }
    //如果是历史订单，单击对该商家评论
    else if(historyOrderIsSelected == YES)
    {
        if(buttonIndex == [actionSheet destructiveButtonIndex])
        {
            MakeStoreCommentViewController *storeCommentView = [[MakeStoreCommentViewController alloc] init];
            [orderInfosModel setPropertysWithDictionary:[ordersArray objectAtIndex:actionSheet.tag]];
            storeCommentView.storeId = orderInfosModel.storeID;
            [self.navigationController pushViewController:storeCommentView animated:YES];
        }
        else if(buttonIndex == [actionSheet cancelButtonIndex])
        {
            return;
        }
    }
}

- (void)sendMessage:(NSDictionary *)orderDictionary
{
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if (messageClass != nil) {
        // Check whether the current device is configured for sending SMS messages
        if ([messageClass canSendText]) {
            [self displaySMSComposerSheet:orderDictionary];
        }
        else {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@""message:@"设备不支持短信功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }
    else {
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultCancelled:
            //            if(DEBUG)
            //                NSLog(@"Result: Mail sending cancelled");
            break;
        case MessageComposeResultFailed:
            //            if(DEBUG)
            //                NSLog(@"Result: Mail sending failed");
            break;
        case MessageComposeResultSent:
            //            if(DEBUG)
            //                NSLog(@"Result: Mail sent");
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)displaySMSComposerSheet:(NSDictionary *)orderDictionary
{
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate =self;
    [orderInfosModel setPropertysWithDictionary:orderDictionary];
    //短信内容
    NSString *orderName = orderInfosModel.orderName;
    NSString *orderTime = [orderInfosModel.orderTime substringWithRange:NSMakeRange(0, 16)];
    NSString *storeName = orderInfosModel.storeName;
    NSString *tableInfo = orderInfosModel.tableInfo;
    NSString *orderTel = orderInfosModel.orderTel;
    NSString *address = orderInfosModel.address;
    
    NSString *smsBody = [NSString stringWithFormat:@"%@:邀请您参加%@在%@【%@】的聚会，联系方式:%@  地址:%@ 【懂味网】 ",orderName,orderTime,storeName,tableInfo,orderTel,address];
    picker.body = smsBody;
    [self presentViewController:picker animated:YES completion:nil];
}


- (IBAction)segementAction:(id)sender
{
    if ([sender selectedSegmentIndex] == 0)
    {
        NSLog(@"1");
    }
    else
    {
        NSLog(@"2");
    }
    [self orderSwitchAction:sender];
}
@end
