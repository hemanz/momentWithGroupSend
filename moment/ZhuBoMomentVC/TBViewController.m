//
//  TBViewController.m
//  baiduTieba
//
//  Created by Kevin Lee on 13-5-13.
//  Copyright (c) 2013年 Kevin. All rights reserved.
//

#import "TBViewController.h"
#import "CommentTableViewController.h"
#import "TBCell.h"
#import "NSString+Ext.h"
#define wid [UIScreen mainScreen].bounds.size.width
#define heigh [UIScreen mainScreen].bounds.size.height

@interface TBViewController ()
{
    NSMutableArray *anchorMoment;
//    UIView *MainView;
//    UITableView *myTableView;
    NSArray *arr;
    int loadPages;
}

//@property (retain,nonatomic) UITableView *mytableView;
@property (nonatomic) BOOL refreshing;

@end

@implementation TBViewController

//- (void)viewDidAppear:(BOOL)animated{
//    myTableView.frame = CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height);
//
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createUI];
   
    anchorMoment = [[NSMutableArray alloc] init];
//    [self momentRequerData:kAnchorMomentURL andPages:0];
    loadPages = 0;
    arr = @[@"1\n2\n3\n4\n5\n6", @"1\n2\n3\n4\n5\n61\n2\n3\n4\n5\n61\n2\n3\n4\n5\n6国务卿由总统任命（经参议院同意），并对总统负责，是仅次于正、副总统的高级行政官员；是总统外交事务的主要顾问，内阁会议和国家安全委员会的首席委员。国务院设有副国务卿、。国务卿由总统任命（经参议院同意），并对总统负责，是仅次于正、副总统的高级行政官员；是总统外交事务的主要顾问，内阁会议和国家安全委员会的首席委员。国务院设有副国务卿、。", @"1\n2", @"1\n2\n3", @"国务卿由总统任命（经参议院同意），并对总统负责，是仅次于正、副总统的高级行政官员；是总统外交事务的主要顾问，内阁会议和国家安全委员会的首席委员。国务院设有副国务卿、。国务卿由总统任命（经参议院同意），并对总统负责，是仅次于正、副总统的高级行政官员；是总统外交事务的主要顾问，内阁会议和国家安全委员会的首席委员。国务院设有副国务卿、。"];

}
-(void)createUI{
    self.myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,wid, heigh) style:UITableViewStylePlain];
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    [self.view addSubview:self.myTableView];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arr count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TBCell *cell = (TBCell *)[tableView dequeueReusableCellWithIdentifier :@"TBCell2"];
    NSLog(@"cell:%@",cell);
    NSString *str = arr[indexPath.row];
    cell.content.text = str;
    CGSize s = [str calculateSize:CGSizeMake(cell.content.frame.size.width, FLT_MAX) font:[UIFont fontWithName:@"Arial-BoldItalicMT" size:16]];
    NSLog(@"CELL.content.Frame:%f",cell.content.frame.size.width);

    CGFloat defaultHeight = cell.contentView.frame.size.height;
    CGFloat height = s.height > defaultHeight ? s.height : defaultHeight;
    NSLog(@"height :%f",height);
    NSLog(@"h=%f", height);
    return 1  + height;
//    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"TBCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:@"TBCell2"];
        nibsRegistered = YES;
    }
    TBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TBCell2" forIndexPath:indexPath];
    cell.content.text = arr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentTableViewController *CVC = [[CommentTableViewController alloc] init];
 
    UINavigationController *nVC =[[UINavigationController alloc] initWithRootViewController:CVC];
    [self presentViewController:nVC animated:YES completion:^{
        
    }];

}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 158;
}


@end
