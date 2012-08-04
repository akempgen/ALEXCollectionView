//
//	ALEXView.m
//	ALEXViews
//
//	Created by Alexander Kempgen on 02.12.11.
//	Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ALEXView.h"

@interface ALEXView ()


@end


@implementation ALEXView



- (id)initWithFrame:(NSRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		NSColor* startingColor = [NSColor redColor];
		NSColor* endingColor = [NSColor blueColor];
		NSGradient* gradient = [[NSGradient alloc] initWithStartingColor:startingColor
															 endingColor:endingColor];
		_gradient = gradient;
		_angle = -90.;
	}
	
	return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self)
	{
		NSColor* startingColor = [NSColor redColor];
		NSColor* endingColor = [NSColor blueColor];
		NSGradient* gradient = [[NSGradient alloc] initWithStartingColor:startingColor
															 endingColor:endingColor];
		_gradient = gradient;
		_angle = -90.;
	}
	
	return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
	if ( self.gradient )
		[self.gradient drawInRect:self.bounds angle:self.angle];
}

@end
