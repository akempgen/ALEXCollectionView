//
//  ALEXCollectionView.m
//  ALEXCollectionView
//
//  Created by Alexander Kempgen on 25.07.12.
//  Copyright (c) 2012 Alexander Kempgen. All rights reserved.
//

#import "ALEXCollectionView.h"

@interface ALEXCollectionView ()

@property (strong) NSMutableDictionary *archivedPrototypeViews;

@end


@implementation ALEXCollectionView


-(id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self)
	{
		
		_archivedPrototypeViews = [NSMutableDictionary dictionaryWithCapacity:self.subviews.count];
		for (NSView *view in [self.subviews copy])
		{
			_archivedPrototypeViews[view.identifier] = [NSKeyedArchiver archivedDataWithRootObject:view];
			[view removeFromSuperviewWithoutNeedingDisplay];
		}
	}
	return self;
}


- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}





-(id)makeViewWithIdentifier:(NSString *)identifier owner:(id)owner
{
	// assert identifier
	// assert identifier in self.prototypeViews.allKeys
	
	NSView *view;

	// get view for reuse from m dict of m arrays
	
	if (!view)
	{
		view = [NSKeyedUnarchiver unarchiveObjectWithData:self.archivedPrototypeViews[identifier]];
	}
//		view = [self.prototypeViews[identifier] copy];
	
	return view;
}

-(void)reloadData
{
	NSMutableArray *views = [NSMutableArray array];
	
	
	NSInteger numberOfSections = [self.dataSource numberOfSectionsInCollectionView:self];
	
	for (NSInteger sectionIndex = 0; sectionIndex < numberOfSections; sectionIndex++)
	{
		NSView *sectionView = [self.dataSource collectionView:self viewForSupplementaryElementOfKind:nil atIndexPath:[NSIndexPath indexPathWithIndex:sectionIndex]];
		[views addObject:sectionView];
		
		
		NSInteger numberOfItems = [self.dataSource collectionView:self numberOfItemsInSection:sectionIndex];
		
		for (NSInteger itemIndex = 0; itemIndex < numberOfItems; itemIndex++)
		{
			NSView *itemView = [self.dataSource collectionView:self viewForItemAtIndexPath:[NSIndexPath indexPathWithIndex:itemIndex]];
			[views addObject:itemView];
		}
	}
	
	CGFloat height = 2 * self.bounds.size.height / [views count];
	NSRect superFrame = NSMakeRect(0., 0., self.frame.size.width, height * [views count]);
	self.frame = superFrame;
	
	for (NSView *view in views)
	{
		NSRect frame = NSMakeRect(0., [views indexOfObject:view] * height, self.bounds.size.width, height);
		[view setFrame:frame];
		[self addSubview:view];
	}
	
	[self setNeedsDisplay:YES];
}


@end
