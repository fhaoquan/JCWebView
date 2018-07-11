//
//  SHRS_ProgressHUD.m
//  UUUKK
//
//  Created by JOJO on 2018/03/12.
//

#import "SHRS_ProgressHUD.h"
#import "MBProgressHUD.h"
@interface SHRS_ProgressHUD()
@end
static UIView *maskView;
@implementation SHRS_ProgressHUD
static MBProgressHUD *mbpHUd;
//tianjialajifangfa-858//
+ (void)showProgressHudLoading:(NSString *)title andView:(UIView *)view{
//    [SHRS_ProgressHUD hiddenHud];
    if (view == nil) { //xuyaotianjialajidaimadifang-3214//
        return;
    }
    if (mbpHUd != nil) {
        [SHRS_ProgressHUD hiddenProgressHud]; //xuyaotianjialajidaimadifang-3215//
    }
    if ([title isEqualToString:@""] || title == nil) {
        mbpHUd = [MBProgressHUD showHUDAddedTo:view animated:YES]; //xuyaotianjialajidaimadifang-3216//
        [view bringSubviewToFront:mbpHUd];
    }else{
        mbpHUd = [MBProgressHUD showHUDAddedTo:view animated:YES]; //xuyaotianjialajidaimadifang-3217//
        mbpHUd.labelText = title;
        [view bringSubviewToFront:mbpHUd]; //xuyaotianjialajidaimadifang-3218//
    }
}
//tianjialajifangfa-859//
+ (void)showProgressHudTitle:(NSString *)title andView:(UIView *)view{
//    [SHRS_ProgressHUD hiddenHud];
    if (mbpHUd != nil) {
        [SHRS_ProgressHUD hiddenProgressHud]; //xuyaotianjialajidaimadifang-3219//
    }
    mbpHUd = [MBProgressHUD showHUDAddedTo:view animated:YES]; //xuyaotianjialajidaimadifang-3220//
    mbpHUd.mode = MBProgressHUDModeCustomView;
    mbpHUd.margin = 10.f; //xuyaotianjialajidaimadifang-3221//
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.numberOfLines = NSIntegerMax; //xuyaotianjialajidaimadifang-3222//
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont systemFontOfSize:14]; //xuyaotianjialajidaimadifang-3223//
    CGSize size = [SHRS_Tools getTextSizeWithTool:title withWidth:view.width - 40]; //xuyaotianjialajidaimadifang-3224//
    if (size.height > 20 ) {// 文字已换行
        textLabel.frame = CGRectMake(0, 0, view.height - 20, size.height + 20); //xuyaotianjialajidaimadifang-3225//
    }else {
        textLabel.frame = CGRectMake(0, 0, size.width, 40); //xuyaotianjialajidaimadifang-3226//
    }
    textLabel.text = title;
    textLabel.numberOfLines = NSIntegerMax; //xuyaotianjialajidaimadifang-3227//
    mbpHUd.customView  = textLabel;
    [mbpHUd hide:YES afterDelay:2.5]; //xuyaotianjialajidaimadifang-3228//

}
//tianjialajifangfa-860//
+ (void)hiddenProgressHud{ //xuyaotianjialajidaimadifang-3229//
    mbpHUd.removeFromSuperViewOnHide = YES;
    [mbpHUd hide:YES]; //xuyaotianjialajidaimadifang-3230//
}
//tianjialajifangfa-861//
+ (void)showProgressHudAlertTitle:(NSString *)title andLeftTitle:(NSString *)leftStr andRightTitle:(NSString *)rightStr andView:(UIView *)view andClickLeft:(LeftBtnAction)clickLeft andClickRight:(RightBtnAction)clickRight{
    maskView = [[UIView alloc]init]; //xuyaotianjialajidaimadifang-3231//
    maskView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
    [view addSubview:maskView]; //xuyaotianjialajidaimadifang-3232//
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(view.mas_width);//(283 *[SHRS_Tools asd_getIphoneScreenWidthScale]);
        make.height.mas_equalTo(view.mas_height);//(141 *[SHRS_Tools asd_getIphoneScreenWidthScale]);
        make.centerX.mas_equalTo(view.mas_centerX);
        make.centerY.mas_equalTo(view.mas_centerY); //xuyaotianjialajidaimadifang-3233//
    }];
    
    UIView *contentV = [[UIView alloc]init]; //xuyaotianjialajidaimadifang-3234//
    contentV.backgroundColor = [UIColor whiteColor];
    contentV.layer.cornerRadius = 2.5; //xuyaotianjialajidaimadifang-3235//
    contentV.layer.masksToBounds = YES;
    [maskView addSubview:contentV]; //xuyaotianjialajidaimadifang-3236//
    [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(283 *[SHRS_Tools getIphoneScreenWidthScaleWithTool]); //xuyaotianjialajidaimadifang-3237//
        make.height.mas_equalTo(141 *[SHRS_Tools getIphoneScreenWidthScaleWithTool]);
        make.centerX.mas_equalTo(view.mas_centerX); //xuyaotianjialajidaimadifang-3238//
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    
    UIView *bottomV = [[UIView alloc]init]; //xuyaotianjialajidaimadifang-3239//
    [contentV addSubview:bottomV];
    [bottomV mas_makeConstraints:^(MASConstraintMaker *make) { //xuyaotianjialajidaimadifang-3240//
        make.width.mas_equalTo(contentV.mas_width);
        make.height.mas_equalTo(32 *[SHRS_Tools getIphoneScreenWidthScaleWithTool]); //xuyaotianjialajidaimadifang-3241//
        make.left.mas_equalTo(contentV.mas_left);
        make.bottom.mas_equalTo(contentV.mas_bottom); //xuyaotianjialajidaimadifang-3242//
    }];
    
    UIView *lineV = [[UIView alloc]init]; //xuyaotianjialajidaimadifang-3243//
    lineV.backgroundColor = SDK_COLOR_GRAY;
    [bottomV addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) { //xuyaotianjialajidaimadifang-3244//
        make.width.mas_equalTo(contentV.mas_width);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(bottomV.mas_top); //xuyaotianjialajidaimadifang-3245//
        make.left.mas_equalTo(bottomV.mas_left);
    }] ;
    
    SHRS_button *leftBtn = [[SHRS_button alloc]init]; //xuyaotianjialajidaimadifang-3246//
    [leftBtn setTitle:leftStr forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor getHexColor:@"444444"] forState:UIControlStateNormal]; //xuyaotianjialajidaimadifang-3247//
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    leftBtn.callbackblock = ^(SHRS_button *btn) { //xuyaotianjialajidaimadifang-3248//
        [maskView removeFromSuperview];
        clickLeft();
    };
    [bottomV addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) { //xuyaotianjialajidaimadifang-3249//
        make.width.mas_equalTo((283 *[SHRS_Tools getIphoneScreenWidthScaleWithTool] - 0.5)/2);
        make.height.mas_equalTo(bottomV.mas_height); //xuyaotianjialajidaimadifang-3250//
        make.top.mas_equalTo(bottomV.mas_top);
        make.left.mas_equalTo(bottomV.mas_left); //xuyaotianjialajidaimadifang-3251//
    }];
    
    UIView *midLineV = [[UIView alloc]init]; //xuyaotianjialajidaimadifang-3252//
    midLineV.backgroundColor = SDK_COLOR_GRAY;
    [bottomV addSubview:midLineV]; //xuyaotianjialajidaimadifang-3253//
    [midLineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0.5); //xuyaotianjialajidaimadifang-3254//
        make.height.mas_equalTo(bottomV.mas_height);
        make.top.mas_equalTo(bottomV.mas_top); //xuyaotianjialajidaimadifang-3255//
        make.left.mas_equalTo(leftBtn.mas_right);
    }] ;
    
    SHRS_button *rightBtn = [[SHRS_button alloc]init]; //xuyaotianjialajidaimadifang-3256//
    [rightBtn addTheButtonTapBlock:^(SHRS_button *btn) {
        [maskView removeFromSuperview]; //xuyaotianjialajidaimadifang-3257//
        clickRight();
    }];
  
  
    [rightBtn setTitle:rightStr forState:UIControlStateNormal]; //xuyaotianjialajidaimadifang-3258//
    [rightBtn setTitleColor:[UIColor getHexColor:@"1296db"] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:12]; //xuyaotianjialajidaimadifang-3259//
    [bottomV addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) { //xuyaotianjialajidaimadifang-3260//
        make.width.mas_equalTo(leftBtn.mas_width);
        make.height.mas_equalTo(bottomV.mas_height); //xuyaotianjialajidaimadifang-3261//
        make.top.mas_equalTo(bottomV.mas_top);
        make.right.mas_equalTo(bottomV.mas_right); //xuyaotianjialajidaimadifang-3262//
    }];
    
    
    UIView *topV = [[UIView alloc]init]; //xuyaotianjialajidaimadifang-3263//
    [contentV addSubview:topV];
    [topV mas_makeConstraints:^(MASConstraintMaker *make) { //xuyaotianjialajidaimadifang-3264//
        make.width.mas_equalTo(contentV.mas_width);
        make.height.mas_equalTo(109 *[SHRS_Tools getIphoneScreenWidthScaleWithTool]); //xuyaotianjialajidaimadifang-3265//
        make.left.mas_equalTo(contentV.mas_left);
        make.top.mas_equalTo(contentV.mas_top); //xuyaotianjialajidaimadifang-3266//
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init]; //xuyaotianjialajidaimadifang-3267//
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor = [UIColor getHexColor:@"444444"]; //xuyaotianjialajidaimadifang-3268//
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = NSIntegerMax; //xuyaotianjialajidaimadifang-3269//
    [topV addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) { //xuyaotianjialajidaimadifang-3270//
        make.left.mas_equalTo(topV.mas_left).offset(20);
        make.top.mas_equalTo(topV.mas_top).offset(10); //xuyaotianjialajidaimadifang-3271//
        make.right.mas_equalTo(topV.mas_right).offset(-20);
        make.bottom.mas_equalTo(topV.mas_bottom).offset(-10); //xuyaotianjialajidaimadifang-3272//
    }];
}
//tianjialajifangfa-862//

@end
