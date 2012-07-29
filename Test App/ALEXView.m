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
	}
	
	return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	NSColor* startingColor = [NSColor redColor];
	NSColor* endingColor = [NSColor blueColor];
	NSGradient* gradient = [[NSGradient alloc] initWithStartingColor:startingColor
														  endingColor:endingColor];
	
	[gradient drawInRect:self.bounds angle:-90.];
}

@end
