//
//  Configuration.m
//  mCV
//
//  Created by Damir Peterlik on 29/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import "Configuration.h"

@implementation Configuration

+(instancetype)sharedConfiguration
{
    static Configuration *configuration;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configuration = [[Configuration alloc]init];
    });
    return  configuration;
}
@end
