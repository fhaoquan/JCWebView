

#import <Foundation/Foundation.h>

@interface FSD_TuHaoHandle : NSObject

+(NSArray *)ReadServerOrderIds; //读取订单id
+(NSArray *)ReadTranIDs; //读取产品id
+(void)WriteServerOrderId:(NSString *)orderId; //写入订单id
+(void)WriteTranId:(NSString *)tranId; //写入产品id
+(void)deleServerOrderId:(NSString *)orderId;
+(void)deleTranId:(NSString *)tranId;
+(BOOL)QueryTranid:(NSString *)tranId;

@end
