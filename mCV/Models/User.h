//
//  User.h
//  mCV
//
//  Created by Damir Peterlik on 29/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import "JSONModel.h"

@interface User : JSONModel

@property (nonatomic,strong) NSString *userID;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *email;
//@property (nonatomic,strong) NSString *userForename;
//@property (nonatomic,strong) NSString *userSurname;


//@property (nonatomic,strong) NSString *password;
//@property (nonatomic,strong) NSString *imageLink;


@end
