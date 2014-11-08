//
//  ALMineViewController.m
//  iOutletShopping
//
//  Created by Huashen on 14-9-30.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALMineViewController.h"
#import "ALLoginViewController.h"
#import "ALMineCollectionViewController.h"
#import "ALSlideSwitchView.h"
#import "PPRevealSideViewController.h"
#import "VPImageCropperViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "ALSettingViewController.h"
const float ORIGINAL_MAX_WIDTH = 640.0f;

@interface ALMineViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate, UIActionSheetDelegate, VPImageCropperDelegate,ALSlideSwitchViewDelegate,ALMineCollectionViewControllerDelegate>
{
    ALSlideSwitchView *_slideSwitchView;
    NSMutableArray *_collectionViewArray;
}
//头像的imageView
@property (weak, nonatomic) IBOutlet UIImageView *portraitImageView;
//未登录UI
@property (weak, nonatomic) IBOutlet UIView *unLoginView;
//已登录UI
@property (weak, nonatomic) IBOutlet UIView *loginView;
//显示用户名
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
//显示等级
@property (weak, nonatomic) IBOutlet UILabel *levelLable;
//显示积分
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

//只用于显示等级徽章的图片
@property (weak, nonatomic) IBOutlet UIButton *levelBadgeBtn;



@end

@implementation ALMineViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //修改状态栏为白色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self loadPortrait];
    [self showLoginView];

    [self addMineCollectionView];
    
}
#pragma mark - 添加我的订单/收藏/优惠券
-(void)addMineCollectionView
{
    _slideSwitchView = [[ALSlideSwitchView alloc] initWithFrame:CGRectMake(0, 162, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-162)];
    _slideSwitchView.delegate = self;
    [self.view addSubview:_slideSwitchView];
    
    //0. 设置我的订单/我的收藏/优惠券字体的颜色和背景
    _slideSwitchView.tabItemNormalColor = [ALSlideSwitchView colorFromHexRGB:@"868686"];
    _slideSwitchView.tabItemSelectedColor = [ALSlideSwitchView colorFromHexRGB:@"bb0b15"];
    _slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    NSArray *tabTitles = [NSArray arrayWithObjects:@"我的订单",@"我的收藏",@"优惠券", nil];
    
    //2. 有多个标题创建多少个collectionView以展示不同的数据
    int count = tabTitles.count;
    _collectionViewArray = [NSMutableArray arrayWithCapacity:count+1];
    for (int  i = 0; i < count; i++) {
        UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
        
        ALMineCollectionViewController *collectionCtrl = [[ALMineCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
        
        collectionCtrl.title = tabTitles[i];
        collectionCtrl.delegate = self;
        [_collectionViewArray addObject:collectionCtrl];
        //背景色一定要在 addObject之后设置，要不然flowLayout不会调用代理方法
        collectionCtrl.collectionView.backgroundColor = [UIColor clearColor];
    }
    
    [_slideSwitchView buildUIFix:YES];

}
#pragma mark - collectionView自定义代理方法的实现
-(void)mineCollectionViewController:(ALMineCollectionViewController *)controller jumpTo:(NSString *)className
{
    
    [ALJumpToAnotherUI jumpToAnotherUI:className withNavCtrl:self.navigationController];
}
#pragma mark - 滑动tab视图代理方法

- (NSUInteger)numberOfTab:(ALSlideSwitchView *)view
{
    return _collectionViewArray.count;
}

- (UIViewController *)slideSwitchView:(ALSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    return _collectionViewArray[number];
}


#pragma mark - 显示登陆或已登录界面
-(void)showLoginView
{
    //登陆了，隐藏未登录UI，显示已登陆UI
    _unLoginView.hidden = [JudgeLogin shareInstance].login;
    _loginView.hidden = !_unLoginView.hidden;
}


#pragma mark - 点击设置
- (IBAction)settingClicked:(UIButton *)sender {
    ALLog(@"setting button clicked");
    ALSettingViewController *setting = [[ALSettingViewController alloc] init];
    [self.navigationController pushViewController:setting animated:YES];
}

#pragma mark - 点击登陆
- (IBAction)loginBtnClicked:(UIButton *)sender {
    ALLog(@"login button clicked");
    ALLoginViewController *loginViewCtrl = [[ALLoginViewController alloc] init];
    [self.navigationController pushViewController:loginViewCtrl animated:YES];
}

#pragma mark - 设置头像ImageView为圆形
-(void)setPortraitImageView:(UIImageView *)portraitImageView
{
    _portraitImageView = portraitImageView;
    [_portraitImageView.layer setCornerRadius:(_portraitImageView.frame.size.height/2)];
    //让图片不超过view的范围
    [_portraitImageView.layer setMasksToBounds:YES];
    [_portraitImageView setContentMode:UIViewContentModeScaleAspectFill];
    //隐藏多余的部分
    [_portraitImageView setClipsToBounds:YES];
    _portraitImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    _portraitImageView.layer.shadowOffset = CGSizeMake(4, 4);
    _portraitImageView.layer.shadowOpacity = 0.5;
    _portraitImageView.layer.shadowRadius = 2.0;
    _portraitImageView.layer.borderColor = [UIColor grayColor].CGColor;
    _portraitImageView.layer.borderWidth = 2.0f;
    _portraitImageView.userInteractionEnabled = YES;
    //    _portraitImageView.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *portraitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait)];
    [_portraitImageView addGestureRecognizer:portraitTap];
}
#pragma mark - 加载显示头像
- (void)loadPortrait {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        NSURL *portraitUrl = [NSURL URLWithString:@"http://photo.l99.com/bigger/31/1363231021567_5zu910.jpg"];
        UIImage *protraitImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:portraitUrl]];
        
        protraitImg = [UIImage imageNamed:@"IDInfo.png"];
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.portraitImageView.image = protraitImg;
        });
    });
}
#pragma mark - 弹出相片选择源
- (void)editPortrait {
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [choiceSheet showInView:self.view];
}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    self.portraitImageView.image = editedImage;
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

@end
