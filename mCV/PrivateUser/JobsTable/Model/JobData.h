//
//  JobData.h
//  mCV
//
//  Created by Damir Peterlik on 30/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import "JSONModel.h"

@interface JobData : JSONModel

@property (nonatomic,strong) NSString *jobDetail;
@property (nonatomic,strong) NSString *jobGroup;
@property (nonatomic,strong) NSString *jobLocation;
@property (nonatomic,strong) NSString *jobTitle;
@property (nonatomic,strong) NSString *latitude;
@property (nonatomic,strong) NSString *longitude;
@property (nonatomic,strong) NSString *jobUrl;

@end
