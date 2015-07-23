//
//  UserCommentCell.h
//  moment
//
//  Created by 鹤楠 on 15/7/15.
//  Copyright (c) 2015年 张鹤楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCommentCell : UITableViewCell
@property (nonatomic ,strong)IBOutlet UIImageView *commentHeaderImage;
@property (nonatomic ,strong)IBOutlet UILabel *nickName;
@property (nonatomic ,strong)IBOutlet UILabel *content;
@property (nonatomic ,strong)IBOutlet UILabel *likeNum;
@end
