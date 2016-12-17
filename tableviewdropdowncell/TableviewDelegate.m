//
//  TableviewDelegate.m
//  tableviewdropdowncell
//
//  Created by wyj on 2016/12/17.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "TableviewDelegate.h"

@implementation TableviewDelegate

- (id)init{
    self = [super init];
    if (self) {
        dropdownItem = -1;
        
        tableContent = [[NSMutableArray alloc]init];
        for (int i = 0; i < 100; i++) {
            NSNumber *number = [[NSNumber alloc]initWithInt:i];
            [tableContent addObject:number];
        }
    }
    return self;
}
- (NSView*)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    if (row < 0) {
        return nil;
    }
    
    if (row == dropdownItem) {
        NSTableCellView *view = [tableView makeViewWithIdentifier:@"dropdownCell" owner:self];
        [view.textField setStringValue:@"THIS IS A DROPDOWN CELL VIEW."];
        return view;
    }
    
    
    NSTableCellView *view = [tableView makeViewWithIdentifier:@"mainCell" owner:self];
    NSString *value = [[NSString alloc]initWithFormat:@"mainCell %ld", (long)row];

    [view.textField setStringValue:value];
    return view;
}

- (BOOL)tableView:(NSTableView *)tableView isGroupRow:(NSInteger)row{
    if (row == dropdownItem) {
        return YES;
    }
    return NO;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return 36.0f;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    NSInteger count = [tableContent count];
    return count;
}

- (NSIndexSet*)tableView:(NSTableView *)tableView selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes{
    NSInteger row = [tableView clickedRow];
    if (row < 0) {
    
        return proposedSelectionIndexes;
    }
    
    if (![self tableView:tableView isGroupRow:row]) {
        row = [self changeSelectionItem:tableView row:row];
        return [NSIndexSet indexSetWithIndex:row];
    }
    return [tableView selectedRowIndexes];
    
}
#pragma mark - table view handle
- (NSInteger)changeSelectionItem:(NSTableView*)tableView row:(NSInteger)row
{
    if (row == -1){
        if(dropdownItem == -1) {
            return row;
        }
        [self closeCell:tableView row:dropdownItem - 1];
        return row;
    }
    if (dropdownItem == -1) {
        [self openCell:tableView row:row];
        if (row != [tableView selectedRow]) {
            [tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:row] byExtendingSelection:NO];
        }
        
    }else if(dropdownItem != row+1){
        if(dropdownItem < row)
        {
            row -= 1;
        }
        [self closeCell:tableView row:dropdownItem - 1];
        
        [self openCell:tableView row:row];
        if (row != [tableView selectedRow]) {
            [tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:row] byExtendingSelection:NO];
        }
    }else{
        [self closeCell:tableView row:row];
    }
    
    return row;
}
- (void)openCell:(NSTableView*)tableView row:(NSInteger)row
{
    if (row == -1) {
        return;
    }
    dropdownItem = row + 1;
    
    //    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"subcell", @"Name", nil, @"Image", nil];
    [tableContent insertObject:[tableContent objectAtIndex:row] atIndex:dropdownItem];
    
    [tableView beginUpdates];
    [tableView insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:dropdownItem] withAnimation:NSTableViewAnimationEffectFade];
    [tableView scrollRowToVisible:dropdownItem];
    [tableView endUpdates];
    
}
- (void)closeCell:(NSTableView*)tableView row:(NSInteger)row
{
    [tableContent removeObjectAtIndex:dropdownItem];
    [tableView removeRowsAtIndexes:[NSIndexSet indexSetWithIndex:dropdownItem] withAnimation:NSTableViewAnimationEffectFade];
    dropdownItem = -1;
    
}

@end
