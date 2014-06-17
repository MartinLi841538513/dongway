//
//  CategoryViewController.m
//  Account
//
//  Created by Join on 9/25/13.
//
//

#import "CategoryViewController.h"
#import "NearbyViewController.h"
#import "GlobalVariateModel.h"
#import "Common.h"
#define ButtonWith 94
#define ButtonHeight 44

@interface CategoryViewController ()
{
    UIScrollView *scrollView;
    UIView *titleView;
    UIView *districtView;
    UIView *cookingStyleView;
    UILabel *moreString2;
    UILabel *moreString3;
    GlobalVariateModel *globalVariateModel;
    NSString *latitude;
    NSString *longitude;
    UISearchBar *searchBar;
    Common *common;
}

@end

@implementation CategoryViewController

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
    
   

    // Do any additional setup after loading the view from its nib.
    self.title = @"搜索";
    
    globalVariateModel = [[GlobalVariateModel alloc] init];
    latitude = [globalVariateModel latitude];
    longitude = [globalVariateModel longitude];
    
    if(self.hidesBottomBarWhenPushed == YES)
    {
        common = [[Common alloc] init];
        [common returnButton:self];
    }

    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(-5, self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height, 330, 44)];
    }
    else
    {
        searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(-5, 0, 330, 44)];
    }

    searchBar.delegate = self;
//    [searchBar setBackgroundImage:[UIImage imageNamed:@"searchBaBg.png"]];
    [searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"searchBarBackground.png"] forState:UIControlStateNormal];
    searchBar.placeholder = @"输入菜名，商家名称";
    [self.view addSubview:searchBar];


    //界面可以滚动
    scrollView = [[UIScrollView alloc] init];
    scrollView.userInteractionEnabled = YES;
    //短信邀请好友
    UITapGestureRecognizer *scrollViewPress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewPressedAction:)];
    [scrollView addGestureRecognizer:scrollViewPress];
    [scrollView setFrame:CGRectMake(0,searchBar.frame.origin.y+searchBar.frame.size.height, 320, self.view.frame.size.height)];
    
    
    //主题分类
    titleView = [[UIView alloc] initWithFrame:CGRectMake(13, 0, 294, 130)];
    [scrollView addSubview:titleView];
    UIImageView *titleCategory = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"titleCategory.png"]];
    [titleCategory setFrame:CGRectMake(0, 0, 95, 30)];
    [titleView addSubview:titleCategory];

    UIButton *ChineseFood = [[UIButton alloc] initWithFrame:CGRectMake(0, titleCategory.frame.origin.y+titleCategory.frame.size.height+8, ButtonWith, ButtonHeight)];
    [ChineseFood addTarget:self action:@selector(ChineseFoodAction:) forControlEvents:UIControlEventTouchDown];
    [self setTitleAreaWithButton:ChineseFood andTitle:@"中餐"];
    
    UIButton *WestFood = [[UIButton alloc] initWithFrame:CGRectMake(ChineseFood.frame.size.width+2, titleCategory.frame.origin.y+titleCategory.frame.size.height+8,  ButtonWith, ButtonHeight)];
    [WestFood addTarget:self action:@selector(WestFoodAction:) forControlEvents:UIControlEventTouchDown];
    [self setTitleAreaWithButton:WestFood andTitle:@"西餐"];

    UIButton *buffet = [[UIButton alloc] initWithFrame:CGRectMake(WestFood.frame.origin.x+WestFood.frame.size.width+2, titleCategory.frame.origin.y+titleCategory.frame.size.height+8,  ButtonWith, ButtonHeight)];
    [buffet addTarget:self action:@selector(buffetAction:) forControlEvents:UIControlEventTouchDown];
    [self setTitleAreaWithButton:buffet andTitle:@"自助餐"];

    UIButton *snack = [[UIButton alloc] initWithFrame:CGRectMake(0, ChineseFood.frame.origin.y+ChineseFood.frame.size.height+2,  ButtonWith, ButtonHeight)];
    [snack addTarget:self action:@selector(snackAction:) forControlEvents:UIControlEventTouchDown];
    [self setTitleAreaWithButton:snack andTitle:@"快餐小吃"];

    UIButton *sweetFood = [[UIButton alloc] initWithFrame:CGRectMake(ChineseFood.frame.size.width+2, ChineseFood.frame.origin.y+ChineseFood.frame.size.height+2, ButtonWith, ButtonHeight)];
    [sweetFood addTarget:self action:@selector(sweetFoodAction:) forControlEvents:UIControlEventTouchDown];
    [self setTitleAreaWithButton:sweetFood andTitle:@"甜品冷饮"];
    
    UIButton *teaCoffeeFood = [[UIButton alloc] initWithFrame:CGRectMake(WestFood.frame.origin.x+WestFood.frame.size.width+2, ChineseFood.frame.origin.y+ChineseFood.frame.size.height+2, ButtonWith, ButtonHeight)];
    [teaCoffeeFood addTarget:self action:@selector(teaCoffeeFoodAction:) forControlEvents:UIControlEventTouchDown];
    [self setTitleAreaWithButton:teaCoffeeFood andTitle:@"茶咖啡"];
    
    UIButton *breadCake = [[UIButton alloc] initWithFrame:CGRectMake(0, teaCoffeeFood.frame.origin.y+teaCoffeeFood.frame.size.height+2,  ButtonWith, ButtonHeight)];
    [breadCake addTarget:self action:@selector(breadCakeAction:) forControlEvents:UIControlEventTouchDown];
    [self setTitleAreaWithButton:breadCake andTitle:@"面包蛋糕"];

    [titleView setFrame:CGRectMake(13, 20, 294, titleCategory.frame.size.height+ButtonHeight*3+8+2*2+20)];
    
    //地区分类
//    districtView = [[UIView alloc] initWithFrame:CGRectMake(13, 20+titleView.frame.size.height+60, 294, 130)];
    districtView = [[UIView alloc] initWithFrame:CGRectMake(13, 20+titleView.frame.size.height+60, 294, 130)];
    [districtView setFrame:CGRectMake(13, titleView.frame.origin.y+titleView.frame.size.height, 294, titleCategory.frame.size.height+ButtonHeight*2+8+2+20)];
    [scrollView addSubview:districtView];
    UIImageView *district = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"areaCategory.png"]];
    [district setFrame:CGRectMake(0, 0, 95, 30)];
    [districtView addSubview:district];
    
    UIButton *district1 = [[UIButton alloc] initWithFrame:CGRectMake(0, titleCategory.frame.origin.y+titleCategory.frame.size.height+8,  ButtonWith, ButtonHeight)];
//    [district1 addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    [district1 addTarget:self action:@selector(district1Action:) forControlEvents:UIControlEventTouchDown];
    [self setAreaWithButton:district1 andTitle:@"五一广场"];
    
    UIButton *district2 = [[UIButton alloc] initWithFrame:CGRectMake(ChineseFood.frame.size.width+2, titleCategory.frame.origin.y+titleCategory.frame.size.height+8,  ButtonWith, ButtonHeight)];
    [district2 addTarget:self action:@selector(district2Action:) forControlEvents:UIControlEventTouchDown];
    [self setAreaWithButton:district2 andTitle:@"汽车西站"];
    
    UIButton *district3 = [[UIButton alloc] initWithFrame:CGRectMake(WestFood.frame.origin.x+WestFood.frame.size.width+2, titleCategory.frame.origin.y+titleCategory.frame.size.height+8,  ButtonWith, ButtonHeight)];
    [district3 addTarget:self action:@selector(district3Action:) forControlEvents:UIControlEventTouchDown];
    [self setAreaWithButton:district3 andTitle:@"汽车东站"];
    
    UIButton *district4 = [[UIButton alloc] initWithFrame:CGRectMake(0, ChineseFood.frame.origin.y+ChineseFood.frame.size.height+2, ButtonWith, ButtonHeight)];
    [district4 addTarget:self action:@selector(district4Action:) forControlEvents:UIControlEventTouchDown];
    [self setAreaWithButton:district4 andTitle:@"汽车南站"];

    UIButton *district5 = [[UIButton alloc] initWithFrame:CGRectMake(ChineseFood.frame.size.width+2, ChineseFood.frame.origin.y+ChineseFood.frame.size.height+2, ButtonWith, ButtonHeight)];
    [district5 addTarget:self action:@selector(district5Action:) forControlEvents:UIControlEventTouchDown];
    [self setAreaWithButton:district5 andTitle:@"溁湾镇"];
    
    UIButton *district6 = [[UIButton alloc] initWithFrame:CGRectMake(WestFood.frame.origin.x+WestFood.frame.size.width+2, ChineseFood.frame.origin.y+ChineseFood.frame.size.height+2,  ButtonWith, ButtonHeight)];
    [district6 addTarget:self action:@selector(district6Action:) forControlEvents:UIControlEventTouchDown];
    [self setAreaWithButton:district6 andTitle:@"火车站"];

    //更多
    moreString2 = [[UILabel alloc] initWithFrame:CGRectMake(250, districtView.frame.origin.y +districtView.frame.size.height-20, 50, 50)];
    moreString2.text = @"更多";
    [moreString2 setFont:[UIFont systemFontOfSize:15.0f]];
    [moreString2 setTextColor:[UIColor blueColor]];
    [moreString2 setBackgroundColor:[UIColor clearColor]];
    moreString2.userInteractionEnabled = YES;
    UITapGestureRecognizer *moreModelButton = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreModel2Action:)];
    [moreString2 addGestureRecognizer:moreModelButton];
    [scrollView insertSubview:moreString2 atIndex:2];
    
    
    //热门菜系分类
    cookingStyleView = [[UIView alloc] initWithFrame:CGRectMake(13, 20+districtView.frame.origin.y+districtView.frame.size.height, 294, 130)];
    [scrollView insertSubview:cookingStyleView atIndex:1];
    UIImageView *cookingStyle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hotFoods.png"]];
    [cookingStyle setFrame:CGRectMake(0, 0, 95, 30)];
    [cookingStyleView addSubview:cookingStyle];
    
    UIButton *cookingStyle1 = [[UIButton alloc] initWithFrame:CGRectMake(0, titleCategory.frame.origin.y+titleCategory.frame.size.height+8,  ButtonWith, ButtonHeight)];
    [cookingStyle1 addTarget:self action:@selector(cookingStyle1Action:) forControlEvents:UIControlEventTouchDown];
    [self setHotFoodsAreaWithButton:cookingStyle1 andTitle:@"湘菜"];
    
    UIButton *cookingStyle2 = [[UIButton alloc] initWithFrame:CGRectMake(ChineseFood.frame.size.width+2, titleCategory.frame.origin.y+titleCategory.frame.size.height+8,  ButtonWith, ButtonHeight)];
    [cookingStyle2 addTarget:self action:@selector(cookingStyle2Action:) forControlEvents:UIControlEventTouchDown];
    [self setHotFoodsAreaWithButton:cookingStyle2 andTitle:@"家常菜"];
    
    UIButton *cookingStyle3 = [[UIButton alloc] initWithFrame:CGRectMake(WestFood.frame.origin.x+WestFood.frame.size.width+2, titleCategory.frame.origin.y+titleCategory.frame.size.height+8,  ButtonWith, ButtonHeight)];
    [cookingStyle3 addTarget:self action:@selector(cookingStyle3Action:) forControlEvents:UIControlEventTouchDown];
    [self setHotFoodsAreaWithButton:cookingStyle3 andTitle:@"土家／农家菜"];

    UIButton *cookingStyle4 = [[UIButton alloc] initWithFrame:CGRectMake(0, ChineseFood.frame.origin.y+ChineseFood.frame.size.height+2, ButtonWith, ButtonHeight)];
    [cookingStyle4 addTarget:self action:@selector(cookingStyle4Action:) forControlEvents:UIControlEventTouchDown];
    [self setHotFoodsAreaWithButton:cookingStyle4 andTitle:@"火锅／砂锅"];
    
    UIButton *cookingStyle5 = [[UIButton alloc] initWithFrame:CGRectMake(ChineseFood.frame.size.width+2, ChineseFood.frame.origin.y+ChineseFood.frame.size.height+2, ButtonWith, ButtonHeight)];
    [cookingStyle5 addTarget:self action:@selector(cookingStyle5Action:) forControlEvents:UIControlEventTouchDown];
    [self setHotFoodsAreaWithButton:cookingStyle5 andTitle:@"海鲜"];

    UIButton *cookingStyle6 = [[UIButton alloc] initWithFrame:CGRectMake(WestFood.frame.origin.x+WestFood.frame.size.width+2, ChineseFood.frame.origin.y+ChineseFood.frame.size.height+2,  ButtonWith, ButtonHeight)];
    [cookingStyle6 addTarget:self action:@selector(cookingStyle6Action:) forControlEvents:UIControlEventTouchDown];
    [self setHotFoodsAreaWithButton:cookingStyle6 andTitle:@"烧烤"];

    
    //更多
    moreString3 = [[UILabel alloc] initWithFrame:CGRectMake(250, cookingStyleView.frame.origin.y +districtView.frame.size.height-20, 50, 50)];
    moreString3.text = @"更多";
    [moreString3 setFont:[UIFont systemFontOfSize:15.0f]];
    [moreString3 setTextColor:[UIColor blueColor]];
    [moreString3 setBackgroundColor:[UIColor clearColor]];
    moreString3.userInteractionEnabled = YES;
    UITapGestureRecognizer *moreModelButton3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreModel3Action:)];
    [moreString3 addGestureRecognizer:moreModelButton3];
    [scrollView addSubview:moreString3];


    [scrollView setContentSize:CGSizeMake(320, cookingStyleView.frame.origin.y+cookingStyleView.frame.size.height+300)];
    [self.view addSubview:scrollView];

}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top.png"] forBarMetrics:UIBarMetricsDefault];//导航栏背景
//    self.navigationController.navigationBarHidden = YES;
    

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchDown:(id)sender
{
    [sender setBackgroundColor:[UIColor colorWithRed:188/250.0 green:128/250.0 blue:0.0 alpha:1.0]];
}

//主题分类更多
-(void)moreModel2Action:(id)sender
{
    [UIView animateWithDuration:0.7 animations:^{
    
        moreString2.hidden = YES;
        
        UIButton *district7 = [[UIButton alloc] initWithFrame:CGRectMake(0, titleView.frame.origin.y+ButtonHeight*2+22,  ButtonWith, ButtonHeight)];
        [district7 addTarget:self action:@selector(district7Action:) forControlEvents:UIControlEventTouchDown];
        [self setAreaWithButton:district7 andTitle:@"东塘"];
        
        UIButton *district8 = [[UIButton alloc] initWithFrame:CGRectMake(ButtonWith+2, titleView.frame.origin.y+ButtonHeight*2+22,  ButtonWith, ButtonHeight)];
        [district8 addTarget:self action:@selector(district8Action:) forControlEvents:UIControlEventTouchDown];
        [self setAreaWithButton:district8 andTitle:@"四方坪"];
        
        UIButton *district9 = [[UIButton alloc] initWithFrame:CGRectMake(ButtonWith*2+2*2, titleView.frame.origin.y+ButtonHeight*2+22,  ButtonWith, ButtonHeight)];
        [district9 addTarget:self action:@selector(district9Action:) forControlEvents:UIControlEventTouchDown];
        [self setAreaWithButton:district9 andTitle:@"湘江世纪城"];
        
        UIButton *district10 = [[UIButton alloc] initWithFrame:CGRectMake(0, titleView.frame.origin.y+ButtonHeight*3+24,  ButtonWith, ButtonHeight)];
        [district10 addTarget:self action:@selector(district10Action:) forControlEvents:UIControlEventTouchDown];
        [self setAreaWithButton:district10 andTitle:@"锦泰广场"];
        
        UIButton *district11 = [[UIButton alloc] initWithFrame:CGRectMake(ButtonWith+2, titleView.frame.origin.y+ButtonHeight*3+24,  ButtonWith, ButtonHeight)];
        [district11 addTarget:self action:@selector(district11Action:) forControlEvents:UIControlEventTouchDown];
        [self setAreaWithButton:district11 andTitle:@"新开铺"];
        
        UIButton *district12 = [[UIButton alloc] initWithFrame:CGRectMake(ButtonWith*2+2*2, titleView.frame.origin.y+ButtonHeight*3+24,  ButtonWith, ButtonHeight)];
        [district12 addTarget:self action:@selector(district12Action:) forControlEvents:UIControlEventTouchDown];
        [self setAreaWithButton:district12 andTitle:@"星沙通程广场"];
        
        UIButton *district13 = [[UIButton alloc] initWithFrame:CGRectMake(0, titleView.frame.origin.y+ButtonHeight*4+26,  ButtonWith, ButtonHeight)];
        [district13 addTarget:self action:@selector(district13Action:) forControlEvents:UIControlEventTouchDown];
        [self setAreaWithButton:district13 andTitle:@"侯家塘"];
        
        UIButton *district14 = [[UIButton alloc] initWithFrame:CGRectMake(ButtonWith+2, titleView.frame.origin.y+ButtonHeight*4+26,  ButtonWith, ButtonHeight)];
        [district14 addTarget:self action:@selector(district14Action:) forControlEvents:UIControlEventTouchDown];
        [self setAreaWithButton:district14 andTitle:@"井湾子"];
        
        UIButton *district15 = [[UIButton alloc] initWithFrame:CGRectMake(ButtonWith*2+2*2, titleView.frame.origin.y+ButtonHeight*4+26,  ButtonWith, ButtonHeight)];
        [district15 addTarget:self action:@selector(district15Action:) forControlEvents:UIControlEventTouchDown];
        [self setAreaWithButton:district15 andTitle:@"伍家岭"];
        
        UIButton *district16 = [[UIButton alloc] initWithFrame:CGRectMake(0, titleView.frame.origin.y+ButtonHeight*5+28,  ButtonWith, ButtonHeight)];
        [district16 addTarget:self action:@selector(district16Action:) forControlEvents:UIControlEventTouchDown];
        [self setAreaWithButton:district16 andTitle:@"王家湾"];
        
        UIButton *district17 = [[UIButton alloc] initWithFrame:CGRectMake(ButtonWith+2, titleView.frame.origin.y+ButtonHeight*5+28,  ButtonWith, ButtonHeight)];
        [district17 addTarget:self action:@selector(district17Action:) forControlEvents:UIControlEventTouchDown];
        [self setAreaWithButton:district17 andTitle:@"窑岭"];
        
        UIButton *district18 = [[UIButton alloc] initWithFrame:CGRectMake(ButtonWith*2+2*2, titleView.frame.origin.y+ButtonHeight*5+28,  ButtonWith, ButtonHeight)];
        [district18 addTarget:self action:@selector(district18Action:) forControlEvents:UIControlEventTouchDown];
        [self setAreaWithButton:district18 andTitle:@"松桂园"];
        
        [districtView setFrame:CGRectMake(13, titleView.frame.origin.y+titleView.frame.size.height, 294, 30+ButtonHeight*6+8+2+20)];
        [cookingStyleView setFrame:CGRectMake(13, districtView.frame.origin.y+districtView.frame.size.height+5, 294, cookingStyleView.frame.size.height)];
        [moreString3 setFrame:CGRectMake(250, cookingStyleView.frame.origin.y +cookingStyleView.frame.size.height-10, 50, 50)];
    }
    completion:^(BOOL finished)
    {
        [scrollView setContentSize:CGSizeMake(320, cookingStyleView.frame.origin.y+cookingStyleView.frame.size.height+400)];

    }];
    
   
}

//菜系分类
-(void)moreModel3Action:(id)sender
{
    [UIView animateWithDuration:0.7 animations:^{
        moreString3.hidden = YES;
        
        UIButton *cookingStyle7 = [[UIButton alloc] initWithFrame:CGRectMake(0, ButtonHeight*2+42,  ButtonWith, ButtonHeight)];
        [cookingStyle7 addTarget:self action:@selector(cookingStyle7Action:) forControlEvents:UIControlEventTouchDown];
        [self setHotFoodsAreaWithButton:cookingStyle7 andTitle:@"川菜"];

        UIButton *cookingStyle8 = [[UIButton alloc] initWithFrame:CGRectMake(ButtonWith+2, ButtonHeight*2+42,  ButtonWith, ButtonHeight)];
        [cookingStyle8 addTarget:self action:@selector(cookingStyle8Action:) forControlEvents:UIControlEventTouchDown];
        [self setHotFoodsAreaWithButton:cookingStyle8 andTitle:@"粤菜／港菜"];
        
        UIButton *cookingStyle9 = [[UIButton alloc] initWithFrame:CGRectMake(ButtonWith*2+2*2, ButtonHeight*2+42,  ButtonWith, ButtonHeight)];
        [cookingStyle9 addTarget:self action:@selector(cookingStyle9Action:) forControlEvents:UIControlEventTouchDown];
        [self setHotFoodsAreaWithButton:cookingStyle9 andTitle:@"东北菜"];

        UIButton *cookingStyle10 = [[UIButton alloc] initWithFrame:CGRectMake(0, ButtonHeight*3+44, ButtonWith, ButtonHeight)];
        [cookingStyle10 addTarget:self action:@selector(cookingStyle10Action:) forControlEvents:UIControlEventTouchDown];
        [self setHotFoodsAreaWithButton:cookingStyle10 andTitle:@"私房菜"];

        UIButton *cookingStyle11 = [[UIButton alloc] initWithFrame:CGRectMake(ButtonWith+2, ButtonHeight*3+44, ButtonWith, ButtonHeight)];
        [cookingStyle11 addTarget:self action:@selector(cookingStyle11Action:) forControlEvents:UIControlEventTouchDown];
        [self setHotFoodsAreaWithButton:cookingStyle11 andTitle:@"新疆／清真"];

        UIButton *cookingStyle12 = [[UIButton alloc] initWithFrame:CGRectMake(ButtonWith*2+2*2, ButtonHeight*3+44,  ButtonWith, ButtonHeight)];
        [cookingStyle12 addTarget:self action:@selector(cookingStyle12Action:) forControlEvents:UIControlEventTouchDown];
        [self setHotFoodsAreaWithButton:cookingStyle12 andTitle:@"江浙菜"];

        [cookingStyleView setFrame:CGRectMake(13, districtView.frame.origin.y+districtView.frame.size.height+5, 294, 30+ButtonHeight*4+8+2+20)];
        [scrollView setContentSize:CGSizeMake(320, cookingStyleView.frame.origin.y+cookingStyleView.frame.size.height+300)];
    }];

}

//主题分类
//中餐
-(void)ChineseFoodAction:(id)sender
{
    [self searchStoresByCat:@"12"];
}

//西餐
-(void)WestFoodAction:(id)sender
{
    [self searchStoresByCat:@"13"];
}

-(void)buffetAction:(id)sender
{
    [self searchStoresByCat:@"14"];
}

-(void)snackAction:(id)sender
{
    [self searchStoresByCat:@"15"];
}

-(void)sweetFoodAction:(id)sernder
{
    [self searchStoresByCat:@"16"];
}

-(void)teaCoffeeFoodAction:(id)sender
{
    [self searchStoresByCat:@"17"];
}

-(void)breadCakeAction:(id)sender
{
    [self searchStoresByCat:@"18"];
}


//地区分类
//五一广场
-(void)district1Action:(id)sender
{
    [self searchStoresByLatitude:@"28.195279" andLongitude:@"112.976317" andLocationName:@"五一广场"];
}
//汽车西站
-(void)district2Action:(id)sender
{
    [self searchStoresByLatitude:@"28.209953" andLongitude:@"112.912824" andLocationName:@"汽车西站"];
}
//汽车东站
-(void)district3Action:(id)sender
{
    [self searchStoresByLatitude:@"28.201784" andLongitude:@"113.058672" andLocationName:@"汽车东站"];
}
//汽车南站
-(void)district4Action:(id)sender
{
    [self searchStoresByLatitude:@"28.097462" andLongitude:@"113.013718" andLocationName:@"汽车南站"];
}
//溁湾镇
-(void)district5Action:(id)sender
{
    [self searchStoresByLatitude:@"28.196054" andLongitude:@"112.952371" andLocationName:@"溁湾镇"];
}
//火车站
-(void)district6Action:(id)sender
{
    [self searchStoresByLatitude:@"28.194258" andLongitude:@"113.011572" andLocationName:@"火车站"];
}
//东塘
-(void)district7Action:(id)sender
{
    [self searchStoresByLatitude:@"28.169348" andLongitude:@"112.994835" andLocationName:@"东塘"];
}
//四方坪
-(void)district8Action:(id)sender
{
    [self searchStoresByLatitude:@"28.234343" andLongitude:@"113.013139" andLocationName:@"四方坪"];
}
//湘江世纪城
-(void)district9Action:(id)sender
{
    [self searchStoresByLatitude:@"28.261222" andLongitude:@"112.982798" andLocationName:@"湘江世纪城"];
}
//景泰广场
-(void)district10Action:(id)sender
{
    [self searchStoresByLatitude:@"28.193766" andLongitude:@"113.01743" andLocationName:@"景泰广场"];
}
//新开铺
-(void)district11Action:(id)sender
{
    [self searchStoresByLatitude:@"28.135142" andLongitude:@"112.970438" andLocationName:@"新开铺"];
}
//星沙通程广场
-(void)district12Action:(id)sender
{
    [self searchStoresByLatitude:@"28.244419" andLongitude:@"113.080237" andLocationName:@"星沙通程广场"];
}
//侯家塘
-(void)district13Action:(id)sender
{
    [self searchStoresByLatitude:@"28.172091" andLongitude:@"112.985287" andLocationName:@"侯家塘"];
}
//井湾子
-(void)district14Action:(id)sender
{
    [self searchStoresByLatitude:@"28.124451" andLongitude:@"113.006058" andLocationName:@"井湾子"];
}
//伍家岭
-(void)district15Action:(id)sender
{
    [self searchStoresByLatitude:@"28.228331" andLongitude:@"112.987518" andLocationName:@"伍家岭"];
}
//王家湾
-(void)district16Action:(id)sender
{
    [self searchStoresByLatitude:@"28.161895" andLongitude:@"112.926278" andLocationName:@"王家湾"];
}
//窑岭
-(void)district17Action:(id)sender
{
    [self searchStoresByLatitude:@"28.185747" andLongitude:@"112.997432" andLocationName:@"窑岭"];
}
//松桂园
-(void)district18Action:(id)sender
{
    [self searchStoresByLatitude:@"28.203448" andLongitude:@"112.986059" andLocationName:@"松桂园"];
}


//热门菜系
-(void)cookingStyle1Action:(id)sender
{
    [self searchStoresByTerm:@"湘菜"];
}
-(void)cookingStyle2Action:(id)sender
{
    [self searchStoresByTerm:@"家常菜"];
}
-(void)cookingStyle3Action:(id)sender
{
    [self searchStoresByTerm:@"土家"];
}
-(void)cookingStyle4Action:(id)sender
{
    [self searchStoresByTerm:@"火锅"];
}
-(void)cookingStyle5Action:(id)sender
{
    [self searchStoresByTerm:@"海鲜"];
}
-(void)cookingStyle6Action:(id)sender
{
    [self searchStoresByTerm:@"烧烤"];
}
-(void)cookingStyle7Action:(id)sender
{
    [self searchStoresByTerm:@"川菜"];
}
-(void)cookingStyle8Action:(id)sender
{
    [self searchStoresByTerm:@"粤菜"];
}
-(void)cookingStyle9Action:(id)sender
{
    [self searchStoresByTerm:@"东北菜"];
}
-(void)cookingStyle10Action:(id)sender
{
    [self searchStoresByTerm:@"私房菜"];
}
-(void)cookingStyle11Action:(id)sender
{
    [self searchStoresByTerm:@"新疆"];
}
-(void)cookingStyle12Action:(id)sender
{
    
    [self searchStoresByTerm:@"江浙菜"];
}

-(void)scrollViewPressedAction:(id)sender
{
    [searchBar resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender
{
    [searchBar resignFirstResponder];
}

//普通搜索 懂味
- (void)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar
{
    [theSearchBar resignFirstResponder];
    [self searchStoresByTerm:searchBar.text];
    
}
-(void)searchStoresByTerm:(NSString *)term
{
    NSString *locationName;
    //定位失败
    if(![globalVariateModel.locationIsAvailabelOnPhone isEqualToString:@"yes"])
    {
        locationName = @"定位失败，默认你在五一广场";
    }
    //定位成功
    else
    {
        locationName = globalVariateModel.userAddress;
        if([locationName length]>3)
            locationName = [NSString stringWithFormat:@"你在:%@",[locationName substringFromIndex:3]];
        else if([locationName length]>0)
            locationName = [NSString stringWithFormat:@"你在:%@",locationName];
    }

    [self searchViewControllerWithCat:@"1" andRadius:@"500000" andTerm:term andSort:@"1" andPrice:@"1" andLatitude:[globalVariateModel latitude] andLongitude:[globalVariateModel longitude] andPage:@"1" andLoacationName:locationName];
}

//主题分类搜索
- (void)searchStoresByCat:(NSString *)cat
{
    NSString *locationName;
    //定位失败
    if(![globalVariateModel.locationIsAvailabelOnPhone isEqualToString:@"yes"])
    {
        locationName = @"定位失败，默认你在五一广场";
    }
    //定位成功
    else
    {
        locationName = globalVariateModel.userAddress;
        if([locationName length]>3)
            locationName = [NSString stringWithFormat:@"你在:%@",[locationName substringFromIndex:3                                                                                        ]];
        else if([locationName length]>0)
            locationName = [NSString stringWithFormat:@"你在:%@",locationName];
    }
        
    [self searchViewControllerWithCat:cat andRadius:@"1000" andTerm:@"" andSort:@"1" andPrice:@"1" andLatitude:[globalVariateModel latitude] andLongitude:[globalVariateModel longitude] andPage:@"1" andLoacationName:locationName];
}

//地区分类搜索
- (void)searchStoresByLatitude:(NSString *)theLatitude andLongitude:(NSString *)theLongitude andLocationName:(NSString *)locationName
{
    
    [self searchViewControllerWithCat:@"1" andRadius:@"1000" andTerm:@"" andSort:@"1" andPrice:@"1" andLatitude:theLatitude andLongitude:theLongitude andPage:@"1" andLoacationName:locationName];
}

-(void)searchViewControllerWithCat:(NSString *)cat andRadius:(NSString *)radius andTerm:(NSString *)term andSort:(NSString *)sort andPrice:(NSString *)price andLatitude:(NSString *)theLatitude andLongitude:(NSString *)theLongitude andPage:(NSString *)page andLoacationName:(NSString *)locationName
{
    NearbyViewController *searchViewController = [[NearbyViewController alloc] initWithNibName:@"NearbyViewController" bundle:nil];
    searchViewController.isAdvancedSearch = YES;
    searchViewController.catForPass = cat;
    searchViewController.radiusForPass = radius;
    searchViewController.termForPass = term;
    searchViewController.sortForPass = sort;
    searchViewController.priceForPass = price;
    searchViewController.latitudeForPass = theLatitude;
    searchViewController.longitudeForPass = theLongitude;
    searchViewController.pageForPass = page;
    searchViewController.locationName = locationName;
    
    searchViewController.hidesBottomBarWhenPushed = YES;
    searchViewController.title = @"搜索";
    [self.navigationController pushViewController:searchViewController animated:YES];
}


//主题块的设置
-(void)setTitleAreaWithButton:(UIButton *)button andTitle:(NSString *)title
{
    [self commonWithButton:button andTitle:title];
    [button setBackgroundColor:[UIColor colorWithRed:254/255.0 green:223/255.0 blue:231/255.0 alpha:1]];
    [titleView addSubview:button];
}

//地区块的设置
-(void)setAreaWithButton:(UIButton *)button andTitle:(NSString *)title
{
    [self commonWithButton:button andTitle:title];
    [button setBackgroundColor:[UIColor colorWithRed:145/255.0 green:239/255.0 blue:255/255.0 alpha:1]];
    [districtView addSubview:button];
}

//热门菜系块的设置
-(void)setHotFoodsAreaWithButton:(UIButton *)button andTitle:(NSString *)title
{
    [self commonWithButton:button andTitle:title];
    [button setBackgroundColor:[UIColor colorWithRed:215/255.0 green:254/255.0 blue:190/255.0 alpha:1]];
    [cookingStyleView addSubview:button];
}

-(void)commonWithButton:(UIButton *)button andTitle:(NSString *)title
{
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
}

@end
