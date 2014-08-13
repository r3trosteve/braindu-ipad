//
//  BUChartPickerViewController.m
//  braindu-objc
//
//  Created by Steven Schofield on 13/08/2014.
//  Copyright (c) 2014 Double Digital. All rights reserved.
//

#import "BUChartPickerViewController.h"

@interface BUChartPickerViewController ()

@end

@implementation BUChartPickerViewController

-(id)initWithStyle:(UITableViewStyle)style
{
    if ([super initWithStyle:style] != nil) {
        
        //Initialize the array
        _chartNames = [NSMutableArray array];
        
        //Set up the array of colors.
        [_chartNames addObject:@"Web Design Resources"];
        [_chartNames addObject:@"Startups in London"];
        [_chartNames addObject:@"iOS Development"];
        [_chartNames addObject:@"Web Design Resources"];
        [_chartNames addObject:@"Startups in London"];
        [_chartNames addObject:@"iOS Development"];
        [_chartNames addObject:@"Web Design Resources"];
        [_chartNames addObject:@"Startups in London"];
        [_chartNames addObject:@"iOS Development"];
        [_chartNames addObject:@"Web Design Resources"];
        [_chartNames addObject:@"Startups in London"];
        [_chartNames addObject:@"iOS Development"];
        [_chartNames addObject:@"Web Design Resources"];
        [_chartNames addObject:@"Startups in London"];
        [_chartNames addObject:@"iOS Development"];
        [_chartNames addObject:@"Web Design Resources"];
        [_chartNames addObject:@"Startups in London"];
        [_chartNames addObject:@"iOS Development"];
        
        
        //Make row selections persist.
        self.clearsSelectionOnViewWillAppear = NO;
        
        //Calculate how tall the view should be by multiplying
        //the individual row height by the total number of rows.
        NSInteger rowsCount = [_chartNames count];
        NSInteger singleRowHeight = [self.tableView.delegate tableView:self.tableView
                                               heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSInteger totalRowsHeight = rowsCount * singleRowHeight;
        
        //Calculate how wide the view should be by finding how
        //wide each string is expected to be
        CGFloat largestLabelWidth = 0;
        for (NSString *colorName in _chartNames) {
            //Checks size of text using the default font for UITableViewCell's textLabel.
            CGSize labelSize = [colorName sizeWithAttributes:@{NSFontAttributeName:
                                                                   [UIFont fontWithName:@"Helvetica" size:20.]}];
            if (labelSize.width > largestLabelWidth) {
                largestLabelWidth = labelSize.width;
            }
        }
        
        //Add a little padding to the width
        CGFloat popoverWidth = largestLabelWidth + 100;
        
        //Set the property to tell the popover container how big this view will be.
        self.preferredContentSize = CGSizeMake(popoverWidth, totalRowsHeight);
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_chartNames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [_chartNames objectAtIndex:indexPath.row];
    
    return cell;
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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view delegate
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    NSString *selectedChartName = [_chartNames objectAtIndex:indexPath.row];
////    
////    //Create a variable to hold the color, making its default
////    //color something annoying and obvious so you can see if
////    //you've missed a case here.
////    UIColor *color = [UIColor orangeColor];
////    
////    //Set the color object based on the selected color name.
////    if ([selectedChartName isEqualToString:@"Red"]) {
////        color = [UIColor redColor];
////    } else if ([selectedChartName isEqualToString:@"Green"]){
////        color = [UIColor greenColor];
////    } else if ([selectedChartName isEqualToString:@"Blue"]) {
////        color = [UIColor blueColor];
////    }
////    
////    //Notify the delegate if it exists.
////    if (_delegate != nil) {
////        [_delegate selectedChart:color];
////    }
//}

@end
