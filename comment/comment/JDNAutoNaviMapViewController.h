//
//  JDNAutoNaviMapViewController.h
//  DongWay
//
//  Created by Jordan on 7/24/13.
//  Copyright (c) 2013 Jordan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAMapKit.h"
#import "StoresModel.h"

@interface JDNAutoNaviMapViewController : UIViewController <MAMapViewDelegate>

@property (strong, nonatomic)StoresModel *storeModelFromSingleStore;
@property (nonatomic) BOOL isFromSignleStore;
@property (nonatomic) BOOL isFromListStores;
@property (strong, nonatomic) MAMapView *mapView;
@property (strong, nonatomic) NSMutableArray *locations;
@property (strong, nonatomic) NSArray *recommendStoresArray;

@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (copy, nonatomic) NSString *locationName;

@end
