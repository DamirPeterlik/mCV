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

//----kasnije ih punim....

@property (nonatomic,strong) NSString *userForeName;

//vazno je da ih ima u bazu, pa da ih moze pronaci, ako ih prazne pronađe radi, ali ako npr ne pronađe u tablici korisnika stupac userForeName, nista ne radi

@end
