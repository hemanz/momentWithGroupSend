//
//  TBCell.h
//  moment
//
//  Created by 张鹤楠 on 15/7/13.
//  Copyright (c) 2015年 张鹤楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBCell : UITableViewCell
@property (strong ,nonatomic) IBOutlet UILabel *anchorTitle;
@property (strong ,nonatomic) IBOutlet UILabel *content;
@property (strong ,nonatomic) IBOutlet UILabel *contentTime;
@property (strong ,nonatomic) IBOutlet UIImageView *anchorImage;
@property (strong ,nonatomic) IBOutlet UILabel *commentNum;
@end
