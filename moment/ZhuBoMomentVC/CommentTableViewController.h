//
//  commentTableViewController.h
//  RadioHost
//
//  Created by 张鹤楠 on 15/6/27.
//  Copyright (c) 2015年 国广高通（北京）传媒科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ZhuBoMomentModel.h"

@interface CommentTableViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate>

//@property (nonatomic ,strong)ZhuBoMomentModel *ZBModel;


@property (nonatomic, strong) UITableViewCell *prototypeCell;


//- (IBAction)like:(UIButton *)button;

@end
