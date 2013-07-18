//
//  DLTableViewController.m
//  KVODEMO
//
//  Created by zht on 13-7-18.
//  Copyright (c) 2013年 zht. All rights reserved.
//

#import "DLTableViewController.h"

@interface DLTableViewController ()

@end

@implementation DLTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.items = [NSMutableArray arrayWithCapacity:0];
    
    __autoreleasing UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(insertNewItem)];
    self.navigationItem.rightBarButtonItem = addBtn;
    
    [self addObserver:self
           forKeyPath:@"items"
              options:0
              context:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewItem {
    NSDate *now = [NSDate date];  NSLog(@"insert date of now = %@", now);
    [self insertObject:[NSString stringWithFormat:@"%@", now] inItemsAtIndex:0];
    NSLog(@"%@", self.items);
    //[self.tableView reloadData];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"items"]) {
        NSIndexSet *indices = [change objectForKey:NSKeyValueChangeIndexesKey];
        
        NSLog(@"indexSet ==== %@",indices);
        if (indices == nil)
            return; // Nothing to do
        
        
        // Build index paths from index sets
        NSUInteger indexCount = [indices count];
        NSUInteger buffer[indexCount];//声明一个数组,存放改变的index
        [indices getIndexes:buffer maxCount:indexCount inIndexRange:nil];
        
        NSMutableArray *indexPathArray = [NSMutableArray array];
        for (int i = 0; i < indexCount; i++) {
            NSUInteger indexPathIndices[2];
            indexPathIndices[0] = 0;
            indexPathIndices[1] = buffer[i];
            NSIndexPath *newPath = [NSIndexPath indexPathWithIndexes:indexPathIndices length:2];
            
            NSLog(@"newPath ==== %d,=====%d",newPath.row,newPath.section);
            [indexPathArray addObject:newPath];
        }
        
        //判断值变化是insert、delete、replace
        NSNumber *kind = [change objectForKey:NSKeyValueChangeKindKey];
        if ([kind integerValue] == NSKeyValueChangeInsertion)  // Operations were added
            [self.tableView insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
        else if ([kind integerValue] == NSKeyValueChangeRemoval)  // Operations were removed
            [self.tableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - KVO array accessors
- (void)insertObject:(id)anObject inItemsAtIndex:(NSUInteger)idx {
    [self.items insertObject:anObject atIndex:idx];
}
- (id)objectInItemsAtIndex:(NSUInteger)idx {
    return [self.items objectAtIndex:idx];
}
- (void)removeObjectFromItemsAtIndex:(NSUInteger)idx {
    [self.items removeObjectAtIndex:idx];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self removeObjectFromItemsAtIndex:indexPath.row];
        //[self.tableView reloadData];
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
