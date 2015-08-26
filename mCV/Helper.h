//
//  Helper.h
//  mCV
//
//  Created by Damir Peterlik on 25/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Helper : NSObject


/*
 +(void) showAlertWithMessage:(NSString*)message;
 */

/**
 * Returns the value for the given key from the default configuration file mCV.plist.
 * @author Damir Peterlik
 *
 * @param key The key from the confgiuration file.
 * @return The value.
 */
+(NSString *)getValueFromPlistForKey:(NSString *)key;

/**
 * Returns a new UIAlertController with an OK and Cancel action.
 * @author Damir Peterlik
 *
 * @param title The alert title.
 * @param message The messeg of the UIAlert.
 * @param okHandler The code bolck for the OK action. If the parameter is nil the action will just dissmis the view.
 * @param okHandler The code bolck for the Cancel action.If the parameter is nil the action will just dissmis the view.
 * @return A newly created UIAlertController instance
 */
+(UIAlertController*)returnAlerViewWithTitle:(NSString*)title
                                 withMessage:(NSString*)message
                               withOKhandler:(void(^)(UIAlertAction * action))okHandler
                            andCancelHandler:(void(^)(UIAlertAction * action))cancelHadler;

+(UIAlertController*)returnAlerViewWithTitle:(NSString*)title
                                 withMessage:(NSString*)message
                               withOKhandler:(void(^)(UIAlertAction * action))okHandler;

@end
