//
//  commentTableViewController.m
//  RadioHost
//
//  Created by 张鹤楠 on 15/6/27.
//  Copyright (c) 2015年 国广高通（北京）传媒科技有限公司. All rights reserved.
//

#import "commentTableViewController.h"
//#import "ZhuBoCommentModel.h"
#import "ZhuBoMomentCell.h"
#import "NSString+Ext.h"
#import "UserCommentCell.h"

@interface CommentTableViewController ()
{
    UITableView *contentTBV;
    NSMutableArray *commentArray;
    NSArray *arr;
}

@end

@implementation CommentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addimage:[UIImage imageNamed:@"导航_back"] title:nil selector:@selector(backClick) location:YES frame:40];
//    contentTBV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
//    contentTBV.dataSource = self;
//    contentTBV.delegate = self;
//    contentTBV.separatorStyle = UITableViewCellSeparatorStyleNone;
//    commentArray = [[NSMutableArray alloc] init];
//    [self.view addSubview:contentTBV];
    UINib *nib = [UINib nibWithNibName:@"ZhuBoMomentCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"C1"];
    arr = @[@"1\n2\n3\n4\n5\n6", @"1\n2\n3\n4\n5\n61\n2\n3\n4\n5\n61\n2\n3\n4\n5\n6国务卿由总统任命（经参议院同意），并对总统负责，是仅次于正、副总统的高级行政官员；是总统外交事务的主要顾问，内阁会议和国家安全委员会的首席委员。国务院设有副国务卿、。国务卿由总统任命（经参议院同意），并对总统负责，是仅次于正、副总统的高级行政官员；是总统外交事务的主要顾问，内阁会议和国家安全委员会的首席委员。国务院设有副国务卿、。", @"1\n2", @"1\n2\n3", @"国务卿由总统任命（经参议院同意），并对总统负责，是仅次于正、副总统的高级行政官员；是总统外交事务的主要顾问，内阁会议和国家安全委员会的首席委员。国务院设有副国务卿、。国务卿由总统任命（经参议院同意），并对总统负责，是仅次于正、副总统的高级行政官员；是总统外交事务的主要顾问，内阁会议和国家安全委员会的首席委员。国务院设有副国务卿、。"];
    
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  10;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"C2";
    ZhuBoMomentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UserCommentCell *UserCell = [tableView dequeueReusableCellWithIdentifier:@"C2"];
    if (cell == nil){
        
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"ZhuBoMomentCell" owner:self options:nil];
        cell = (ZhuBoMomentCell *)[nibArray objectAtIndex:0];
        
    }
    if (indexPath.row == 0) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"ZhuBoMomentCell" owner:self options:nil];
        cell = (ZhuBoMomentCell *)[nibArray objectAtIndex:0];
        cell.ZhuBoContent.text = @"qqqqqqqqwwwwwwwwwwww";
        
    }else{
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"ZhuBoMomentCell" owner:self options:nil];
        UserCell = (UserCommentCell *)[nibArray objectAtIndex:1];
        UserCell.content.text =@"dddd";
        return UserCell;
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath == 0){
//    
//////        _ZhuBoContent.text = _ZBModel.content;
////        static NSString *CellIdentifier = @"C1";
////        self.prototypeCell  = [tableView dequeueReusableCellWithIdentifier:@"C1"];
//////        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
////      
////        NSString *str = _ZBModel.content;
////        NSLog(@"frame:%f",_ZhuBoContent.frame.size.width);
////        CGSize s = [str calculateSize:CGSizeMake(_ZhuBoContent.frame.size.width, FLT_MAX) font:[UIFont fontWithName:@"Arial-BoldItalicMT" size:17]];
////        CGFloat defaultHeight = _ZhuBoContent.frame.size.height;
////        CGFloat height = s.height > defaultHeight ? s.height : defaultHeight;
////        NSLog(@"h=%f", height);
////        return 1  + height;
//        return 158;
//
//        
//    }else{
//    
//    return 95;
//    }
    if (indexPath.row == 0 ) {
        NSLog(@"indexPath:%@",indexPath);
        ZhuBoMomentCell *cell = (ZhuBoMomentCell *)[tableView dequeueReusableCellWithIdentifier :@"C2"];
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"ZhuBoMomentCell" owner:self options:nil];
        cell = (ZhuBoMomentCell *)[nibArray objectAtIndex:0];
        NSLog(@"cell:%@",cell);
        NSString *str = @"哈哈哈哈哈哈哈哈哈哈";
        CGSize s = [str calculateSize:CGSizeMake(cell.ZhuBoContent.frame.size.width, FLT_MAX) font:[UIFont fontWithName:@"Arial-BoldItalicMT" size:16]];
        CGFloat defaultHeight = cell.contentView.frame.size.height;
        CGFloat height = s.height > defaultHeight ? s.height : defaultHeight;
        NSLog(@"height :%f",height);
        NSLog(@"h=%f", height);
        return 1  + height;
    }else{
        UserCommentCell *cell = (UserCommentCell *)[tableView dequeueReusableCellWithIdentifier :@"C2"];
        NSString *str = @"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
        cell.content.text = str;
        CGSize s = [str calculateSize:CGSizeMake(cell.content.frame.size.width, FLT_MAX) font:[UIFont fontWithName:@"Arial-BoldItalicMT" size:18]];
        NSLog(@"CELL.content.Frame:%f",cell.content.frame.size.width);
        CGFloat defaultHeight = cell.contentView.frame.size.height;
        CGFloat height = s.height > defaultHeight ? s.height : defaultHeight;
        NSLog(@"height :%f",height);
        NSLog(@"h=%f", height);
        return 1  + height;
    }
   
//    return 189;
}

- (void)backClick {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

//- (void)getCommentData{
//    for (NSDictionary *dic in _ZBModel.anchorCommentsList) {
//        ZhuBoCommentModel *ZBContent = [[ZhuBoCommentModel alloc] init];
//        ZBContent.nickName = dic[@"nickname"];
//        ZBContent.content = dic[@"comments"];
//        NSLog(@"@@@@%@",ZBContent.nickName);
//        [commentArray addObject:ZBContent];
//    }
//}
@end
