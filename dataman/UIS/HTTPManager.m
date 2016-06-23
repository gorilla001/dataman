
#import "HTTPManager.h"
#import "Lockbox.h"

static NSString *const BASE_URL = @"http://devforward.dataman-inc.net";

@implementation HTTPManager

+ (void)requestWithMethod:(RequestMethodType)methodType url:(NSString *)url parameter:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    
    manager.requestSerializer.timeoutInterval = 10;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    
    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", [Lockbox unarchiveObjectForKey:@"token"]] forHTTPHeaderField:@"Authorization"];
    manager.operationQueue.maxConcurrentOperationCount = 5;
    
    switch (methodType) {
        case RequestMethodTypeGet:
        {
            //GET请求
            [manager GET:url parameters:parameter
                 success:^(AFHTTPRequestOperation* operation, NSDictionary* responseObj) {
                     if (success) {
                    
                         success(responseObj);
                    }
                 } failure:^(AFHTTPRequestOperation* operation, NSError* error) {
                     if (failure) {
                         failure(error);
                     }
                 }];
            
        }
            break;
        case RequestMethodTypePost:
        {
            //POST请求
            [manager POST:url parameters:parameter
                  success:^(AFHTTPRequestOperation* operation, NSDictionary* responseObj) {
                      if (success) {
                          [EWUtils saveCookies];
                          success(responseObj);
                          
                          if ([responseObj[@"errcode"] integerValue] == 403|| 2001==[responseObj[@"errcode"] integerValue]) {
                              //处理403的问题
                              POSTNOTIFICATION(@"ERROR403", nil);

                          }

                      }
                  } failure:^(AFHTTPRequestOperation* operation, NSError* error) {
                      if (failure) {
                          failure(error);
                      }
                  }];
        }
            break;
        case RequestMethodTypeDelete:
        {
            [manager DELETE:url parameters:parameter
                  success:^(AFHTTPRequestOperation* operation, NSDictionary* responseObj) {
                      if (success) {
                          [EWUtils saveCookies];
                          success(responseObj);
                          
                          if ([responseObj[@"errcode"] integerValue] == 403|| 2001==[responseObj[@"errcode"] integerValue]) {
                              //处理403的问题
                              POSTNOTIFICATION(@"ERROR403", nil);
                              
                          }
                          
                      }
                  } failure:^(AFHTTPRequestOperation* operation, NSError* error) {
                      if (failure) {
                          failure(error);
                      }
                  }];
        }
        default:
            break;
    }
    
}


+ (void)login:(NSString *)name
         passwd:(NSString *)passwd
      success:(void (^)(id response))success
      failure:(void (^)(NSError *err))failure
{
    NSDictionary *parameter;
    parameter = @{@"name":name,@"password":passwd};
    

    [HTTPManager requestWithMethod:RequestMethodTypePost
                               url:@"/api/v3/auth"
                         parameter:parameter
                           success:success
                           failure:failure];
}

+ (void)getApps:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [HTTPManager requestWithMethod:RequestMethodTypeGet
                               url:@"/api/v3/apps"
                         parameter:nil
                           success:success
                           failure:failure];
}

+ (void)getCategories:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [HTTPManager requestWithMethod:RequestMethodTypeGet
                               url:@"/api/v3/repositories"
                         parameter:nil
                           success:success
                           failure:failure];
}

@end
