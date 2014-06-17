//
//  storeByUserViewController.m
//  Account
//
//  Created by wang zhe on 8/3/13.
//
//

#import "AddStoreViewController.h"
#import "MyMD5.h"
#import "Common.h"
#import "SVProgressHUD.h"
#import "StateModel.h"

@interface AddStoreViewController ()
{
//    int prewTag ;  //编辑上一个UITextField的TAG,需要在XIB文件中定义或者程序中添加，不能让两个控件的TAG相同
    float prewMoveY; //编辑的时候移动的高度
    UIPickerView *picker;
    NSArray *data;
    NSString *categoryName;
    StateModel *stateModel;
    UIKeyboardViewController *keyBoardController;
    Common *common;

}
@end

@implementation AddStoreViewController


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
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
	[keyBoardController addToolbarToKeyboard];
    
    self.decriptionContent.delegate = self;
    
    self.pulldownButton.userInteractionEnabled = YES;
    UITapGestureRecognizer *pulldownButton = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectCategory:)];
    [self.pulldownButton addGestureRecognizer:pulldownButton];
    
    self.title = @"新增商家";
    self.hidesBottomBarWhenPushed = NO;
    
    self.storeName.delegate = self;
    self.address.delegate = self;
    self.phone.delegate = self;
    self.recommendDish.delegate = self;
    self.price.delegate = self;
    [_score setImageUnselected:@"unselected.png" partlySelected:@"partlySelected.png" fullySelected:@"fullySelected.png" andDelegate:self];
    [_score displayRate:5];
    [_service setImageUnselected:@"unselected.png" partlySelected:@"partlySelected.png" fullySelected:@"fullySelected.png" andDelegate:self];
    [_service displayRate:5];
    [_environment setImageUnselected:@"unselected.png" partlySelected:@"partlySelected.png" fullySelected:@"fullySelected.png" andDelegate:self];
    [_environment displayRate:5];
    [_taste setImageUnselected:@"unselected.png" partlySelected:@"partlySelected.png" fullySelected:@"fullySelected.png" andDelegate:self];
    [_taste displayRate:5];
    
    picker = [[UIPickerView alloc] init];
    data = [[NSArray alloc] initWithObjects:@"中餐",@"外国美食",@"自助餐",@"快餐小吃",@"甜品冷饮",@"茶咖啡",@"面包蛋糕" ,nil];
    picker.dataSource = self;
    picker.delegate = self;
    categoryName = @"中餐";
    
    stateModel = [[StateModel alloc] init];
    
    self.scrollView.scrollEnabled = YES;
    [self.scrollView setContentSize:CGSizeMake(320, 580)];
    
}

-(void)viewWillAppear:(BOOL)animated
{


}

-(void)viewDidAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}



- (IBAction)selectCategory:(id)sender {
    //    [picker showsSelectionIndicator];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n\n"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:@"确定"
                                                    otherButtonTitles:nil];
//    actionSheet.tag = 0;
    [picker setFrame:CGRectMake(0, 20, 320, 236)];
//    picker.tag = 90;
    [picker setShowsSelectionIndicator:YES];
    [actionSheet addSubview:picker];
    [actionSheet showInView:self.view.window];
//    [actionSheet setFrame:CGRectMake(0, 50, 320, 380)];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        //I force reload
//        [picker reloadAllComponents];
        [self.categorySelect setTitle:categoryName forState:UIControlStateNormal];
//        NSArray *subviews = [actionSheet subviews];
//        [[subviews objectAtIndex:1] setFrame:CGRectMake(20, 266, 280, 46)];
//        [[subviews objectAtIndex:2] setFrame:CGRectMake(20, 317, 280, 46)];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;//Picker里有几个竖的栏目就返回几，不要拖动几个Picker哦，一个足以。如果必须要几个Picker来实现某些过功能，那你就要额外创建一些文件来完成委托了。毕竟疑问类里就只能委托一个Picker。
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [data count];//picker中的选项有几个
}

#pragma mark -
#pragma mark Picker Data Delegate Methods;
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [data objectAtIndex:row];//返回每个选项要显示的内容
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    categoryName = [data objectAtIndex:row];
}

- (IBAction)submit:(id)sender {
    
    NSString *storeName = self.storeName.text;
    NSString *address = self.address.text;
    if ([storeName isEqualToString:@""]||storeName == NULL)
    {
        [SVProgressHUD showErrorWithStatus:@"商家名称不能为空"];
        return;
    }
    if([address isEqualToString:@""]||address == NULL)
    {
        [SVProgressHUD showErrorWithStatus:@"商家地址是不能为空"];
        return;
    }
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *phone = self.phone.text;
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd 20hh:mm:ss"];
        NSString* SYStime = [formatter stringFromDate:[NSDate date]];
        NSString *storeId = [MyMD5 md5:[NSString stringWithFormat:@"%@%@%@",storeName,address,SYStime]];
        NSString *recommendedDish = self.recommendDish.text;
        NSString *price = self.price.text;
        NSString *score = [NSString stringWithFormat:@"%1.1f", [_score filterRateOneToFive]];
        NSString *service = [NSString stringWithFormat:@"%1.1f", [_service filterRateOneToFive]];
        NSString *environment = [NSString stringWithFormat:@"%1.1f", [_environment filterRateOneToFive]];
        NSString *taste = [NSString stringWithFormat:@"%1.1f", [_taste filterRateOneToFive]];
        NSString *decription = self.decriptionContent.text;
        [stateModel storeAddStateWithStoreID:storeId andStoreName:storeName andCate:categoryName andAd:address andTel:phone andRecommend:recommendedDish andPrice:price andScore:score andTaste:taste andEnvir:environment andService:service andDesc:decription];
        NSString *state = stateModel.state;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            if([state isEqualToString:@"1"])
            {
                [SVProgressHUD showSuccessWithStatus:@"添加成功"];
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"添加失败"];
            }
        });
    });
}

- (IBAction)backgroundTap:(id)sender
{
    [self.storeName resignFirstResponder];
    [self.address resignFirstResponder];
    [self.phone resignFirstResponder];
    [self.recommendDish resignFirstResponder];
    [self.price resignFirstResponder];
    [self.decriptionContent resignFirstResponder];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.decriptionContent.text = @"";
}

- (void)rateChange {
    [self.storeName resignFirstResponder];
    [self.address resignFirstResponder];
    [self.phone resignFirstResponder];
    [self.recommendDish resignFirstResponder];
    [self.price resignFirstResponder];
    [self.decriptionContent resignFirstResponder];

    
}
@end
