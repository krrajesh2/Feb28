//
//  View.m
//  Feb28
//
//  Created by Rajesh Kandasamy on 2/28/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "View.h"

@implementation View

- (void) sliderValueChanged: (id) sender {
	UISlider *s = sender;

	NSLog(@"Slider value is: %g", slider.value);	
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(setNeedsDisplay) object:nil];

	[self performSelector: @selector(setNeedsDisplay) withObject: nil afterDelay: slider.value];

}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
		
		//Do not specify a size for the switch.
		//Let the switch assume its own natural size.
		mySwitch = [[UISwitch alloc] initWithFrame: CGRectZero];
		if (mySwitch == nil) {
			return nil;
		}
		
		//Call the valueChanged: method of the application delegate
		//when the value of the switch is changed.
		
		[mySwitch addTarget: [UIApplication sharedApplication].delegate
					 action: @selector(valueChanged:)
		   forControlEvents: UIControlEventValueChanged
		 ];
		
	
		mySwitch.center = CGPointMake(270, 425);
		
		mySwitch.on = YES;	//the default
		[self addSubview: mySwitch];
		
		

		CGRect r = CGRectMake(10,10, 310, 40);		
		label = [[UILabel alloc] initWithFrame: r];
		label.backgroundColor = [UIColor greenColor];
		label.text = @"Temporary Hold (in secs):  ";
		[self addSubview: label];		
		
		CGRect f = CGRectMake(210,10, 100, 50);
	
		
		slider = [[UISlider alloc] initWithFrame: f];
		slider.minimumValue = 1;
		slider.maximumValue = 5;
		slider.value = 1;
		slider.continuous = NO;	//default is YES	
		
		[slider addTarget:self
				   action: @selector(sliderValueChanged:)
		 forControlEvents: UIControlEventValueChanged
		 ];
		
		[self addSubview: slider];		
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
