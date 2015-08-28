//
//  Helper.m
//  mCV
//
//  Created by Damir Peterlik on 25/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//


#import "Helper.h"

@implementation Helper

#pragma mark - PlistHelper

-(NSMutableArray*) ReadArrayFromPlist {
    NSString *appPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"mCV.plist"];
    NSMutableArray *coolArray = [NSMutableArray arrayWithContentsOfFile:appPath];
    return coolArray;
}

+(NSString *)getValueFromPlistForKey:(NSString *)key
{
    //NSString *path = [[NSBundle mainBundle] pathForResource:kDefaultConfigFile ofType:@"plist"];
    NSString *appPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"mCV.plist"];
    
    //[NSDictionary dictionaryWithContentsOfFile:appPath];
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:appPath];
    
    NSString *value = [dict objectForKey:key];
    
    return value;
}


#pragma mark - AlertView

+(UIAlertController*)returnAlerViewWithTitle:(NSString*)title
                                 withMessage:(NSString*)message
                               withOKhandler:(void(^)(UIAlertAction * action))okHandler
                            andCancelHandler:(void(^)(UIAlertAction * action))cancelHadler
{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:(okHandler!=nil ? okHandler : ^(UIAlertAction * action)
                                  {
                                      [alert dismissViewControllerAnimated:YES completion:nil];
                                      
                                  })];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:(cancelHadler!=nil ? cancelHadler :^(UIAlertAction * action)
                                      {
                                          [alert dismissViewControllerAnimated:YES completion:nil];
                                          
                                      })];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    return  alert;
}

+(UIAlertController*)returnAlerViewWithTitle:(NSString*)title
                                 withMessage:(NSString*)message
                               withOKhandler:(void(^)(UIAlertAction * action))okHandler

{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:(okHandler!=nil ? okHandler : ^(UIAlertAction * action)
                                  {
                                      [alert dismissViewControllerAnimated:YES completion:nil];
                                      
                                  })];
    
    
    [alert addAction:ok];
    
    
    return  alert;
}

@end

