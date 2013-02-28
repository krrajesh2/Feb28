//
//  View.m
//  Feb28
//
//  Created by Rajesh Kandasamy on 2/28/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "View.h"

@implementation View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void) drawRect: (CGRect) rect {
	
	CGSize size = self.bounds.size;
	CGFloat min = MIN(size.width, size.height);
	CGFloat longSide = min * 15 / 16;
	CGFloat shortSide = longSide / 25;
	
	
	
	UIImage *image = [UIImage imageNamed: @"oscar.jpg"];	
	if (image == nil) {
		NSLog(@"could not find the image");
		return;
	}
	
	//upper left corner of image
	CGPoint point = CGPointMake(75, 150);
	//draw image
	[image drawAtPoint: point];
	
	
	CGContextRef c = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(c, size.width / 2, size.height / 2); //origin at center of view
	CGContextScaleCTM(c, 1, -1);                               //make Y axis point up	
	
	
	CGRect bounds = self.bounds;
    CGFloat radius = .1 * bounds.size.width;
    
    CGRect r = CGRectMake(
						  bounds.origin.x-120,
						  bounds.origin.y-50,
						  2 * radius,
						  2 * radius
						  );
    
	int i = -rand()%90; //used to decide which color to draw
	
	//draw head
	CGContextBeginPath(c); //unnecessary here: the path is already empty.
    CGContextAddEllipseInRect(c, r);
	if (i < -14){
		
    	CGContextSetRGBStrokeColor(c, 0.0, 1.0, 0.0, 1.0);
		
	} else {
		CGFloat dashes[] = {4,4,8};
		CGContextSetLineDash(c, 3, dashes, 3);		
		CGContextSetRGBStrokeColor(c, 1.0, 0.0, 0.0, 1.0);
	}
	CGContextSetLineWidth(c, 3.0);
    CGContextStrokePath(c);
	
	//draw body
    r = CGRectMake( -120, -150, 65, 100);
	
	CGContextBeginPath(c);
    CGContextAddRect(c, r);
	if (i < -14){
    	CGContextSetRGBStrokeColor(c, 0.0, 1.0, 0.0, 1.0);
	} else {
		CGContextSetRGBStrokeColor(c, 1.0, 0.0, 0.0, 1.0);
	}
	CGContextSetLineWidth(c, 3.0);
    CGContextStrokePath(c);	
	
	//draw moving bar
	CGContextBeginPath(c);
	CGRect horizontal = CGRectMake(-longSide / 2, -shortSide / 2, longSide, shortSide);
	CGContextRotateCTM(c, i * M_PI / 180.0);
	CGContextAddRect(c, horizontal);
	CGContextSetRGBFillColor(c, 0.2, 0.2, 0.2, 0.8);
	CGContextFillPath(c);
	
	
	[self performSelector: @selector(setNeedsDisplay) withObject: nil afterDelay: 0.5];
	
}

@end
