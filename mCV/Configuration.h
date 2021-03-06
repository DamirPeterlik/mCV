//
//  Configuration.h
//  mCV
//
//  Created by Damir Peterlik on 29/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Configuration : NSObject

@property (nonatomic,strong) User *user;

+(instancetype)sharedConfiguration;

@end

//singleton design patern, ovdje punim podatke za korisnika jer ce mi trebati kroz cijeli app, npr ID korisnika, ime...