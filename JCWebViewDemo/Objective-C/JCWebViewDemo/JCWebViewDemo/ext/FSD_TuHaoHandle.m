
#import "FSD_TuHaoHandle.h"

@implementation FSD_TuHaoHandle
//苹果交易数据库路径，存储交易相关信息

//add method on this line-761//

+(NSString *)ServerPath
{
    //Add Garbage Func Here-703//
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];//Documents目录
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"FSD_SERVERID.plist"];
    NSLog(@"%@ %@",[SHRS_Tools Huoquzifuchu:@"serverOrderPath"],path);
    return path;
}

//add method on this line-762//

+(NSString *)TranPath
{
    //Add Garbage Func Here-704//
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];//Documents目录
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"FSD_TRANID.plist"];
    NSLog(@"%@ %@",[SHRS_Tools Huoquzifuchu:@"productIDPath"],path);
    return path;
}

//add method on this line-763//

+(NSArray *)ReadServerOrderIds
{
    //Add Garbage Func Here-705//
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[FSD_TuHaoHandle ServerPath]];
    NSLog(@"%@  --  %@",[SHRS_Tools Huoquzifuchu:@"readLocalOrder"],array);
    return array;
}

//add method on this line-764//

+(NSArray *)ReadTranIDs
{
    //Add Garbage Func Here-706//
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[FSD_TuHaoHandle TranPath]];
    NSLog(@"%@  --  %@",[SHRS_Tools Huoquzifuchu:@"readLocalOrder"],array);
    return array;
}

//add method on this line-765//

+(void)WriteServerOrderId:(NSString *)orderId
{
    //Add Garbage Func Here-707//
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[FSD_TuHaoHandle ServerPath]];
    NSMutableArray *result = [NSMutableArray arrayWithArray:array];
    for (NSString *string in result)
    {
        if ([string isEqualToString:orderId])
        {
            NSLog(@"%@ %@",[SHRS_Tools Huoquzifuchu:@"orderIDExist"],result);
            return;
        }
    }
    [result insertObject:orderId atIndex:0];
    if ([result count] == 4)
    {
        
        //Add Garbage Func Here-708//
        
        [result removeLastObject];
    }
    BOOL bl = [result writeToFile:[FSD_TuHaoHandle ServerPath] atomically:YES];
    if (bl)
    {
        //Add Garbage Func Here-709//
        
        NSLog(@"%@ %@",[SHRS_Tools Huoquzifuchu:@"writeOrderSuccess"],result);
    }
}

//add method on this line-766//

+(void)WriteTranId:(NSString *)tranId
{
    
    //Add Garbage Func Here-710//
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[FSD_TuHaoHandle TranPath]];
    NSMutableArray *result = [NSMutableArray arrayWithArray:array];
    for (NSString *string in array)
    {
        if ([string isEqualToString:tranId])
        {
            NSLog(@"%@ %@",[SHRS_Tools Huoquzifuchu:@"tranIDExist"],result);
            return;
        }
    }
    [result insertObject:tranId atIndex:0];
    
    //Add Garbage Func Here-711//
    
    if ([result count]>10)
    {
        [result removeLastObject];
    }
    
    //Add Garbage Func Here-712//
    
    BOOL bl = [result writeToFile:[FSD_TuHaoHandle TranPath] atomically:YES];
    if (bl)
    {
        NSLog(@"%@ %@",[SHRS_Tools Huoquzifuchu:@"writeTranSuccess"],result);
    }
}

//add method on this line-767//

+(void)deleServerOrderId:(NSString *)orderId
{
    
    //Add Garbage Func Here-713//
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[FSD_TuHaoHandle ServerPath]];
    NSMutableArray *result = [NSMutableArray arrayWithArray:array];
    [result removeObject:orderId];
    BOOL bl = [result writeToFile:[FSD_TuHaoHandle ServerPath] atomically:YES];
    if (bl)
    {
        NSLog(@"%@ %@",[SHRS_Tools Huoquzifuchu:@"deleteOrderSuccess"],result);
    }
}

//add method on this line-768//

+(BOOL)QueryTranid:(NSString *)tranId
{
    //Add Garbage Func Here-714//
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[FSD_TuHaoHandle TranPath]];
    for (NSString *string in array)
    {
        if ([string isEqualToString:tranId])
        {
            return YES;
        }
    }
    return NO;
}

//add method on this line-769//

+(void)deleTranId:(NSString *)tranId
{
    //Add Garbage Func Here-715//
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[FSD_TuHaoHandle TranPath]];
    NSMutableArray *result = [NSMutableArray arrayWithArray:array];
    [result removeObject:tranId];
    BOOL bl = [result writeToFile:[FSD_TuHaoHandle TranPath] atomically:YES];
    if (bl)
    {
        NSLog(@"%@ %@",[SHRS_Tools Huoquzifuchu:@"deleteTranSuccess"],result);
    }
}

//add method on this line-770//

@end
