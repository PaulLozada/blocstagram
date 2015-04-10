//
//  BLCImagesTableViewController.m
//  Blocstagram
//
//  Created by Paul Lozada on 2015-03-27.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BLCImagesTableViewController.h"
#import "BLCDataSource.h"
#import "BLCMedia.h"
#import "BLCUser.h"
#import "BLCComment.h"
#import "BLCMediaTableViewCell.h"
#import "BLCMediaFullScreenViewController.h"
#import "BLCMediaFullScreenAnimator.h"

@interface BLCImagesTableViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,BLCMediaTableViewCellDelegate,UIViewControllerTransitioningDelegate>

@property(nonatomic,weak) UIImageView *lastTappedImageView;

@end

@implementation BLCImagesTableViewController



- (void) cell:(BLCMediaTableViewCell *)cell didLongPressImageView:(UIImageView *)imageView {
    NSMutableArray *itemsToShare = [NSMutableArray array];
    
    if (cell.mediaItem.caption.length > 0) {
        [itemsToShare addObject:cell.mediaItem.caption];
    }
    
    if (cell.mediaItem.image) {
        [itemsToShare addObject:cell.mediaItem.image];
    }
    
    if (itemsToShare.count > 0) {
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
        [self presentViewController:activityVC animated:YES completion:nil];
    }
}




#pragma mark - UIViewControllerTransitioningDelegate

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{

    BLCMediaFullScreenAnimator *animator = [BLCMediaFullScreenAnimator new];
    animator.presenting = YES;
    animator.cellImageView = self.lastTappedImageView;
    return animator;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    BLCMediaFullScreenAnimator *animator = [BLCMediaFullScreenAnimator new];
    animator.cellImageView = self.lastTappedImageView;
    return animator;
}


#pragma mark - BLCMediaTableViewCellDelegate

- (void) cell:(BLCMediaTableViewCell *)cell didTapImageView:(UIImageView *)imageView {
    
    self.lastTappedImageView = imageView;
    
    BLCMediaFullScreenViewController *fullScreenVC = [[BLCMediaFullScreenViewController alloc] initWithMedia:cell.mediaItem];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    [button addTarget:self action:@selector(pressedDisclosure:) forControlEvents:UIControlEventTouchUpInside];
//    button.tintColor = [UIColor blackColor];
//    button.titleLabel.text = @"Test";
    
//    [button setFrame:CGRectMake(0, 0, 568, 100)];
//    [fullScreenVC.view addSubview:button];
    fullScreenVC.transitioningDelegate = self;
    fullScreenVC.modalPresentationStyle = UIModalPresentationCustom;

    [self presentViewController:fullScreenVC animated:YES completion:nil];
    
    
}


-(void)pressedDisclosure:(UIButton *)sender{

    NSLog(@"Test");
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"what" message:@"what" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Other", nil];
    [alert show];
    
    NSString *name = @"Paull";
    NSArray *array = [NSArray arrayWithObjects:name, nil];
    
    
    UIActivityViewController *activity = [[UIActivityViewController alloc]initWithActivityItems:array applicationActivities:nil];
    [self presentViewController:activity animated:YES completion:nil];
    
    
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"TEST "message:@"It Works" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Cancel", nil];
//    [alert show];
}

#pragma mark  - Assignment Answer

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    
    [self infiniteScrollIfNecessary];
}

- (void) infiniteScrollIfNecessary {
    NSIndexPath *bottomIndexPath = [[self.tableView indexPathsForVisibleRows] lastObject];
    
    if (bottomIndexPath && bottomIndexPath.row == [BLCDatasource sharedInstance].mediaItems.count - 1) {
        // The very last cell is on screen
        [[BLCDatasource sharedInstance] requestOldItemsWithCompletionHandler:nil];
    }
}

#pragma mark - UIScrollViewDelegate

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    
//    [self infiniteScrollIfNecessary];
//
//}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[BLCDatasource sharedInstance]addObserver:self forKeyPath:@"mediaItems" options:0 context:nil];
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(refreshControlDidFire:) forControlEvents:UIControlEventValueChanged];
  
    [self.tableView registerClass:[BLCMediaTableViewCell class] forCellReuseIdentifier:@"mediaCell"];

    
}

-(void)refreshControlDidFire:(UIRefreshControl *)sender{
    [[BLCDatasource sharedInstance]requestNewItemsWithCompletionHandler:^(NSError *error) {
        [sender endRefreshing];
    }];
    
}

-(void)dealloc{
    
    [[BLCDatasource sharedInstance]removeObserver:self forKeyPath:@"mediaItems"];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (object == [BLCDatasource sharedInstance] && [keyPath isEqualToString:@"mediaItems"]) {
        
        int kindOfChange = [change[NSKeyValueChangeKindKey]intValue];
        
        if (kindOfChange == NSKeyValueChangeSetting) {
            
            [self.tableView reloadData];
        }
        
        else if (kindOfChange == NSKeyValueChangeInsertion ||
                      kindOfChange == NSKeyValueChangeRemoval ||
                   kindOfChange == NSKeyValueChangeReplacement) {
            
            NSIndexSet *indexSetOfChanges = change[NSKeyValueChangeIndexesKey];
            
            NSMutableArray *indexPathsThatChanged = [NSMutableArray array];
            
            [indexSetOfChanges enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:idx inSection:0];
                [indexPathsThatChanged addObject:newIndexPath];
            }];
            
            // Call `beginUpdates` to tell the table view we're about to make changes
            [self.tableView beginUpdates];
            
            // Tell the table view what the changes are
            if (kindOfChange == NSKeyValueChangeInsertion) {
                [self.tableView insertRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            } else if (kindOfChange == NSKeyValueChangeRemoval) {
                [self.tableView deleteRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            } else if (kindOfChange == NSKeyValueChangeReplacement) {
                [self.tableView reloadRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            
            // Tell the table view that we're done telling it about changes, and to complete the animation
            [self.tableView endUpdates];
        }
    }
    
}


- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BLCMedia *item = [BLCDatasource sharedInstance].mediaItems[indexPath.row];
    if (item.image) {
        return 350;
    } else {
        return 150;
    }
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}



#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [BLCDatasource sharedInstance].mediaItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    BLCMediaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mediaCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.mediaItem = [BLCDatasource sharedInstance].mediaItems[indexPath.row];

    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    BLCMedia *item = [BLCDatasource sharedInstance].mediaItems[indexPath.row];
    
    return [BLCMediaTableViewCell heightForMediaItem:item width:CGRectGetWidth(self.view.frame)];

}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        BLCMedia *item = [BLCDatasource sharedInstance].mediaItems[indexPath.row];
        [[BLCDatasource sharedInstance]deleteMediaItem:item];
       
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
