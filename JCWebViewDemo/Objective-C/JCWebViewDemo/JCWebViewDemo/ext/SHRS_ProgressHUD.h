//
//  SHRS_ProgressHUD.h
//  UUUKK
//
//  Created by JOJO on 2018/03/12.
//

#import <Foundation/Foundation.h>
typedef void (^LeftBtnAction)(void);
typedef void (^RightBtnAction)(void);
@interface SHRS_ProgressHUD : NSObject
+ (void)showProgressHudLoading:(NSString *)title andView:(UIView *)view;
+ (void)showProgressHudTitle:(NSString *)title andView:(UIView *)view;
+ (void)hiddenProgressHud;
+ (void)showProgressHudAlertTitle:(NSString *)title andLeftTitle:(NSString *)leftStr andRightTitle:(NSString *)rightStr andView:(UIView *)view andClickLeft:(LeftBtnAction)clickLeft andClickRight:(RightBtnAction)clickRight;

@end
