//
//  JDNAutoNaviMapViewController.m
//  DongWay
//
//  Created by Jordan on 7/24/13.
//  Copyright (c) 2013 Jordan. All rights reserved.
//

#import "JDNAutoNaviMapViewController.h"
#import "GlobalVariateModel.h"
#import "StoresModel.h"
#import "Common.h"
#import "StoreDetailViewController.h"

@interface JDNAutoNaviMapViewController ()
{
    Common *common;
}
@end

@implementation JDNAutoNaviMapViewController



- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
            
            annotationView.canShowCallout            = YES;
            annotationView.animatesDrop              = YES;
            annotationView.draggable                 = YES;
            if(self.isFromListStores == YES)
            {
                annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            }
        }
        else
        {
            annotationView.annotation = annotation;
        }
        
        annotationView.pinColor = [self.locations indexOfObject:annotation];
        
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    int i = [self.recommendStoresArray count];
    for (int j=0; j<i; j++)
    {
        if(view.annotation == [self.mapView.annotations objectAtIndex:j])
        {
            StoresModel *storesModelFromListStores = [[StoresModel alloc] init];
            NSDictionary *recommendStore = [self.recommendStoresArray objectAtIndex:j];
            [storesModelFromListStores setPropertysWithDictionary:recommendStore];
            
            StoreDetailViewController *storeDetailView = [[StoreDetailViewController alloc] initWithNibName:@"StoreDetailViewController" bundle:nil];
            storeDetailView.storesModel = storesModelFromListStores;
            storeDetailView.latitude = self.latitude;
            storeDetailView.longitude = self.longitude;
            storeDetailView.locationName = self.locationName;
            storeDetailView.hidesBottomBarWhenPushed = YES;
            storeDetailView.isDiscountStore = NO;
            [self.navigationController pushViewController:storeDetailView animated:YES];
        }
    }
    
}


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
    common = [[Common alloc] init];
    [common returnButton:self];
    
    self.title = @"地图模式";
    
    
    NSMutableArray *locationArray = [[NSMutableArray alloc] init];
    MAPointAnnotation *locationCenter = [[MAPointAnnotation alloc] init];
    
    
    //这是附近多家商家
    if(self.isFromListStores == YES)
    {
        
        StoresModel *storesModelFromListStores = [[StoresModel alloc] init];
        int count = [self.recommendStoresArray count];
        for(int i=0;i<count;i++)
        {
            MAPointAnnotation *location = [[MAPointAnnotation alloc] init];
            NSDictionary *recommendStore = [self.recommendStoresArray objectAtIndex:i];
            [storesModelFromListStores setPropertysWithDictionary:recommendStore];
            
            if(i==0)
            {
                locationCenter.coordinate = CLLocationCoordinate2DMake([storesModelFromListStores.latitude floatValue], [storesModelFromListStores.longtitude floatValue]);
                locationCenter.title = storesModelFromListStores.storeName;
                if([storesModelFromListStores.status isEqualToString:@"20"])
                {
                    locationCenter.subtitle = @"有优惠";
                }
                [locationArray addObject:locationCenter];
                continue;
            }
            
            location.coordinate = CLLocationCoordinate2DMake([storesModelFromListStores.latitude floatValue], [storesModelFromListStores.longtitude floatValue]);
            location.title = storesModelFromListStores.storeName;
            
            if([storesModelFromListStores.status isEqualToString:@"20"])
            {
                location.subtitle = @"有优惠";
            }
            
            [locationArray addObject:location];
        }
        

    }
    //这是商家详情的一家
    else if(self.isFromSignleStore == YES)
    {
//        MAPointAnnotation *location = [[MAPointAnnotation alloc] init];
//        location.coordinate = CLLocationCoordinate2DMake([self.storeModelFromSingleStore.latitude floatValue], [self.storeModelFromSingleStore.longtitude floatValue]);
//        location.title = self.storeModelFromSingleStore.storeName;
//        [locationArray addObject:location];
        
        locationCenter.coordinate = CLLocationCoordinate2DMake([self.storeModelFromSingleStore.latitude floatValue], [self.storeModelFromSingleStore.longtitude floatValue]);
        locationCenter.title = self.storeModelFromSingleStore.storeName;
        [locationArray addObject:locationCenter];
        
        self.isFromSignleStore = NO;
    }
    
   
    self.mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    self.mapView.delegate = self;
    
    if (self) {
        self.locations = [NSMutableArray array];
        
        
        [self.locations addObjectsFromArray:locationArray];
        
        [self.mapView addAnnotations:self.locations];
        
        //        self.mapView.visibleMapRect = MAMapRectMake(220880, 101476, 27249, 46665);
        self.mapView.visibleMapRect = MAMapRectMake(220880104, 101476980,  9249, 13265);
        
        [self.mapView setCenterCoordinate: locationCenter.coordinate];
    }
    [self.mapView selectAnnotation:locationCenter animated:YES];
    [self.view addSubview:self.mapView];

}

//点击title的时候，就是取消大头针的点击效果，触发该事件
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view NS_AVAILABLE(NA, 4_0)
{
}
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view NS_AVAILABLE(NA, 4_0)
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *) keyForMap{
    return @"26b0e6bd0897a4e6289ff842bed69baf";
}


- (id)init{
    self = [super init];
    
    
    return self;
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
  }

@end
