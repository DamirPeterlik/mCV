//
//  APILayer.h
//  mCV
//
//  Created by Damir Peterlik on 25/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "Helper.h"

@interface APILayer : NSObject

+(void)registerUserWithUserName:(NSString *)userName
                      withemail:(NSString*)email
                    andPassword:(NSString*)password
                     withSucces:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                     andFailure:(void (^)(NSError *error))failure;

+(void)loginUserWithUserName:(NSString *)userName
                 andPassword:(NSString*)password
                  withSucces:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  andFailure:(void (^)(NSError *error))failure;

@end
