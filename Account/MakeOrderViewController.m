//
//  MakeOrderViewController.m
//  Account
//
//  Created by wang zhe on 7/23/13.
//
//

#import "MakeOrderViewController.h"
#import "FindTableCell.h"
#import "WriteClientInformationViewController.h"
#import "Common.h"
#import "SVProgressHUD.h"
#import "HallInfosModel.h"
#import "RoomInfosModel.h"
#import "GlobalVariateModel.h"

@interface MakeOrderViewController ()
{
    BOOL hallRadioSelected;
    BOOL roomRadioSelected;
    BOOL lunchSelected;
    BOOL dinnerSelected;
    BOOL hallRadioSelectedForPass;
    BOOL roomRadioSelectedForPass;
    BOOL lunchSelectedForPass;
    BOOL dinnerSelectedForPass;
    NSString *orderTimeForPass;
    
    NSString *isNoon;//1中餐 2晚餐
    NSArray *roomInfosArray;
    NSArray *hallInfosArray;
    NSString *storeID;
    UIDatePicker *datePicker;
    BOOL internetStatusBool;
    HallInfosModel *hallInfosModel;
    RoomInfosModel *roomInfosModel;
    GlobalVariateModel *globalVariateModel;
    Common *common;
    NSInteger hour;
}

@end


@implementation MakeOrderViewController

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

    hallRadioSelected = YES;
    roomRadioSelected = NO;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[NSDate date]];
    hour = [components hour];
    //如果是中午14:00之前下单，默认订中餐；否则是晚餐
    if(hour<14)
    {
        lunchSelected = YES;//默认为中餐
        isNoon = @"1";
        dinnerSelected = NO;
        
        self.lunch.image = [UIImage imageNamed:@"selected.png"];
        self.dinner.image = [UIImage imageNamed:@"normal.png"];
    }
    else
    {
        lunchSelected = NO;
        isNoon = @"2";
        dinnerSelected = YES;
        
        self.lunch.image = [UIImage imageNamed:@"normal.png"];
        self.dinner.image = [UIImage imageNamed:@"selected.png"];
    }
    
    globalVariateModel = [[GlobalVariateModel alloc] init];
    common = [[Common alloc] init];
    
    [common returnButton:self];

    NSString *internetStatus = [globalVariateModel internetIsAvailable];
    internetStatusBool = [common judgeInternetIsAvailable:internetStatus];
    //如果没有网络，则取到的数据为空
    if(internetStatusBool == NO)
    {
        self.hallRadio.userInteractionEnabled = NO;
        self.roomRadio.userInteractionEnabled = NO;
        self.lunch.userInteractionEnabled = NO;
        self.dinner.userInteractionEnabled = NO;
    }
    else
    {
        self.hallRadio.userInteractionEnabled = YES;
        self.roomRadio.userInteractionEnabled = YES;
        self.lunch.userInteractionEnabled = YES;
        self.dinner.userInteractionEnabled = YES;
    }
    //菲记甜品
    UITapGestureRecognizer *hallRadio = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hallRadioAction:)];
    UITapGestureRecognizer *roomRadio = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(roomRadioAction:)];
    UITapGestureRecognizer *lunch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lunchAction:)];
    UITapGestureRecognizer *dinner = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dinnerAction:)];
    UITapGestureRecognizer *hallText = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hallRadioAction:)];
    UITapGestureRecognizer *roomText = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(roomRadioAction:)];
    UITapGestureRecognizer *lunchText = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lunchAction:)];
    UITapGestureRecognizer *dinnerText = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dinnerAction:)];
    
    [self.hallRadio addGestureRecognizer:hallRadio];
    [self.roomRadio addGestureRecognizer:roomRadio];
    [self.lunch addGestureRecognizer:lunch];
    [self.dinner addGestureRecognizer:dinner];
    [self.hallText addGestureRecognizer:hallText];
    [self.roomText addGestureRecognizer:roomText];
    [self.lunchText addGestureRecognizer:lunchText];
    [self.dinnerText addGestureRecognizer:dinnerText];
    NSDate *date = [NSDate date];
    //想要设置自己想要的格式，可以用nsdateformatter这个类，这里是初始化
    NSDateFormatter * dm = [[NSDateFormatter alloc] init];
    //指定输出的格式   这里格式必须是和上面定义字符串的格式相同，否则输出空
    [dm setDateFormat:@"yyyy-MM-dd"];
    /*把时间转换成字符串*/
    //把Date对象转换成String对象  用stringFromDate方法
    NSString *orderTime = [dm stringFromDate:date];
    [self.date setTitle:orderTime forState:UIControlStateNormal];
    storeID = self.storesModel.storeId;
    
    hallInfosModel = [[HallInfosModel alloc] init];
    roomInfosModel = [[RoomInfosModel alloc] init];
   
//    [self reloadTableView];//reloadTableView最下面自己写的方法
}
-(void)viewWillAppear:(BOOL)animated
{
    float iphoneHeight = [[UIScreen mainScreen] bounds].size.height;

    [self.tableShowView setFrame:CGRectMake(0, 101, 320, iphoneHeight-163)];
}


//大厅
-(void)hallRadioAction:(UITapGestureRecognizer *) sender
{
    if(hallRadioSelected == NO)
    {
        hallRadioSelected = YES;
        roomRadioSelected = NO;
        self.hallRadio.image = [UIImage imageNamed:@"selected.png"];
        self.roomRadio.image = [UIImage imageNamed:@"normal.png"];
        
//        //如果hallInfosArray已经加载过一次了，就不用再发送请求了，这样可以加快加载速度
//        if([roomInfosArray count] == 0 )
//            [self reloadTableView];
//        else
//            [self.tableShowView reloadData];
    }
    else if(hallRadioSelected == YES)
        return;
}

//包厢
-(void)roomRadioAction:(UITapGestureRecognizer *) sender
{
    if(roomRadioSelected == NO)
    {
        hallRadioSelected = NO;
        roomRadioSelected = YES;
        self.hallRadio.image = [UIImage imageNamed:@"normal.png"];
        self.roomRadio.image = [UIImage imageNamed:@"selected.png"];
        
//        if([roomInfosArray count] == 0 )
//            [self reloadTableView];
//        else
//            [self.tableShowView reloadData];
    }
    else if(roomRadioSelected == YES)
        return;
}

//中餐
-(void)lunchAction:(UITapGestureRecognizer *) sender
{
    if(lunchSelected == NO)
    {
        dinnerSelected = NO;
        lunchSelected = YES;
        isNoon = @"1";
        self.dinner.image = [UIImage imageNamed:@"normal.png"];
        self.lunch.image = [UIImage imageNamed:@"selected.png"];
//        [self reloadTableView];
    }
    else if(lunchSelected == YES)
        return;
}

//晚餐
-(void)dinnerAction:(UITapGestureRecognizer *) sender
{
    if(dinnerSelected == NO)
    {
        dinnerSelected = YES;
        isNoon = @"2";
        lunchSelected = NO;
        self.dinner.image = [UIImage imageNamed:@"selected.png"];
        self.lunch.image = [UIImage imageNamed:@"normal.png"];
//        [self reloadTableView];
    }
    else if(dinnerSelected == YES)
        return;
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
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(roomRadioSelected == YES)
        return [roomInfosArray count];
    else if(hallRadioSelected == YES)
        return [hallInfosArray count];
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    NSDictionary *tableInfosDictionary;
    
    static NSString *CellTableIdentifier = @"Cell";
    // Configure the cell...
    BOOL nibsRegistered = NO;
    if(!nibsRegistered)
    {
        UINib *nib = [UINib nibWithNibName:@"FindTableCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
        nibsRegistered = YES;
    }
    FindTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if(hallRadioSelected == YES)
    {
        tableInfosDictionary = [hallInfosArray objectAtIndex:row];
        [hallInfosModel setPropertysWithDictionary:tableInfosDictionary];
        cell.tableNumber.text = [NSString stringWithFormat:@"大厅%@",hallInfosModel.tableNo];
        cell.min_maxPeopleNumber.text = [NSString stringWithFormat:@"%@-%@人",hallInfosModel.TMinPeoNum,hallInfosModel.TMaxPeoNum];
        cell.minPrice.hidden = YES;
    }
    //选择了包厢
    else if(roomRadioSelected == YES)
    {
        tableInfosDictionary = [roomInfosArray objectAtIndex:row];
        [roomInfosModel setPropertysWithDictionary:tableInfosDictionary];
        cell.tableNumber.text = [NSString stringWithFormat:@"%@",roomInfosModel.roomName];
        cell.min_maxPeopleNumber.text = [NSString stringWithFormat:@"%@-%@人",roomInfosModel.TMinPeoNum,roomInfosModel.TMaxPeoNum];
        cell.minPrice.text = [NSString stringWithFormat:@"最低消费%@元",roomInfosModel.minPrice];
        cell.minPrice.hidden = NO;
    }
    

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 57.0f;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [dateFormatter stringFromDate:[NSDate date]];
    
    
    if([date isEqualToString:self.date.titleLabel.text])
    {
        if(hour>14&&lunchSelected==YES)
        {
            [SVProgressHUD showErrorWithStatus:@"中餐时间已过啦!"];
            return;
        }
        else if(hour > 21)
        {
            [SVProgressHUD showErrorWithStatus:@"今天太晚了，订明天的吧!"];
            return;
        }
            
    }

    
    NSInteger row = [indexPath row];
    NSDictionary *tableInfosDictionary;
    WriteClientInformationViewController *writeClientInformationView = [[WriteClientInformationViewController alloc] init];

    if(hallRadioSelected == YES)
    {
        tableInfosDictionary = [hallInfosArray objectAtIndex:row];
        [hallInfosModel setPropertysWithDictionary:tableInfosDictionary];
        writeClientInformationView.tableID = hallInfosModel.tableID;

    }
    //选择了包厢
    else if(roomRadioSelected == YES)
    {
        tableInfosDictionary = [roomInfosArray objectAtIndex:row];
        [roomInfosModel setPropertysWithDictionary:tableInfosDictionary];
        writeClientInformationView.tableID = roomInfosModel.tableID;
        
    }
    
    FindTableCell *cell = (FindTableCell *)[self.tableShowView cellForRowAtIndexPath:indexPath];
    NSString *tableNumber = cell.tableNumber.text;
    NSString *min_maxPeopleNumber = cell.min_maxPeopleNumber.text;
    NSString *minPrice = cell.minPrice.text;
    
    //把信息都传递过去
    writeClientInformationView.storesModel = self.storesModel;
    writeClientInformationView.hallRadioSelected = hallRadioSelectedForPass;
    writeClientInformationView.roomRadioSelected = roomRadioSelectedForPass;
    writeClientInformationView.lunchSelected = lunchSelectedForPass;
    writeClientInformationView.dinnerSelected = dinnerSelectedForPass;
//    writeClientInformationView.orderTime = self.date.titleLabel.text;
    writeClientInformationView.orderTime = orderTimeForPass;
    writeClientInformationView.tableNumberForPass = tableNumber;
    writeClientInformationView.min_maxPeopleNumberForPass = min_maxPeopleNumber;
    writeClientInformationView.minPriceForPass = minPrice;
    
    self.hidesBottomBarWhenPushed = NO;
    writeClientInformationView.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:writeClientInformationView animated:YES];
}

//选择日期
- (IBAction)goToSelectDate:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n\n"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:@"确定"
                                                    otherButtonTitles:nil];
    
    actionSheet.userInteractionEnabled = YES;
    datePicker = [[UIDatePicker alloc] init];
    
    //    datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    datePicker.datePickerMode = UIDatePickerModeDate;
    NSDate *current = [NSDate date];
    [datePicker setMinimumDate:current];
    
    [actionSheet addSubview:datePicker];
    [actionSheet showInView:self.view.window];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        NSDate *selected = [datePicker date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *date =  [dateFormatter stringFromDate:selected];
        [self.date setTitle:date forState:UIControlStateNormal];
//        [self reloadTableView];
    }
    else if(buttonIndex == 1)
    {
        return;
    }
}

//加载并更新桌位
-(void)reloadTableView
{
    hallRadioSelectedForPass = hallRadioSelected;
    roomRadioSelectedForPass = roomRadioSelected;
    dinnerSelectedForPass = dinnerSelected;
    lunchSelectedForPass = lunchSelected;
    orderTimeForPass = self.date.titleLabel.text;
    
    self.findTableTipView.hidden = YES;
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.tableShowView.frame.size.width/2.0-20,self.tableShowView.frame.size.height/2.0-20, 40, 40)];
    [SVProgressHUD addActivityView:activityIndicatorView toViewController:self];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        if(hallRadioSelected == YES)
            [hallInfosModel setHallInfosWithStoreID:storeID andIsNoon:isNoon andOrderTime:orderTimeForPass];
        else if(roomRadioSelected == YES)
            [roomInfosModel setRoomInfosWithStoreID:storeID andIsNoon:isNoon andOrderTime:orderTimeForPass];

        dispatch_async(dispatch_get_main_queue(), ^{
            [activityIndicatorView stopAnimating];
            if(hallRadioSelected == YES)
            {
                hallInfosArray = hallInfosModel.hallInfos;
                if([hallInfosArray count] == 0)
                {
                    [SVProgressHUD showErrorWithStatus:@"大厅无座位"];
                    self.findTableTipView.hidden = NO;
                    self.tableShowView.hidden = YES;
                }
                else
                {
                    self.findTableTipView.hidden = YES;
                    self.tableShowView.hidden = NO;
                }
                
            }
            else if(roomRadioSelected == YES)
            {
                roomInfosArray = roomInfosModel.roomInfos;
                if([roomInfosArray count] == 0)
                {
                    [SVProgressHUD showErrorWithStatus:@"包厢无座位"];
                    self.findTableTipView.hidden = NO;
                    self.tableShowView.hidden = YES;
                }
                else
                {
                    self.findTableTipView.hidden = YES;
                    self.tableShowView.hidden = NO;
                }

            }
            
            [self.tableShowView reloadData];

        });
    });
}
- (IBAction)findSeat:(id)sender
{
    [self reloadTableView];
}
@end
