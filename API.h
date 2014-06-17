//
//  API.h
//  Account
//
//  Created by wang zhe on 9/3/13.
//
//

#import <Foundation/Foundation.h>
#define IP @"http://old.idongway.com"
#define GET_ADDRESS_DW [IP stringByAppendingString: @"/sohoweb/q?method=address.get&format=json&lat=%@&long=%@"]
#define Get_Comment_URL  [IP stringByAppendingString:@"/sohoweb/q?method=comment.get&format=json&cat=%@&storeID=%@"]
#define ADD_Comment_URL [IP stringByAppendingString: @"/sohoweb/q?method=comment.add&format=json&cat=%@&storeID=%@&commentID=%@&comment=%@&score=%@&userName=%@&taste=%@&environment=%@&service=%@&price=%@"]

#define Get_Store_URL [IP stringByAppendingString: @"/sohoweb/q?method=store.get&format=json&cat=%@&latitude=%@&longitude=%@&radius=%@&sort=%@&page=%@&price=%@&term=%@"]
#define Get_GroupBuy_URL [IP stringByAppendingString: @"/sohoweb/q?method=groupBuy.get&format=json&page="]
//登陆
#define Get_UserInfo_URL [IP stringByAppendingString: @"/sohoweb/q?method=userInfo.get&format=json&userName=%@&userPWord=%@"]
//注册
#define ADD_UserInfo_URL [IP stringByAppendingString: @"/sohoweb/q?method=userInfo.add&format=json&userName=%@&userPWord=%@&telephone=%@&email=%@&iMEI=2&iCCID=1&iMSI=2&isverdify=2"]

#define Get_StoreByGps_URL [IP stringByAppendingString: @"/sohoweb/q?method=store.get&format=json&latitude=28.1436004638672&longitude=112.966003417969&radius=3000"]
#define Get_StroeByCategroy_URL [IP stringByAppendingString: @"/sohoweb/q?method=store.get&format=json&cat="]
#define Get_Favorite_URL [IP stringByAppendingString: @"/sohoweb/q?method=storeCollection.get&format=json&userName=%@"]
#define DEL_Favorite_URL [IP stringByAppendingString: @"/sohoweb/q?method=storeCollection.del&format=json&storeID=%@&userName=%@"]

#define Get_APK_URL [IP stringByAppendingString: @"/sohoweb/DongWei.apk"]
#define Get_SoftInfo_URL [IP stringByAppendingString: @"/sohoweb/q?method=softInfo.get&format=json"]
#define Get_SignIn_URL [IP stringByAppendingString: @"/sohoweb/q?method=checkin.add&format=json&userName=%@&storeID=%@&latitude=%@&longitude=%@"]
#define Get_SendQuestion_URL [IP stringByAppendingString: @"/sohoweb/q?method=storeerror.add&format=json&userName=%@&storeID=%@&latitude=%@&longitude=%@&content=%@"]
#define Get_AddStore_URL [IP stringByAppendingString: @"/sohoweb/q?method=storebyuser.add&format=json&storeID=%@&storeName=%@&cate=%@&ad=%@&tel=%@&recommend=%@&price=%@&score=%@&taste=%@&envir=%@&service=%@&desc=%@"]
#define Get_Discount_Info_Url [IP stringByAppendingString: @"/sohoweb/q?method=discountInfo.get&format=json&page=%@&storeID=%@"]
#define Get_Discount_Ticket [IP stringByAppendingString: @"/sohoweb/q?method=userdiscount.add&format=json&userName=%@&discountCode=%@&discountID=%@&storeID=%@"]
#define Get_User_Discount_Ticket [IP stringByAppendingString: @"/sohoweb/q?method=userdiscount.get&format=json&userName=%@"]
#define Del_User_Discount_Ticket [IP stringByAppendingString: @"/sohoweb/q?method=userdiscount.del&format=json&userName=%@&discountCode=%@"]
#define Get_Recommend_Store [IP stringByAppendingString: @"/sohoweb/q?method=recommendStore.get&format=json&cat=%@&latitude=%@&longitude=%@&radius=%@&sort=%@&page=%@&price=%@"]
#define Get_Store_Introduce [IP stringByAppendingString: @"/sohoweb/q?method=recommendStore.get&format=json&cat=1&storeID="]
#define GET_VERDIFY_CODE [IP stringByAppendingString: @"/sohoweb/q?method=verdifyCode.get&format=json&souce=%@"]
#define CHECK_VERDIFY_CODE [IP stringByAppendingString: @"/sohoweb/q?method=verdifyCode.check&format=json&code=%@&souce=%@&userName=%@"]
#define GET_ROOM_URL [IP stringByAppendingString: @"/tableorder/q?method=orderRoomInfo.get&format=json&storeID=%@&isNoon=%@&orderTime=%@"]
#define GET_HALL_URL [IP stringByAppendingString: @"/tableorder/q?method=orderHallInfo.get&format=json&storeID=%@&isNoon=%@&orderTime=%@"]
#define SEND_ORDER_URL [IP stringByAppendingString: @"/tableorder/q?method=orderInfo.add&format=json&storeID=%@&userName=%@&orderName=%@&orderTime=%@&orderTel=%@&note=%@&peoNum=%@&tableInfo=%@&tableID=%@&source=%@&isNoon=%@&isTel=%@&customerID=%@&status=%@&orderSex=%@&userID=%@&isSMS=%@&ID=%@"]

#define ADD_StoreCollection_URL [IP stringByAppendingString: @"/sohoweb/q?method=storeCollection.add&format=json&storeID=%@&userName=%@"]
#define GET_FOODRAIDERS_URL [IP stringByAppendingString: @"/sohoweb/q?method=foodRaiders.get&format=json&frDetailsID=%@"]
#define Search_FOODRAIDERS_URL [IP stringByAppendingString: @"/sohoweb/q?method=foodRaiders.get&format=json&frID=0&kw=%@"]

#define GET_FRDETAIL_URL [IP stringByAppendingString: @"/sohoweb/q?method=frDetailByID.get&format=json&frDetailsID=%@"]
#define GET_FRCOMMENT_URL [IP stringByAppendingString: @"/sohoweb/q?method=frComment.get&format=json&frDetailsID=%@"]
#define ADD_FRCOMMENT_URL [IP stringByAppendingString: @"/sohoweb/q?method=frComment.add&format=json&frDetailsID=%@&userID=%@&parentID=%@&commentInfo=%@"]
#define ADD_FRCOLLECTION_URL [IP stringByAppendingString: @"/sohoweb/q?method=frCollection.add&format=json&userName=%@&foodRaidersID=%@"]
#define DEL_FRCOLLECTION_URL [IP stringByAppendingString: @"/sohoweb/q?method=frCollection.del&format=json&userName=%@&foodRaidersID=%@"]
#define GET_FRCOLLECTION_USER_URL [IP stringByAppendingString: @"/sohoweb/q?method=frCollection.get&format=json&userName=%@"]
#define GET_ORDERINFO_URL [IP stringByAppendingString: @"/tableorder/q?method=orderByUser.get&format=json&userName=%@&type=%@"]
#define CHANGE_USER_PASSWORD [IP stringByAppendingString: @"/sohoweb/q?method=pWord.change&format=json&oldPword=%@&newPword=%@&userName=%@"]
#define POST_USERIMAGE_URL [IP stringByAppendingString: @"/sohoweb/q?method=upLoadImage.post&format=json"]

#define ADD_USERCard_URL [IP stringByAppendingString: @"/sohoweb/q?method=userCard.add&format=json&userID=%@&cardID=%@&cardCode=%@"]
#define GET_DWActivities_URL [IP stringByAppendingString: @"/sohoweb/q?method=dWActivities.get&format=jason&status=%@"]

//签到
#define User_Checkin_URL [IP stringByAppendingString: @"/sohoweb/q?method=checkin.add&format=json&userName=%@&latitude=%@&longitude=%@"]
//通过storeid得到storeinformation
#define StoreInfo_FromStoreID_URL [IP stringByAppendingString: @"/sohoweb/q?method=recommendStore.get&format=json&cat=1&storeID=%@"]
//通过storeID得到discountStoreInformation
#define DiscountStoreInfo_FromStoreID_URL  [IP stringByAppendingString: @"/sohoweb/q?method=discountInfo.get&format=json&storeID=%@"]

//得到appstore软件的信息http://itunes.apple.com/lookup?id=508704237
#define APPStoreInfo_URL @"http://itunes.apple.com/lookup?id=%@"

//获取首页banner
#define GetBannerInfos_URL [IP stringByAppendingString: @"/sohoweb/q?method=dWIndexData.get&format=json&bid=%@"]

@interface API : NSObject

@end
