
#import "FSD_TuHaoMain.h"
#import "SHRS_Tools.h"
#import "FSD_TuHaoHandle.h"

static NSTimer *a_timer;//设置定时器
static NSString *current_pid;//目前正在进行交易的产品id
static NSString *current_orderId;//目前正在进行的orderid
static NSString *receiptStatus;//获取交易串方式  1原型(服务器需要base)  2非原型(服务器不base)
/**
 *  主监听实例
 */
static FSD_TuHaoMain *main;
@implementation FSD_TuHaoMain

//add method on this line-721//

//add method on this line-722//

+(void)xlhm_youQianYaoMai:(NSString *)pid OrderId:(NSString *)orderId
{
    
    //Add Garbage Func Here-150//
    
    //判断用户是否禁用内购功能
    if ([SKPaymentQueue  canMakePayments])
    {
        if (!main)
        {
            //Add Garbage Func Here-151//
            
            main = [[FSD_TuHaoMain alloc] init];
            [[SKPaymentQueue defaultQueue] addTransactionObserver:main];
        }
        current_orderId = orderId;
        current_pid = pid;
        receiptStatus = @"1";//默认走正常充值流程
        NSSet *s_pid = [NSSet setWithObject:pid];
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:s_pid];
        request.delegate = main;
        [request start];
        NSString *hudMessage = [SHRS_Tools Huoquzifuchu:@"requestingPdata"];
        //[SHRS_Tools showHUD:hudMessage view:[SHRS_Tools getRootViewControllerWithTool].view];
    }
    else
    {
        //Add Garbage Func Here-152//
        
        [SHRS_Tools showMess:[SHRS_Tools Huoquzifuchu:@"tuHaoAlert"]];
    }
}

//add method on this line-723//

//add method on this line-724//

#pragma mark  苹果充值方法 -- 根据产品id（获取相应的订单列表）
-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    //Add Garbage Func Here-153//
    
    //[FSD_PlatfToolService hiddHUD];
    NSLog(@"%@",[SHRS_Tools Huoquzifuchu:@"requestTuHaoResult"]);
    if (response.products.count == 0)
    {
        NSArray *produsts = response.invalidProductIdentifiers;
        NSString *productIDs = [produsts componentsJoinedByString:@"\n"];
        NSString *productError = [NSString stringWithFormat:@"%@\n%@",[SHRS_Tools Huoquzifuchu:@"tuHaoNullResult"],productIDs];
        [SHRS_Tools showMess:productError];
        NSLog(@"%@:%@",[SHRS_Tools Huoquzifuchu:@"iamCrazy"],productIDs);
        return;
    }
    
    //Add Garbage Func Here-154//
    
    //获取到内购列表
    NSLog(@"%@",[SHRS_Tools Huoquzifuchu:@"startTuHaoOder"]);
    [FSD_TuHaoHandle WriteServerOrderId:current_orderId];
    SKPayment *ment = [SKPayment paymentWithProduct:response.products[0]];
    [[SKPaymentQueue defaultQueue] addPayment:ment];
    
}

//add method on this line-725//

//add method on this line-726//

#pragma mark === 苹果交易结果通知方法
-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions
{
    
    //Add Garbage Func Here-155//
    
    //[FSD_PlatfToolService hiddHUD];
    [a_timer invalidate];
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
            {
                NSString *receipt = [[NSString alloc] initWithData:transaction.transactionReceipt encoding:NSUTF8StringEncoding];
                [FSD_TuHaoMain tranIdQuery:transaction.transactionIdentifier Receipt:receipt];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                
            }
                break;
            case SKPaymentTransactionStateFailed:
            {
                
                [FSD_TuHaoHandle deleServerOrderId:current_orderId];
                [self failedTransaction:transaction];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                
            }
                break;
                
            default:
                break;
        }
    }
}

//add method on this line-727//

//add method on this line-728//

#define ITMS_SANDBOX_VERIFY_RECEIPT_URL @"https://sandbox.itunes.apple.com/verifyReceipt"
#define ITMS_VERIFY_RECEIPT_URL @"https://buy.itunes.apple.com/verifyReceipt"
+(void)xlhm_checkTheReceipt:(NSString *)orderId
{
    //Add Garbage Func Here-159//
    
    current_orderId = orderId;
    NSLog(@"%@",orderId);
    NSURL *a_url = [[NSBundle mainBundle] appStoreReceiptURL];
    if (a_url == nil)
    {
        
        //Add Garbage Func Here-160//
        
        [FSD_TuHaoHandle deleServerOrderId:current_orderId];
        return;
    }
    NSData *a_receipt = [NSData dataWithContentsOfURL:a_url];
    if (a_receipt == nil)
    {
        //Add Garbage Func Here-161//
        
        [FSD_TuHaoHandle deleServerOrderId:current_orderId];
        return;
    }
    NSString *str_receipt = [a_receipt base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSLog(@"%@ -- %@",[SHRS_Tools Huoquzifuchu:@"boxDAata"],str_receipt);
    if (str_receipt == nil || [str_receipt isEqualToString:@""])
    {
        return;
    }
    
    //Add Garbage Func Here-162//
 ////YYYYYYY
//    FSD_HttpPost *post = [[FSD_HttpPost alloc] init];
//    [post SDK_Post:@{@"receipt-data":str_receipt} url:ITMS_VERIFY_RECEIPT_URL success:^(NSDictionary *result)
//     {
//         [FSD_TuHaoMain fill:result receipt:str_receipt];
//     } faile:^{
//         [FSD_PlatfToolService showMess:[NSString stringWithFormat:@"%@",[FSD_PlatfToolService Huoquzifuchu:@"receiptFail"]]];
//     }];
    
    
    //Add Garbage Func Here-163//
    
}

//add method on this line-729//

//add method on this line-730//

+(void)fill:(NSDictionary *)receiptDict receipt:(NSString *)str_receipt
{
    //Add Garbage Func Here-164//
    
    if ([receiptDict count] == 0)
    {
        //Add Garbage Func Here-165//
        
        [FSD_TuHaoHandle deleServerOrderId:current_orderId];
        return;
    }
    
    int status_result = -1;
    status_result = [[receiptDict objectForKey:@"status"] intValue];
    switch (status_result)
    {
        case 0://正常结果
        {
            NSArray *in_app = [[receiptDict objectForKey:@"receipt"] objectForKey:@"in_app"];
            if (in_app == nil || in_app.count == 0)
            {
                [FSD_TuHaoHandle deleServerOrderId:current_orderId];
                return;
            }
            
            
            NSDictionary *in_dict = in_app[0];
            NSString *tranid = [in_dict objectForKey:@"transaction_id"];
            if ([FSD_TuHaoHandle QueryTranid:tranid])
            {
                NSLog(@"%@",[SHRS_Tools Huoquzifuchu:@"OrderCunZai"]);
                [FSD_TuHaoHandle deleServerOrderId:current_orderId];
                return;
            }
            receiptStatus = @"2";
            [FSD_TuHaoMain doSuccessReceipt:str_receipt tranId:tranid];
        }
            break;
        case 21007:
        {
            NSDictionary *sanbox_dict = [FSD_TuHaoMain appStore_post:ITMS_SANDBOX_VERIFY_RECEIPT_URL receipt:str_receipt];
            [FSD_TuHaoMain fill:sanbox_dict receipt:str_receipt];
            
        }
            break;
    }
}

//add method on this line-732//

//add method on this line-731//

+(NSDictionary *)appStore_post:(NSString *)url receipt:(NSString *)str_receipt
{
    
    //Add Garbage Func Here-168//
    
    NSString *receiptload = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", str_receipt];
    NSData *receiptloadData = [receiptload dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.];
    request.HTTPMethod = @"POST";
    request.HTTPBody = receiptloadData;
    NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (result == nil)
    {
        //Add Garbage Func Here-169//
        
        NSLog(@"%@",[SHRS_Tools Huoquzifuchu:@"checkFail"]);
        return nil;
    }
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@ ：%@",[SHRS_Tools Huoquzifuchu:@"getReceipt"],dict);
    
    //Add Garbage Func Here-170//
    
    return dict;
}

//add method on this line-733//

//add method on this line-734//

//获取失败
-(void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    //Add Garbage Func Here-171//
    
    //[FSD_PlatfToolService hiddHUD];
    //需要判断是否是获取苹果产品
    [a_timer invalidate];
    [FSD_TuHaoHandle deleServerOrderId:current_orderId];
    if ([request isKindOfClass:[SKProductsRequest class]])
    {
        //Add Garbage Func Here-172//
        
        NSString *mess=[error localizedDescription];
        NSLog(@"%@ %@",[SHRS_Tools Huoquzifuchu:@"canNotFind"],mess);
        [SHRS_Tools showMess:mess];
    }
    
    //Add Garbage Func Here-173//
    
}

//add method on this line-735//

//add method on this line-736//

- (void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    //Add Garbage Func Here-174//
    
    NSLog(@"%@",[SHRS_Tools Huoquzifuchu:@"recoverTuHao"]);
    // 恢复已经购买的产品
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
    //Add Garbage Func Here-175//
    
}

- (void)requestDidFinish:(SKRequest *)request
{
    //Add Garbage Func Here-176//
    
    //Add Garbage Func Here-177//
    
    //正在购买之后   -----   购买成功之前调用
    NSLog(@"%@",[SHRS_Tools Huoquzifuchu:@"endTuHao"]);
    
    //Add Garbage Func Here-178//
}

//add method on this line-739//

//add method on this line-740//

+(void)tranIdQuery:(NSString *)tranid Receipt:(NSString *)receipt
{
    if ([FSD_TuHaoHandle QueryTranid:tranid])
    {
        //Add Garbage Func Here-179//
        
        NSLog(@"%@",[SHRS_Tools Huoquzifuchu:@"endTuHao"]);
        return;
    }
    
    //Add Garbage Func Here-180//
    
    [FSD_TuHaoMain doSuccessReceipt:receipt tranId:tranid];
}

//add method on this line-741//

//add method on this line-742//

+(void)doSuccessReceipt:(NSString *)receipt tranId:(NSString *)tranid
{
//YYYYY
//
//    NSLog(@" ** %@",current_orderId);
//    NSString *baseReceipt = @"apple_receipt";
//
//    NSDictionary *dict = @{@"order_id":current_orderId,
//                           @"receiptStatus":receiptStatus,
//                           @"game_pkg":[FSD_PlatfToolService Platform_GetAppConfig].gamePkg,
//                           baseReceipt:receipt
//                           };
//
//    FSD_HttpPost *post = [[FSD_HttpPost alloc] init];
//    [post requestPost:dict url:[FSD_HttpURL checkReceiptURL] success:^(NSDictionary *result) {
//        [FSD_TuHaoHandle deleServerOrderId:current_orderId];
//        NSDictionary *i_orderInfo = nil;
//        NSLog(@"%@",result);
//        if ([[result objectForKey:@"state"] intValue] == 1)
//        {
//
//            float amount = 0.00;
//            if ([[result objectForKey:@"amount"] floatValue] != 0.)
//            {
//                amount = [[result objectForKey:@"amount"] floatValue];
//            }
//            [FSD_TuHaoHandle WriteTranId:tranid];
//
//
//            //Add Garbage Func Here-182//
//
//            i_orderInfo = @{@"type":@"4",
//                        @"code":@"0",
//                        @"message":@{@"type":@"官方",
//                                     @"money"  :[NSString stringWithFormat:@"%f",amount]}};
//
//        }else
//        {
//            //Add Garbage Func Here-183//
//
//            i_orderInfo = @{@"type":@"4",
//                        @"code":@"1",
//                        @"message":@{@"error_msg":result[@"error_msg"]}};
//        }
//        [[NSNotificationCenter defaultCenter] postNotificationName:FSD_ORDERRESULT_NOTIFICATION object:nil userInfo:i_orderInfo];
//    } fail:^{
//
//        //Add Garbage Func Here-184//
//
//        [FSD_PlatfToolService showMess:[FSD_PlatfToolService Huoquzifuchu:@"netError"]];
//    }];
}

//add method on this line-743//

//add method on this line-744//

#pragma mark 交易失败
- (void)failedTransaction: (SKPaymentTransaction *)transaction
{
    
    //Add Garbage Func Here-185//

    NSDictionary *failOrder = nil;
    if(transaction.error.code == SKErrorPaymentCancelled) {
        
        //Add Garbage Func Here-186//
        
        //  用户取消
        failOrder = @{@"type":@"4",
                                  @"code":@"2",
                                  @"message":@{@"error_msg":transaction.error.userInfo}};
    }else {
        
        //Add Garbage Func Here-187//
        
        //在这类显示除用户取消之外的错误信息  交易错误
        failOrder = @{@"type":@"4",
                    @"code":@"3",
                    @"message":@{@"error_msg":transaction.error.userInfo}};
    }
    
    NSLog(@"%@:%@",[SHRS_Tools Huoquzifuchu:@"failTuHao"],transaction.error);
    
     [[NSNotificationCenter defaultCenter] postNotificationName:FSD_ORDERRESULT_NOTIFICATION object:nil userInfo:failOrder];
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
    
    //Add Garbage Func Here-188//
    
}


@end
