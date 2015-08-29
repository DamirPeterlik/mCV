//
//  User.m
//  mCV
//
//  Created by Damir Peterlik on 29/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import "User.h"

@implementation User

+(JSONKeyMapper*)keyMapper
{
    /*
    NSDictionary *mapDict = @{@"email":@"email",
                              @"imageLink":@"imageLink",
                               @"password":@"password",
                                @"userID":@"userID",
                                 @"userName":@"userName"};
    
    JSONKeyMapper *mapper = [[JSONKeyMapper alloc]initWithDictionary:mapDict];
    
    return mapper;
    */
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"email": @"",
                                                        @"userID": @"",
                                                         @"userName": @"",
                                                          @"userForename": @""}];
}

@end
