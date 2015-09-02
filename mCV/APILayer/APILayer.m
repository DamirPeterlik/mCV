//
//  APILayer.m
//  mCV
//
//  Created by Damir Peterlik on 25/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import "APILayer.h"
#import <AFNetworking/AFNetworking.h>
#import "Constants.h"

@implementation APILayer

+(void)registerUserWithUserName:(NSString *)userName
                      withemail:(NSString*)email
                    andPassword:(NSString*)password
                     withSucces:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                     andFailure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [Helper getValueFromPlistForKey:kConfigAPIRegisterURL];
    NSString *stringUrl = [NSString stringWithFormat:url,userName,email,password];
    
    NSString *encoded = [stringUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:encoded
       parameters:nil
          success:success
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              failure(error);
          }];
}

+(void)loginUserWithUserName:(NSString *)userName
                 andPassword:(NSString*)password
                  withSucces:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  andFailure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [Helper getValueFromPlistForKey:kConfigAPILoginURL];
    NSString *stringUrl = [NSString stringWithFormat:url,userName,password];
    
    NSString *encoded = [stringUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:encoded
       parameters:nil success:success
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              failure(error);
          }];
}

+(void)getImageWithUserID:(NSString *)userID
               withSucces:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               andFailure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *url = [Helper getValueFromPlistForKey:kConfigAPIGetImgURL];
    NSString *stringUrl = [NSString stringWithFormat:url,userID];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:stringUrl parameters:nil
          success:success
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              failure(error);
          }];
    
    //http://probaairmcv.site40.net/mCV/userImages/0mcvGetUserImg.php
}

+(void)getJobsWithjobUrl:(NSString *)jobUrl
              withSucces:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              andFailure:(void (^)(NSError *error))failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *url = [Helper getValueFromPlistForKey:kConfigAPIGetJobsURL];
    //NSString *stringUrl = [NSString stringWithFormat:url,jobUrl];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:url
       parameters:nil
          success:success
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              failure(error);
          }];
    
}

+(void)updateUserWithUserID:(NSString *)userID
            withUserForName:(NSString *)userForName
                withSurName:(NSString *)userSurName
                  withemail:(NSString *)email
              withProfesion:(NSString *)profesion
                andLocation:(NSString *)location
                 withSucces:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 andFailure:(void (^)(NSError *error))failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [Helper getValueFromPlistForKey:kConfigAPIUpdateUserURL];
    NSString *stringUrl = [NSString stringWithFormat:url,userID, userForName, userSurName, email, profesion, location];
    
    NSString *encoded = [stringUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:encoded
       parameters:nil
          success:success
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              failure(error);
          }];
    
}

@end

/*
 
 // NSString *url = @"http://probaairmcv.site40.net/mCV/new1.php?email=%@&userName=%@&password=%@";
 
 prouciti drugi nacin
 
 NSDictionary *parameters = @{@"userName":userName,
 @"email":email,
 @"password":password};
 
 NSString *apiUrlPart = @"http://probaairmcv.site40.net/mCV/new1.php";
 */