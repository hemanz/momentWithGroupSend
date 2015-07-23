//
//  ZhuBoMomentCellCell.h
//  RadioHost
//
//  Created by 张鹤楠 on 15/7/9.
//  Copyright (c) 2015年 国广高通（北京）传媒科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhuBoMomentCell : UITableViewCell
@property (nonatomic ,strong)IBOutlet UILabel *ZhuBoName;
@property (nonatomic ,strong)IBOutlet UILabel *ZhuBoContent;
@property (nonatomic ,strong)IBOutlet UILabel *LikeNum;
@property (nonatomic ,strong)IBOutlet UILabel *CommentNum;

@end

