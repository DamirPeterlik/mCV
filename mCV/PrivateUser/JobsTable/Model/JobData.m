//
//  JobData.m
//  mCV
//
//  Created by Damir Peterlik on 30/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import "JobData.h"

@implementation JobData

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
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"jobDetail": @"",
                                                       @"jobGroup": @"",
                                                       @"jobLocation": @"",
                                                       @"jobTitle": @"",
                                                       @"latitude": @"",
                                                       @"longitude": @""}];
}

@end
