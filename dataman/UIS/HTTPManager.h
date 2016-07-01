
#import <Foundation/Foundation.h>
@import CoreLocation;

typedef NS_ENUM(NSInteger, RequestMethodType){
    RequestMethodTypePost = 1,
    RequestMethodTypeGet = 2,
    RequestMethodTypeDelete = 3
};


@interface HTTPManager : NSObject


/**
 *  发送一个请求
 *
 *  @param methodType   请求方法
 *  @param url          请求路径
 *  @param params       请求参数
 *  @param success      请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure      请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+(void)requestWithMethod:(RequestMethodType)methodType
                     url:(NSString *)url
               parameter:(NSDictionary *)parameter
                   token:(NSString *)token
                 success:(void (^)(id response))success
                 failure:(void (^)(NSError *err))failure;


+ (void)login:(NSString *)name
       passwd:(NSString *)passwd
      success:(void (^)(id response))success
      failure:(void (^)(NSError *err))failure;

+ (void)getApp:(NSString *)id
            cid:(NSString *)cid
        success:(void (^)(id response))success
        failure:(void (^)(NSError *err))failure;

+ (void)getAppStatus:(NSString *)id
                 cid:(NSString *)cid
             success:(void (^)(id))success
             failure:(void (^)(NSError *))failure;

+ (void)getApps:(void (^)(id))success
        failure:(void (^)(NSError *))failure;

+ (void)getCategories:(void (^)(id))success failure:(void (^)(NSError *))failure;

+ (void)getStatus:(void (^)(id))success failure:(void (^)(NSError *))failure;
@end