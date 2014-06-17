//
//  SXAdvancedSearchViewController.m
//  Account
//
//  Created by Sam Xie on 7/30/13.
//
//

#import "AdvancedSearchViewController.h"
#import "GlobalVariateModel.h"

@interface AdvancedSearchViewController () {
    NSArray *nameLabelArray;
    NSArray *initButtonTitleArray;
    NSArray *selectedArray;
    NSArray *pickerArray;
    NSArray *locationPickerArray;
    NSArray *pricePickerArray;
    NSArray *distancePickerArray;
    NSArray *sortPickerArray;
    NSArray *categoryPickerArray;
    UIButton *buttonSender;
    NSString *latitude;
    NSString *longitude;
    NSString *sort;
    NSString *price;
    NSString *radius;
    NSString *cat;
    GlobalVariateModel *globalVariateModel;
    NSString *locationName;
}

@end

@implementation AdvancedSearchViewController

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
    UIView *dimView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 548)];
    dimView.alpha = 0.6;
    dimView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:dimView];
    [self.view sendSubviewToBack:dimView];
    // Do any additional setup after loading the view from its nib.
    self.tableView.autoresizingMask = UIViewAutoresizingNone;
//    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView = nil;
    NSArray *nameArray = [[NSArray alloc] initWithObjects:@"定位点", @"价格", @"距离", @"排序方式", @"类别", nil];
    nameLabelArray = nameArray;
    locationPickerArray = [[NSArray alloc] initWithObjects:@"当前位置", @"五一广场", @"火车站", @"东塘", @"溁￼湾镇", @"汽车西站",@"汽车东站",@"汽车南站",@"四方坪",@"湘江世纪城",@"锦泰广场",@"新开铺",@"星沙通程广场",nil];
    pricePickerArray = [[NSArray alloc] initWithObjects:@"所有价格", @"20元以下", @"21元－50元", @"51元－100元", @"101元以上", nil];
    distancePickerArray = [[NSArray alloc] initWithObjects:@"1000M", @"2000M", @"5000M", @"10000M", nil];
    sortPickerArray = [[NSArray alloc] initWithObjects:@"默认排序", @"距离从近到远排序", @"距离从远到近排序", @"价格从低到高排序", @"价格从高到低排序", @"评分从高到低排序", nil];
    categoryPickerArray = [[NSArray alloc] initWithObjects:@"全部", @"中餐", @"外国菜", @"自助餐", @"快餐小吃", @"甜品冷饮", @"茶咖啡", @"面包蛋糕", nil];
    initButtonTitleArray = [[NSArray alloc] initWithObjects:@"当前位置", @"所有价格", @"1000M", @"默认排序", @"全部", @"当前位置", nil];
    selectedArray = initButtonTitleArray;
    
    globalVariateModel = [[GlobalVariateModel alloc] init];
    
    
    //如果定位失败，默认用五一广场为自己坐标
    if(![globalVariateModel.locationIsAvailabelOnPhone isEqualToString:@"yes"])
    {
        latitude = @"28.195279";
        longitude = @"112.976317";
        locationName = @"定位失败，默认你在五一广场";
    }
    else
    {
        latitude = [globalVariateModel latitude];
        longitude = [globalVariateModel longitude];
        locationName = globalVariateModel.userAddress;
        if([locationName length]>3)
            locationName = [NSString stringWithFormat:@"你在:%@",[locationName substringFromIndex:3]];
        else if([locationName length]>0)
            locationName = [NSString stringWithFormat:@"你在:%@",locationName];
    }

    price = @"1";
    sort = @"1";
    radius = @"1000";
    cat = @"1";
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView setFrame:CGRectMake(50, 102, 220, 169)];
    
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    static NSString *CellIdentifier = @"AdvancedSearchCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SXAdvancedSearchCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        _nameLabelInCell.text = [nameLabelArray objectAtIndex:row];
        _pickerButtonInCell.tag = [indexPath row];
        _pickerButtonInCell.titleLabel.text = [initButtonTitleArray objectAtIndex:row];
        [_pickerButtonInCell addTarget:self action:@selector(pickerButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    [cell bringSubviewToFront:_pickerButtonInCell];
    // Configure the cell...
    
    return cell;
}

- (IBAction)okClick:(UIButton *)sender {

    [self.delegate passValue:cat andLatitude:latitude andLongitude:longitude andRadius:radius andSort:sort andPrice:price andTerm:@"" andIsAdvanedSearch:YES andLocationName:locationName];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateParent" object:nil];
    [self.view removeFromSuperview];
}

- (IBAction)cancelClick:(UIButton *)sender {
    [self.view removeFromSuperview];
}

#pragma mark -picker data source methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [pickerArray count];
}

#pragma mark -picker delegate methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [pickerArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _pickerView.hidden = YES;
    [buttonSender setTitle:[pickerArray objectAtIndex:row] forState:UIControlStateNormal];
    NSUInteger buttonTag = buttonSender.tag;
    if (buttonTag == 0) {
        if (row == 0) {
            
            //如果定位失败，默认用五一广场为自己坐标
            if(![globalVariateModel.locationIsAvailabelOnPhone isEqualToString:@"yes"])
            {
                latitude = @"28.195279";
                longitude = @"112.976317";
                locationName = @"定位失败，默认你在五一广场";
            }
            else
            {
                latitude = [globalVariateModel latitude];
                longitude = [globalVariateModel longitude];
                locationName = globalVariateModel.userAddress;
                if([locationName length]>8)
                    locationName = [NSString stringWithFormat:@"你在:%@",[locationName substringFromIndex:8]];
                else if([locationName length]>0)
                    locationName = [NSString stringWithFormat:@"你在:%@",locationName];
            }
        } else if (row ==1) {
            latitude = @"28.195279";
            longitude = @"112.976317";
            locationName = @"五一广场";
        } else if (row ==2) {
            latitude = @"28.194258";
            longitude = @"113.011572";
            locationName = @"火车站";
        } else if (row == 3) {
            latitude = @"28.169348";
            longitude = @"112.994835";
            locationName = @"东塘";
        } else if (row == 4) {
            latitude = @"28.196054";
            longitude = @"112.952371";
            locationName = @"溁￼湾镇";
        }else if(row == 5){
            latitude = @"28.209953";
            longitude = @"112.912824";
            locationName = @"汽车西站";
        }else if(row == 6){
            latitude = @"28.201784";
            longitude = @"113.058672";
            locationName = @"汽车东站";
        }else if(row == 7){
            latitude = @"28.097462";
            longitude = @"113.013718";
            locationName = @"汽车南站";
        }else if(row == 8){
            latitude = @"28.234343";
            longitude = @"113.013139";
            locationName = @"四方坪";
        }else if(row == 9){
            latitude = @"28.261222";
            longitude = @"112.982798";
            locationName = @"湘江世纪城";
        }else if(row == 10){
            latitude = @"28.193766";
            longitude = @"113.01743";
            locationName = @"锦泰广场";
        }else if(row == 11){
            latitude = @"28.135142";
            longitude = @"112.970438";
            locationName = @"新开铺";
        }else if(row == 12){
            latitude = @"28.244419";
            longitude = @"113.080237";
            locationName = @"星沙通程广场";
        }
    }else if (buttonTag == 1) {
        price = [NSString stringWithFormat:@"%d", row + 1];
    }else if (buttonTag == 2) {
        if (row == 0) {
            radius = @"1000";
        } else if (row == 1){
            radius = @"2000";
        }else if (row == 2) {
            radius = @"5000";
        }else if (row == 3) {
            radius = @"10000";
        }
    }else if (buttonTag == 3) {
        if (row == 0) {
            sort = @"1";
        } else if (row == 1){
            sort = @"0";
        }else {
            sort = [NSString stringWithFormat:@"%d", row];
        }
    }else {
        if (row == 0) {
            cat = @"1";
        }else {
            cat = [NSString stringWithFormat:@"%d", row + 11];
        }
    }
}


- (void)pickerButton:(UIButton *) sender
{
    NSInteger buttonTag = sender.tag;
//    _tableViewCell = [self.tableView cellForRowAtIndexPath:(NSIndexPath *) sender];
    if (buttonTag == 0) {
        pickerArray = locationPickerArray;
    }else if (buttonTag == 1) {
        pickerArray = pricePickerArray;
    }else if (buttonTag == 2) {
        pickerArray = distancePickerArray;
    }else if (buttonTag == 3) {
        pickerArray = sortPickerArray;
    }else {
        pickerArray = categoryPickerArray;
    }
    [_pickerView reloadAllComponents];
    _pickerView.hidden = NO;
    buttonSender = sender;
//    _pickerButtonInCell.titleLabel.text = @"1342";
}



@end

