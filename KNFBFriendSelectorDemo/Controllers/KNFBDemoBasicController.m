//
//  KNFBDemoBasicController.m
//  KNFBFriendSelectorDemo
//
//  Created by Kent Nguyen on 6/6/12.
//  Copyright (c) 2012 Kent Nguyen. All rights reserved.
//

#import "KNFBDemoBasicController.h"

@implementation KNFBDemoBasicController

@synthesize resultLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = @"Basics";
    self.tabBarItem.image = [UIImage imageNamed:@"TabBasic"];

    // This is how to initiate the items
    items = [NSMutableArray array];
    [items addObject:[[KNSelectorItem alloc] initWithDisplayValue:@"Apple Seed"   selectValue:@"appl" imageUrl:nil]];
    [items addObject:[[KNSelectorItem alloc] initWithDisplayValue:@"Cinnamon"     selectValue:@"cinn" imageUrl:nil]];
    [items addObject:[[KNSelectorItem alloc] initWithDisplayValue:@"Eggplant"     selectValue:@"eggp" imageUrl:nil]];
    [items addObject:[[KNSelectorItem alloc] initWithDisplayValue:@"Dandelion"    selectValue:@"dand" imageUrl:nil]];
    [items addObject:[[KNSelectorItem alloc] initWithDisplayValue:@"Hazel Nut"    selectValue:@"haze" imageUrl:nil]];
    [items addObject:[[KNSelectorItem alloc] initWithDisplayValue:@"Spinach"      selectValue:@"spna" imageUrl:nil]];
    [items addObject:[[KNSelectorItem alloc] initWithDisplayValue:@"Banana Peel"  selectValue:@"bana" imageUrl:nil]];
    [items addObject:[[KNSelectorItem alloc] initWithDisplayValue:@"Violet"       selectValue:@"viol" imageUrl:nil]];
    [items addObject:[[KNSelectorItem alloc] initWithDisplayValue:@"Lettuce"      selectValue:@"lett" imageUrl:nil]];
    [items addObject:[[KNSelectorItem alloc] initWithDisplayValue:@"Coffee Bean"  selectValue:@"cofe" imageUrl:nil]];
    [items addObject:[[KNSelectorItem alloc] initWithDisplayValue:@"Radish"       selectValue:@"radh" imageUrl:nil]];
    [items addObject:[[KNSelectorItem alloc] initWithDisplayValue:@"Quince"       selectValue:@"qunc" imageUrl:nil]];
    [items addObject:[[KNSelectorItem alloc] initWithDisplayValue:@"Tomato"       selectValue:@"toma" imageUrl:nil]];
    [items addObject:[[KNSelectorItem alloc] initWithDisplayValue:@"Vanilla"      selectValue:@"vani" imageUrl:nil]];
    [items addObject:[[KNSelectorItem alloc] initWithDisplayValue:@"Watermelon"   selectValue:@"melo" imageUrl:nil]];
    [items addObject:[[KNSelectorItem alloc] initWithDisplayValue:@"Zucchini"     selectValue:@"zucc" imageUrl:nil]];
    
    currentItems = [NSArray array];
  }
  return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - The buttons

- (IBAction)basicButtonDidTouch:(id)sender {

  // The very basic demo with default parameters
  KNMultiItemSelector * selector = [[KNMultiItemSelector alloc] initWithItems:items
                                                             preselectedItems:currentItems
                                                                        title:@"Select a flavor"
                                                              placeholderText:nil
                                                                     delegate:self];
  [self presentModalHelper:selector];
}

- (IBAction)indexButtonDidTouch:(id)sender {

  // Now we sort the array by its display values and enable table index
  NSArray * sortedItems = [items sortedArrayUsingSelector:@selector(compareByDisplayValue:)];
  KNMultiItemSelector * selector = [[KNMultiItemSelector alloc] initWithItems:sortedItems
                                                             preselectedItems:currentItems
                                                                        title:@"Select a flavor"
                                                              placeholderText:nil
                                                                     delegate:self];
  selector.useTableIndex = YES;

  [self presentModalHelper:selector];
}

- (IBAction)recentButtonDidTouch:(id)sender {

  // Finally we can track the recent selected items with a simple switch
  // and use a different language string for the title and placeholder
  NSArray * sortedItems = [items sortedArrayUsingSelector:@selector(compareByDisplayValue:)];
  KNMultiItemSelector * selector = [[KNMultiItemSelector alloc] initWithItems:sortedItems
                                                             preselectedItems:currentItems
                                                                        title:@"Select a flavor"
                                                              placeholderText:@"Search for something"
                                                                     delegate:self];
  selector.allowSearchControl = YES;
  selector.useRecentItems     = YES;
  selector.maxNumberOfRecentItems = 5;

  [self presentModalHelper:selector];
}

-(void)presentModalHelper:(UIViewController*)controller {
  UINavigationController * uinav = [[UINavigationController alloc] initWithRootViewController:controller];
  uinav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
  uinav.modalPresentationStyle = UIModalPresentationFormSheet;
  [self presentViewController:uinav animated:YES completion:nil];
}

#pragma mark - KNMultiItemSelectorDelegate

-(void)selector:(KNMultiItemSelector *)selector didSelectItem:(KNSelectorItem *)selectedItem {
  // This is optional, in case you want to do something as soon as user selects an item
  NSLog(@"Selected %@", selectedItem.selectValue);
}

-(void)selector:(KNMultiItemSelector *)selector didDeselectItem:(KNSelectorItem *)selectedItem {
  // This is optional, in case you want to revert something you have done earlier
  NSLog(@"Removed %@", selectedItem.selectValue);
}

-(void)selector:(KNMultiItemSelector *)selector didFinishSelectionWithItems:(NSArray *)selectedItems {
  // Do whatever you want with the selected items
  NSString * text = @"Selected: ";
  for (KNSelectorItem * i in selectedItems) {
    text = [text stringByAppendingFormat:@"%@,", i.selectValue];
  }
  self.resultLabel.text = text;
  
  currentItems = selectedItems;

  // You should dismiss modal controller here, it doesn't do that by itself
  [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)selectorDidCancelSelection {
  // You should dismiss modal controller here, it doesn't do that by itself
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidUnload {
  [self setResultLabel:nil];
  [super viewDidUnload];
}
@end
