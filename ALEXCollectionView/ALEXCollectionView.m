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
		
				
//		NSLog(@"init superview: %@", self.superview.constraints);
	}
	return self;
}


-(void)awakeFromNib
{
	[super awakeFromNib];
	
	[self ALEXCollectionView_prepareSelf];

//	NSLog(@"awake superview: %@", self.superview.constraints);

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
		//		NSLog(@"view: %@", view);
	}
	//		view = [self.prototypeViews[identifier] copy];
	
	return view;
}

-(void)reloadData
{
//	NSLog(@"1reload superview %@", self.superview.constraints);

	NSMutableArray *views = [NSMutableArray array];
	
	
	NSInteger numberOfSections = [self.dataSource numberOfSectionsInCollectionView:self];
	
	for (NSUInteger sectionIndex = 0; sectionIndex < numberOfSections; sectionIndex++)
	{
		NSIndexPath *sectionIndexPath = [NSIndexPath indexPathWithIndex:sectionIndex];
		NSView *sectionView = [self.dataSource collectionView:self viewForSupplementaryElementOfKind:nil atIndexPath:sectionIndexPath];
		sectionView.identifier = [sectionView.identifier stringByAppendingFormat:@"_%lu", sectionIndex];
		
		[views addObject:sectionView];
		
		
		NSInteger numberOfItems = [self.dataSource collectionView:self numberOfItemsInSection:sectionIndex];
		
		for (NSUInteger itemIndex = 0; itemIndex < numberOfItems; itemIndex++)
		{
			NSIndexPath *itemIndexPath = [sectionIndexPath indexPathByAddingIndex:itemIndex];
			NSView *itemView = [self.dataSource collectionView:self viewForItemAtIndexPath:itemIndexPath];
			itemView.identifier = [itemView.identifier stringByAppendingFormat:@"_%lu_%lu", sectionIndex, itemIndex];
			[views addObject:itemView];
		}
	}
	
//	NSView *flexibleSpaceView = [[NSView alloc] initWithFrame:NSMakeRect(0., 0., 200., 200.)];
//	flexibleSpaceView.identifier = @"bottomSpace";
//	[flexibleSpaceView setContentHuggingPriority:1 forOrientation:NSLayoutConstraintOrientationHorizontal];
//	[flexibleSpaceView setContentHuggingPriority:1 forOrientation:NSLayoutConstraintOrientationVertical];
//	[flexibleSpaceView setContentCompressionResistancePriority:1 forOrientation:NSLayoutConstraintOrientationHorizontal];
//	[flexibleSpaceView setContentCompressionResistancePriority:1 forOrientation:NSLayoutConstraintOrientationVertical];
//	[views addObject:flexibleSpaceView];
	
	
	[views enumerateObjectsUsingBlock:^(NSView *view, NSUInteger idx, BOOL *stop) {
//		[view setTranslatesAutoresizingMaskIntoConstraints:NO];
		[self addSubview:view];
	}];
	
	
	
	NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:views.count*10];
	
	
	
	
//	NSDictionary *flexibleSpaceViewDict = NSDictionaryOfVariableBindings(flexibleSpaceView);
//	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[flexibleSpaceView]-0-|" options:0 metrics:nil views:flexibleSpaceViewDict]];
	
	
	
	
	[views enumerateObjectsUsingBlock:^(NSView *view, NSUInteger idx, BOOL *stop) {
		
		//		NSLog(@"constraints: %@", [view constraintsAffectingLayoutForOrientation:NSLayoutConstraintOrientationHorizontal]);
		
		//		[view setContentHuggingPriority:1 forOrientation:NSLayoutConstraintOrientationHorizontal];
		
		NSDictionary *hViewsDict = NSDictionaryOfVariableBindings(view);
		
		[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:hViewsDict]];
		
		if ( idx == 0 )
		{
			NSDictionary *viewsDict = NSDictionaryOfVariableBindings(view);
			
			[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]" options:0 metrics:nil views:viewsDict]];
		}
		else
		{
			NSView *viewAbove = [views objectAtIndex:idx-1];
			NSDictionary *viewsDict = NSDictionaryOfVariableBindings(view, viewAbove);
			
			[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[viewAbove]-0-[view]" options:0 metrics:nil views:viewsDict]];
		}
		if ( idx == views.count -1 )
		{
			
				NSDictionary *flexibleSpaceViewDict = NSDictionaryOfVariableBindings(view);
				[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view]-0-|" options:0 metrics:nil views:flexibleSpaceViewDict]];
		}
		
	}];
	
	//	NSLog(@"constraints: %@", constraints);
	[self addConstraints:constraints];
	//	[self setNeedsUpdateConstraints:YES];
	
	[self setNeedsDisplay:YES];
//	NSLog(@"2reload superview %@", self.superview.constraints);
	
	//	[self.window visualizeConstraints:[self constraints]];
	//	NSLog(@"subtree: %@", [self performSelector:@selector(_subtreeDescription)]);
}


#pragma mark - Private

-(void)ALEXCollectionView_prepareSelf
{
	static dispatch_once_t didPrepareSelf;
	dispatch_once(&didPrepareSelf, ^{
		
		
		_archivedPrototypeViews = [NSMutableDictionary dictionaryWithCapacity:self.subviews.count];
		for (NSView *view in [self.subviews copy])
		{
			[view removeFromSuperviewWithoutNeedingDisplay];
			
			NSString *identifier = view.identifier;
			//			view.identifier = nil;
			NSData *archivedView = [NSKeyedArchiver archivedDataWithRootObject:view];
			
			_archivedPrototypeViews[identifier] = archivedView;
		}
		
		[self setTranslatesAutoresizingMaskIntoConstraints:NO];
		NSMutableArray *constraints = [NSMutableArray array];
		[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(<=0)-[self]-(<=0)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
		[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(<=0)-[self]-(<=0)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
		[self.superview addConstraints:constraints];
		
		
		
		[self setContentHuggingPriority:10 forOrientation:NSLayoutConstraintOrientationHorizontal];
		[self setContentHuggingPriority:10 forOrientation:NSLayoutConstraintOrientationVertical];
		[self setContentCompressionResistancePriority:10 forOrientation:NSLayoutConstraintOrientationHorizontal];
		[self setContentCompressionResistancePriority:10 forOrientation:NSLayoutConstraintOrientationVertical];
	});
}

@end
