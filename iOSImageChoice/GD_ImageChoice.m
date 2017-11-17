//
//  GD_ImageChoice.m
//
//  Created by lizhanpeng on 2017/11/16.
//  Copyright © 2017年 anchen. All rights reserved.
//

#import "GD_ImageChoice.h"

static NSString *const obj = @"obj";

@interface GD_ImageChoice()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    ReturnImageBlock returnImageBlock;
    
    UIViewController *fromVC;
}
@end

@implementation GD_ImageChoice

+(instancetype)getInstance{
    return [[self alloc] init];
}
static GD_ImageChoice *ImageChoice;
+ (void)showImageChoicePageSourceType:(SourceType)SType
                              fromVC:(UIViewController *)FVC
                              isEdit:(BOOL)isEdit
                       completeBlock:(ReturnImageBlock)RBlock{
    
    ImageChoice = [[GD_ImageChoice alloc] init];
    [ImageChoice OBJ_ShowImageChoicePageSourceType:SType fromVC:FVC isEdit:isEdit completeBlock:RBlock];
}

- (void)OBJ_ShowImageChoicePageSourceType:(SourceType)SType
                                  fromVC:(UIViewController *)FVC
                                  isEdit:(BOOL)isEdit
                            completeBlock:(ReturnImageBlock)RBlock{
    
    
    SourceType cSType = SType;
    
    fromVC = FVC;
    
    returnImageBlock = RBlock;
    
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        returnImageBlock(nil,nil);
        return;
    }
    
    if (cSType == _Source_Camera) {
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            returnImageBlock(nil,nil);
            return;
        }
    }
    if (cSType == _Source_PhotoLibrary) {
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            returnImageBlock(nil,nil);
            return;
        }
    }
    if (cSType == _Source_PhotosAlbum) {
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        {
            returnImageBlock(nil,nil);
            return;
        }
    }
    
    UIImagePickerControllerSourceType sourcheType = (UIImagePickerControllerSourceType)cSType;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.navigationBar.barTintColor = [UIColor whiteColor];
    picker.navigationBar.tintColor = [UIColor blackColor];
    picker.sourceType = sourcheType;
    picker.allowsEditing = isEdit;
    
    [fromVC presentViewController:picker animated:YES completion:nil];

}

-(void)dealloc{
}

- (void)disMiss:(UIImagePickerController *)pic{
    [pic dismissViewControllerAnimated:YES completion:^{
    }];
    
    ImageChoice = nil;
    fromVC = nil;
    returnImageBlock = nil;
}

- (void)imagePickerController:(UIImagePickerController *)epicker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *orImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *EdImage = [info objectForKey:UIImagePickerControllerEditedImage];
    returnImageBlock(orImage,EdImage);
    
    [self disMiss:epicker];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)epicker{
    returnImageBlock(nil,nil);
    [self disMiss:epicker];
}

@end
