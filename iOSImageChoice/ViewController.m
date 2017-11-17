//
//  ViewController.m
//  iOSImageChoice
//
//  Created by lizhanpeng on 2017/11/17.
//  Copyright © 2017年 anchen. All rights reserved.
//

#import "ViewController.h"
#import "GD_ImageChoice.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *but = [UIButton buttonWithType:1];
    [self.view addSubview:but];
    but.frame = CGRectMake(100, 100, 100, 100);
    [but setTitle:@"相册" forState:0];
    [but addTarget:self action:@selector(selectImageAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectImageAction{
    [GD_ImageChoice showImageChoicePageSourceType:_Source_PhotoLibrary
                                           fromVC:self
                                           isEdit:YES
                                    completeBlock:^(UIImage *OriginalImage, UIImage *EditImage) {
                                        
                                        NSLog(@" ======== %@",OriginalImage);
                                    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
