//
//  SHRS_IAP.h
//  UUUKK
//
//  Created by  on 2018/03/12.
//

#import <Foundation/Foundation.h>

@interface SHRS_IAP : NSObject
/** 下单 */
+ (void)maiProductOnIap:(NSString *)productId andDingdanId:(NSString *)dingdanId;
/** 补单  */
+(void)appStoreReceiptOnIap:(NSString *)orderId;
+ (NSArray *)ReadServerOrderIdsIap;
+ (void)deleServerOrderIdOnIap:(NSString *)orderId;
@end
