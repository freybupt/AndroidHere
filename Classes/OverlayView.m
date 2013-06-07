//
//  OverlayView.m
//  OverlayViewTester
//
//  Created by Jason Job on 09-12-10.
//  Copyright 2009 Jason Job. All rights reserved.
//

#import "OverlayView.h"


@implementation OverlayView


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		// Clear the background of the overlay:
		self.opaque = NO;
		self.backgroundColor = [UIColor clearColor];
		
        UILabel *scanningLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 50, 180, 30)];
        scanningLabel.backgroundColor = [UIColor clearColor];
        scanningLabel.font = [UIFont fontWithName:@"Courier" size: 18.0];
        scanningLabel.textColor = [UIColor redColor]; 
        scanningLabel.text = @"Loading Android...";
        
        [self addSubview:scanningLabel];
        
        [self performSelector:@selector(clearLabel:) withObject:scanningLabel afterDelay:2];
        
        [scanningLabel release];
        
		// Load the image to show in the overlay:
		UIImage *overlayGraphic = [UIImage imageNamed:@"android.png"];
		UIImageView *overlayGraphicView = [[UIImageView alloc] initWithImage:overlayGraphic];
		overlayGraphicView.frame = CGRectMake(120, 150, 100, 100);
		[self addSubview:overlayGraphicView];
		[overlayGraphicView release];
		
    }
    return self;
}



- (void)clearLabel:(UILabel *)label {
	label.text = @"";
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)dealloc {
    [super dealloc];
}


@end
