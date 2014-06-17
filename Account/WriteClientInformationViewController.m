//
//  WriteClientInformationViewController.m
//  Account
//
//  Created by wang zhe on 7/24/13.
//
//

#import "WriteClientInformationViewController.h"
#import "MyMD5.h"
#import "SVProgressHUD.h"
#import "StateModel.h"
#import "GlobalVariateModel.h"
#import "UserInfosModel.h"
#import "Common.h"

@interface WriteClientInformationViewController ()
{
    BOOL manRadioSelected;
    BOOL womanRadioSelected;
    UIDatePicker *timePicker;
    UIPickerView *selectTimePicker;
    NSArray *data1;
    NSArray *data2;
    NSString *selectedTime;
    StateModel *stateModel;
    GlobalVariateModel *globalVariateModel;
    UserInfosModel *userInfosModel;
    Common *common;
    NSString *hour;
    NSString *minute;
    UIKeyboardViewController *keyBoardController;

}

@end

@implementation WriteClientInformationViewController


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
    self.title = @"就餐人信息";
    [self.dateAndRepastTime setEnabled:NO];
}

-(void)return:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    common = [[Common alloc] init];
    [common returnButton:self];
    
    
    keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
	[keyBoardController addToolbarToKeyboard];
    
    // Do any additional setup after loading the view from its nib.
    self.tableNumber.text = self.tableNumberForPass;
    self.min_maxPeopleNumber.text = self.min_maxPeopleNumberForPass;
    self.minPrice.text = self.minPriceForPass;
    
    manRadioSelected = YES;
    womanRadioSelected = NO;
    
    self.manRadio.userInteractionEnabled = YES;
    self.womanRadio.userInteractionEnabled = YES;
    self.manText.userInteractionEnabled = YES;
    self.womanText.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *manRadio = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(manRadioAction:)];
    UITapGestureRecognizer *womanRadio = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(womanRadioAction:)];
    UITapGestureRecognizer *manText = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(manRadioAction:)];
    UITapGestureRecognizer *womanText = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(womanRadioAction:)];
    
    [self.manRadio addGestureRecognizer:manRadio];
    [self.womanRadio addGestureRecognizer:womanRadio];
    [self.manText addGestureRecognizer:manText];
    [self.womanText addGestureRecognizer:womanText];

    
    selectTimePicker = [[UIPickerView alloc] init];
    selectTimePicker.dataSource = self;
    selectTimePicker.delegate = self;
    
    
    if(self.lunchSelected == YES)
    {
        data1 = [[NSArray alloc] initWithObjects:@"10",@"11",@"12",@"13",@"14", nil];
        self.dateAndRepastTime.text = [NSString stringWithFormat:@"%@中餐",self.orderTime];
        [self.repastTime setTitle:@"12:00" forState:UIControlStateNormal];
        selectedTime = @"12:00";
        hour = @"10";
    }
    else if(self.dinnerSelected == YES)
    {
        data1 = [[NSArray alloc] initWithObjects:@"16",@"17",@"18",@"19",@"20",@"21", nil];
        self.dateAndRepastTime.text = [NSString stringWithFormat:@"%@晚餐",self.orderTime];
        [self.repastTime setTitle:@"18:00" forState:UIControlStateNormal];
        selectedTime = @"18:00";
         hour = @"16";
    }
    data2 = [[NSArray alloc] initWithObjects:@":00",@":15",@":30",@":45", nil];
    minute = @":00";
    
    
    stateModel = [[StateModel alloc] init];
    globalVariateModel = [[GlobalVariateModel alloc] init];
    userInfosModel = [[UserInfosModel alloc] init];
    [userInfosModel setPropertysWithDictionary:[globalVariateModel userInfos]];
    
    //显示登陆用户电话号码
    self.tel.text = userInfosModel.telephone;
    self.scrollView.userInteractionEnabled = YES;
    UITapGestureRecognizer *scrollViewAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTap:)];
    [self.scrollView addGestureRecognizer:scrollViewAction];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}

//选择性别为男
-(void)manRadioAction:(UITapGestureRecognizer *) sender
{
    if(manRadioSelected == NO)
    {
        manRadioSelected = YES;
        womanRadioSelected = NO;
        self.manRadio.image = [UIImage imageNamed:@"selected.png"];
        self.womanRadio.image = [UIImage imageNamed:@"normal.png"];
    }
    else if(manRadioSelected == YES)
        return;
}

//选择性别为女
-(void)womanRadioAction:(UITapGestureRecognizer *) sender
{
    if(womanRadioSelected == NO)
    {
        manRadioSelected = NO;
        womanRadioSelected = YES;
        self.manRadio.image = [UIImage imageNamed:@"normal.png"];
        self.womanRadio.image = [UIImage imageNamed:@"selected.png"];
    }
    else if(womanRadioSelected == YES)
        return;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置就餐的精确时间(其实这里只是调出来timePiker而已)
- (IBAction)setTime:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:@"确定"
                                                    otherButtonTitles:nil];

    [selectTimePicker setFrame:CGRectMake(0, 20, 320, 216)];
    [selectTimePicker setShowsSelectionIndicator:YES];
    [actionSheet addSubview:selectTimePicker];
    [actionSheet showInView:self.view.window];
//    [actionSheet setFrame:CGRectMake(0, 130, 320, 390)];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [selectTimePicker reloadAllComponents];
        [self.repastTime setTitle:selectedTime forState:UIControlStateNormal];
    }
    else if(buttonIndex == 1)
    {
        return;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;//Picker里有几个竖的栏目就返回几，不要拖动几个Picker哦，一个足以。如果必须要几个Picker来实现某些过功能，那你就要额外创建一些文件来完成委托了。毕竟疑问类里就只能委托一个Picker。
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    if(component == 0)
    {
        return data1.count;
    }
    else
    {
        return data2.count;
    }
//    return [data count];//picker中的选项有几个
}

#pragma mark -
#pragma mark Picker Data Delegate Methods;
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if(component == 0)
    {
        return [data1 objectAtIndex:row];
        
    }
    else
    {
        return [data2 objectAtIndex:row];
    }

//    return [data objectAtIndex:row];//返回每个选项要显示的内容
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
   
    if(component == 0)
    {
        if([data1 objectAtIndex:row]!=nil)
            hour = [data1 objectAtIndex:row];
 
    }
    else
    {
        if([data2 objectAtIndex:row]!=nil)
            minute = [data2 objectAtIndex:row];
    }
    selectedTime = [NSString stringWithFormat:@"%@%@",hour,minute] ;
}

//提交订单
- (IBAction)submit:(id)sender {
    
    if(![self isValidateMobile:self.tel.text])
    {
        [SVProgressHUD showErrorWithStatus:@"号码不合法"];
        return;
    }
    if(self.name.text==nil)
    {
        self.name.text = @"";
    }
    if(self.numbersOfPerson.text == nil)
    {
        self.numbersOfPerson.text = @"";
    }
    if(self.numbersOfPerson.text == nil)
    {
        self.tips.text = @"";
    }
    
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *storeID = self.storesModel.storeId;
        NSString *userName = userInfosModel.userName;
        NSString *orderName = self.name.text;
        NSString *orderTime = [NSString stringWithFormat:@"%@ %@",self.orderTime,selectedTime];
        NSString *orderTel = self.tel.text;
        NSString *note = self.tips.text;
        NSString *peoNum = self.numbersOfPerson.text;
        NSString *tableInfo = self.tableNumberForPass;
        NSString *tableID = self.tableID;
        NSString *source = @"IOS";
        NSString *isNoon;
        if(self.lunchSelected == YES)
            isNoon = @"1";
        else if(self.dinnerSelected == YES)
            isNoon = @"2";
        NSString *isTel = @"2";
        NSString *customerID = @"";
        NSString *status = @"2100";
        NSString *orderSex;
        if(manRadioSelected == YES)
            orderSex = @"1";
        else if(womanRadioSelected == YES)
            orderSex = @"2";
        NSString *userID = userInfosModel.ID;
        NSString *isSMS = @"1";//1是发短信，2是不发短信
        
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd 20hh:mm:ss"];
        NSString* SYStime = [formatter stringFromDate:[NSDate date]];
        
        NSString *ID = [MyMD5 md5:[NSString stringWithFormat:@"%@%@%@%@%@",userName,orderTime,SYStime,tableInfo,orderTel]];
        [stateModel MakeOrderStateWithStoreID:storeID andUsername:userName andOrderName:orderName andOrderTime:orderTime andOrderTel:orderTel andNote:note andPeoNum:peoNum andTableInfo:tableInfo andTableID:tableID andSource:source andIsNoon:isNoon andIsTel:isTel andCustomerID:customerID andStatus:status andOrderSex:orderSex andUserID:userID andIsSMS:isSMS andID:ID];
        NSString *state = stateModel.state;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            if([state isEqualToString:@"1"])
            {
                //增加一条当前订单，并提示订餐成功，请查收短信
                [SVProgressHUD showSuccessWithStatus:@"订餐成功"];
            }
            else
            {
                //提示您这次订餐可能没有成功，
                [SVProgressHUD showErrorWithStatus:@"订餐失败"];
            }
        });
    });
}


- (IBAction)backgroundTap:(id)sender {
    
    [self.name resignFirstResponder];
    [self.tel resignFirstResponder];
    [self.numbersOfPerson resignFirstResponder];
    [self.tips resignFirstResponder];
}

/*手机号码验证 MODIFIED BY HELENSONG*/
-(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头11个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}
- (void)viewDidUnload {
    [self setManText:nil];
    [self setWomanText:nil];
    [super viewDidUnload];
}



@end
