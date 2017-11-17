//
//  GD_ImageChoice.h
//
//  Created by lizhanpeng on 2017/11/16.
//  Copyright © 2017年 anchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^ReturnImageBlock)(UIImage *OriginalImage,UIImage *EditImage);

typedef NS_ENUM(NSInteger,SourceType) {
    _Source_PhotoLibrary = 0,
    _Source_Camera,
    _Source_PhotosAlbum
};

@interface GD_ImageChoice : NSObject

+ (void)showImageChoicePageSourceType:(SourceType)SType
                               fromVC:(UIViewController *)FVC
                               isEdit:(BOOL)isEdit
                        completeBlock:(ReturnImageBlock)RBlock;

@end
