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
    
    NSString *url = @"http://probaairmcv.site40.net/mCV/new1.php?email=%@&userName=%@&password=%@";
    NSString *stringUrl = [NSString stringWithFormat:url,userName,email,password];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:stringUrl parameters:nil success:success
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              failure(error);
          }];
    
}

@end



/*
 prouciti drugi nacin
 
 NSDictionary *parameters = @{@"userName":userName,
 @"email":email,
 @"password":password};
 
 NSString *apiUrlPart = @"http://probaairmcv.site40.net/mCV/new1.php";
 */