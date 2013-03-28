//
//  Feb28AppDelegate.h
//  Feb28
//
//  Created by Rajesh Kandasamy on 2/28/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class View;

@interface Feb28AppDelegate : UIResponder <UIApplicationDelegate>{
 	View *view;	
	UIWindow *_window;
}

- (void) valueChanged: (id) sender;

@property (strong, nonatomic) UIWindow *window;

@end
