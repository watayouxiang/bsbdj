//
//  ttConst.h
//  bsbdj
//
//  Created by 王涛 on 16/7/25.
//  Copyright © 2016年 wata. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ttTopicTypeAll = 1,
    ttTopicTypePicture = 10,
    ttTopicTypeWord = 29,
    ttTopicTypeVoice = 31,
    ttTopicTypeVideo = 41
} ttTopicType;

/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const ttTitilesViewH;
/** 精华-顶部标题的Y(状态栏20+导航栏44) */
UIKIT_EXTERN CGFloat const ttTitilesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const ttTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const ttTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const ttTopicCellBottomBarH;

/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const ttTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度,就是用BreakH */
UIKIT_EXTERN CGFloat const ttTopicCellPictureBreakH;

/** ttUser模型-性别属性值 */
UIKIT_EXTERN NSString * const ttUserSexMale;
UIKIT_EXTERN NSString * const ttUserSexFemale;

/** 精华-cell-最热评论标题的高度 */
UIKIT_EXTERN CGFloat const ttTopicCellTopCmtTitleH;

/** tabBar被选中的通知名字 */
UIKIT_EXTERN NSString * const ttTabBarDidSelectNotification;
/** tabBar被选中的通知 - 被选中的控制器的index key */
UIKIT_EXTERN NSString * const ttSelectedControllerIndexKey;
/** tabBar被选中的通知 - 被选中的控制器 key */
UIKIT_EXTERN NSString * const ttSelectedControllerKey;

/** 标签-间距 */
UIKIT_EXTERN CGFloat const ttTagMargin;
/** 标签-高度 */
UIKIT_EXTERN CGFloat const ttTagH;


