//
//  SetUserInformationViewController.m
//  Account
//
//  Created by wang zhe on 9/13/13.
//
//

#import "SetUserInformationViewController.h"
#import "GlobalVariateModel.h"
#import "UserViewController.h"
#import "EditPasswordViewController.h"
#import "Common.h"
#import "UserInfosModel.h"
#import "SVProgressHUD.h"

@interface SetUserInformationViewController ()
{
    GlobalVariateModel *globalVariateModel;
    Common *common;
    NSString *telephone;
    NSString *email;
}

@end

@implementation SetUserInformationViewController

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
    [common returnButton:self];
    
    // Do any additional setup after loading the view from its nib.
    self.title = @"用户设置";
    //给图片设置边框
    [self.imageUrl.layer setBorderWidth:3];
    [self.imageUrl.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    UITapGestureRecognizer *loginOut = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginOutAction:)];
    [self.loginOutButton addGestureRecognizer:loginOut];
    
    globalVariateModel = [[GlobalVariateModel alloc] init];
    
    self.userName.text = self.userInfosModel.userName;
    self.userPoint.text = self.userInfosModel.userPoint;
    self.userTitle.text = self.userInfosModel.userTitle;
    telephone = self.userInfosModel.telephone;
    email = self.userInfosModel.email;
    
    
    self.userInfors.scrollEnabled = NO;	
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginOutAction:(id)sender
{
    [globalVariateModel setIsAutoLogin:@"no"];
    [globalVariateModel setIsLogin:@"no"];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath section];
    static NSString *CellIdentifier = @"SectionsTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"Courier" size:14.0];
    cell.textLabel.textColor = [UIColor colorWithRed:0.2 green:0 blue:0 alpha:1];
    
    if(row == 0)
    {
        cell.imageView.image = [UIImage imageNamed:@"user_admin_modify_password.png"];
        cell.textLabel.text = @"修改密码";
        UILabel *changeLabel = [[UILabel alloc] initWithFrame:CGRectMake(270, 5, 50, 30)];
        changeLabel.text = @"更换";
        [changeLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [changeLabel setTextColor:[UIColor colorWithRed:37/255.0 green:132/255.0 blue:54/255.0 alpha:1]];
        [changeLabel setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:changeLabel];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(row == 1)
    {
        cell.imageView.image = [UIImage imageNamed:@"user_admin_bind_phone.png"];
        if(telephone == nil || [telephone isEqualToString:@""])
        {
            cell.textLabel.text = @"您暂未绑定手机号码";
        }
        else
        {
            cell.textLabel.text = [NSString stringWithFormat:@"已绑定手机号%@",telephone];
        }
    }
    else if(row == 2)
    {
        cell.imageView.image = [UIImage imageNamed:@"ic_coupon_messege.png"];
        if(email == nil || [email isEqualToString:@""])
        {
            cell.textLabel.text = @"您暂未绑定邮箱";
        }
        else
        {
            cell.textLabel.text = [NSString stringWithFormat:@"已绑定邮箱%@",email];
        }
    }
    
    
    return cell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath section];
    if(row == 0)
    {
        EditPasswordViewController *editPasswordView = [[EditPasswordViewController alloc] initWithNibName:@"EditPasswordViewController" bundle:nil];
//        editPasswordView.userInfosModel = self.userInfosModel;
        [self.navigationController pushViewController:editPasswordView animated:YES];
    }
    else if(row == 1)
    {
        [SVProgressHUD showImage:nil status:@"您可以在懂味网站修改密码"];
    }
    else if(row == 2)
    {
        [SVProgressHUD showImage:nil status:@"您可以在懂味网站修改邮箱"];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];


}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 20;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, (self.tabBarController.tabBar.frame.origin.y - self.navigationController.navigationBar.frame.origin.y - self.navigationController.navigationBar.frame.size.height -150 - 4*55)/5.0)];
//    [headerView setBackgroundColor:[UIColor colorWithRed:233/250.0 green:233/250.0 blue:251/250.0 alpha:1.0]];
//    return headerView;
//}

- (void)viewDidUnload {
    [self setUserInfors:nil];
    [self setLoginOutButton:nil];
    [super viewDidUnload];
}
@end
