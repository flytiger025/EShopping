//
//  Macro.h
//  EShopping
//
//  Created by 任龙宇 on 15/3/7.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#ifndef EShopping_Macro_h
#define EShopping_Macro_h



#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height



#define NAV_TAB_BAR_HEIGHT  44
#define UI_TABBAR_HEIGHT 40
#define UI_NAVIGATION_HEIGHT 64



#define COLLECTION_CELL_WIDTH   (SCREEN_WIDTH - 30) / 2
#define COLLECTION_COLUMN_COUNT 2



#define RANDOM_COLOR    [UIColor colorWithRed:arc4random() % 256 / 255. green:arc4random() % 256 / 255. blue:arc4random() % 256 / 255. alpha:1.]



#define NV_ZHUANG_URL @"http://zhekou.repai.com/lws/view/nvzhuang_mobile.php?app_id=2222&sche=fenfen"


//微博SDK
#define WB_KEY @"2446411309"
#define WB_SECRET @"18a08127da16f58383a5d6bf84a5d5b2"
#define WB_REDIRECTURI @"http://www.sharesdk.cn"

//微信SDK
#define WX_KEY @"wxefea52b67b2ec418"
#define WX_SECRET @"bffac63c57026b175aebc41b2d1c3fb2"

//腾讯SDK
#define QQ_ID @"1104360133"
#define QQ_KEY @"QpBqvwz4UrjWZ4XT"


//shareSDK
#define SHARESDK_KEY @"6213cccb4378"

//友盟
#define UMENG_KEY @"55064640fd98c5b8610004a0"
#define UMENG_CHANNEL_ID @""


#endif
