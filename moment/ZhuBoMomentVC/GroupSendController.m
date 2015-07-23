//
//  GroupSendController.m
//  moment
//
//  Created by 张鹤楠 on 15/7/20.
//  Copyright (c) 2015年 张鹤楠. All rights reserved.
//

#import "GroupSendController.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFNetworking.h"
#define wid [UIScreen mainScreen].bounds.size.width
#define heigh [UIScreen mainScreen].bounds.size.height
@interface GroupSendController()<UIScrollViewDelegate,UITextViewDelegate,AVAudioRecorderDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate>
{
    UIScrollView *baseView;
    UIView *fuctionBgView;
    
    UIImageView *headImage;
    UIImageView *bgView;
    UIImageView *picImageView;
    UIImageView *bgBelowView;
    UILabel *zhuboName;
    UIButton *voiveButton;
    UIButton *textButton;
    UIButton *imageButton;
    UIButton *groupSendButton;
    UIButton *recordButton;
    UIButton *huitingButton; //回听
    UIButton *reRecordButton;
    UIButton *showSecond;
    UIButton *upLoadPicButton;
    NSData *picImageData;
    
    UITextView *groupSendTextField;
    
    int flag ;//群发类型标志位 0.voice 1.pic 2.text
    int recordTime;
    
}
@property(nonatomic, strong) NSData *fileData;

@end
@implementation GroupSendController


- (void) viewDidLoad{
    [super viewDidLoad];
    [self loadView1];
    [self loadData];
    [self audio];
}

- (void) loadView1{
    baseView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, wid,heigh)];
    headImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 25, 64, 64)];
    picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, wid-20, (wid-20)*2/3-10)];
    zhuboName = [[UILabel alloc] initWithFrame:CGRectMake(100 ,25 , 100, 35)];
    voiveButton = [[UIButton alloc] initWithFrame:CGRectMake(wid/12, 105, wid/6, wid/6)];
    imageButton = [[UIButton alloc] initWithFrame:CGRectMake(wid*5/12, 105, wid/6, wid/6)];
    textButton = [[UIButton alloc] initWithFrame:CGRectMake(wid*3/4, 105, wid/6, wid/6)];
    fuctionBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 105+wid/6+10, wid, heigh/2-44)];
    bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, wid, (heigh/2-44)/5)];
    bgBelowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (heigh/2-44)/5-5, wid, (heigh/2-44)/5*4)];
    groupSendButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 105+wid/6+10+ heigh/2-44+10, wid-wid/8, 40)];
    recordButton = [[UIButton alloc] initWithFrame:CGRectMake(wid/12, heigh/10, wid/2+wid/3, heigh/5)];
    huitingButton = [[UIButton alloc] initWithFrame:CGRectMake(wid/5, heigh/10, wid/2, heigh/5)];
    reRecordButton = [[UIButton alloc] initWithFrame:CGRectMake(wid/2+wid/10, heigh/5, wid/6, wid/6)];
    upLoadPicButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 15, wid-20, (wid-20)*2/3)];
    
    
    [baseView addSubview:imageButton];
    [baseView addSubview:textButton];
    [baseView addSubview:voiveButton];
    [baseView addSubview:zhuboName];
    [baseView addSubview:headImage];
    [baseView addSubview:fuctionBgView];
    [baseView addSubview:groupSendButton];
    [self.view addSubview:baseView];
    [self voiceClick:voiveButton];
}

- (void) loadData{
    baseView.contentSize = CGSizeMake(wid, heigh*1.05);
    baseView.delegate = self;
    baseView.showsHorizontalScrollIndicator = NO;
    baseView.showsVerticalScrollIndicator = NO;
    baseView.backgroundColor = [UIColor whiteColor];
    [headImage setImage:[UIImage imageNamed:@"zhubotouxiang"]];
    zhuboName.text = @"一二三四";
    voiveButton.backgroundColor = [UIColor whiteColor];
    textButton.backgroundColor = [UIColor whiteColor];
    imageButton.backgroundColor = [UIColor whiteColor];
    
    [voiveButton addTarget:self action:@selector(voiceClick:) forControlEvents:UIControlEventTouchUpInside];
    [voiveButton setImage:[UIImage imageNamed:@"groupsend_voice.png"] forState:UIControlStateNormal];
    
    [textButton addTarget:self action:@selector(textClick:) forControlEvents:UIControlEventTouchUpInside];
    [textButton setImage:[UIImage imageNamed:@"groupsend_text.png"] forState:UIControlStateNormal];
    
    [imageButton addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageButton setImage:[UIImage imageNamed:@"groupsend_pic.png"] forState:UIControlStateNormal];
    
    [recordButton setImage:[UIImage imageNamed:@"record_animate_0.png"] forState:UIControlStateNormal];
    [recordButton addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchDown];
    [recordButton addTarget:self action:@selector(btnUp:) forControlEvents:UIControlEventTouchUpInside];
    [recordButton addTarget:self action:@selector(btnDragUp:) forControlEvents:UIControlEventTouchDragExit];
    [huitingButton setImage:[UIImage imageNamed:@"bofang.png"] forState:UIControlStateNormal];
    [huitingButton addTarget:self action:@selector(playRecordSound:) forControlEvents:UIControlEventTouchUpInside];
    [reRecordButton addTarget:self action:@selector(voiceClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [upLoadPicButton setImage:[UIImage imageNamed:@"groupsend_uploadPic.png"] forState:UIControlStateNormal];
    [upLoadPicButton addTarget:self action:@selector(takePictureClick:) forControlEvents:UIControlEventTouchUpInside];
    
    groupSendButton.backgroundColor = [UIColor colorWithRed:9.0f/255.0f green:185.0f/255.0f blue:12.0f/255.0f alpha:1];
    [groupSendButton setTitle:@"群发" forState:UIControlStateNormal];
    [groupSendButton addTarget:self action:@selector(groupSendClick:) forControlEvents:UIControlEventTouchUpInside];

    groupSendButton.layer.cornerRadius = 6;
    groupSendButton.layer.masksToBounds = YES;
}

#pragma mark 按钮事件处理方法
- (void) voiceClick: (UIButton *)btn{
    [self loadData];
    [self removeSubview];
    [bgView setImage:[UIImage imageNamed:@"groupsend_left.png"]];
    [bgBelowView setImage:[UIImage imageNamed:@"groupsend_greyBlock.png"]];
    [fuctionBgView addSubview:bgView];
    [fuctionBgView addSubview:bgBelowView];
    [fuctionBgView addSubview:recordButton];
    [voiveButton setImage:[UIImage imageNamed:@"groupsend_voice_selected.png"] forState:UIControlStateNormal];
    flag = 0;

    NSLog(@"voice");
}

- (void) textClick: (UIButton *)btn{
    [self loadData];
    [self removeSubview];
    [bgView setImage:[UIImage imageNamed:@"groupsend_right.png"]];
    [bgBelowView setImage:[UIImage imageNamed:@"groupsend_greyBlock.png"]];
    [fuctionBgView addSubview:bgView];
    [fuctionBgView addSubview:bgBelowView];
    [textButton setImage:[UIImage imageNamed:@"groupsend_text_selected.png"] forState:UIControlStateNormal];

    groupSendTextField = [[UITextView alloc] initWithFrame:CGRectMake(20, 5, wid-40, heigh/2-44-20)];
    groupSendTextField.backgroundColor = [UIColor clearColor];
    groupSendTextField.font = [UIFont systemFontOfSize:15];
    groupSendTextField.text = @"请输入群发的文字内容";
    [fuctionBgView addSubview:groupSendTextField];
    flag = 2;
    
}

- (void) imageClick: (UIButton *)btn{
    [self loadData];
    [self removeSubview];
    [bgBelowView setImage:[UIImage imageNamed:@"groupsend_greyBlock.png"]];
    [bgView setImage:[UIImage imageNamed:@"groupsend_middle.png"]];
    [fuctionBgView addSubview:bgView];
    [fuctionBgView addSubview:bgBelowView];
    [imageButton setImage:[UIImage imageNamed:@"groupsend_pic_selected.png"] forState:UIControlStateNormal];
    [fuctionBgView addSubview:upLoadPicButton];
    flag = 1;
}

- (void) groupSendClick:(UIButton *)btn{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.requestSerializer.timeoutInterval = 50;
    //@"application/json", r   @"text/json", @"text/javascript",@"text/html",@"image/jpg" ,
    [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:  @"application/json",  @"multipart/form-data" ,@"text/html" , @"image/jpg" , nil]];
    switch (flag) {
            
        case 0:
            
            break;
        case 1:
        {
            NSLog(@"image@@@");
            NSString *postUrl = @"http://123.57.206.120:8080/radio/sendMessgeForFavors/ios/233333/1.0";
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"anchorid",@"img",@"type", nil];
            [manager POST:postUrl parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
             {
                 [formData appendPartWithFileData :picImageData name:@"file" fileName:@"11.png" mimeType:@"image/jpg"];
 
                 //                [SVProgressHUD showInView:self.view status:@"正在为您合成卡片，请稍等"];
             } success:^(AFHTTPRequestOperation *operation,id responseObject)
             {
                 NSLog(@"success");
                 [self textClick:textButton];
                 
             } failure:^(AFHTTPRequestOperation *operation,NSError *error)
             {
                 NSLog(@"error:%@",error);
             }];
           
            break;
        }
        case 2:
        {
            NSString *postUrl = @"http://123.57.206.120:8080/radio/sendMessgeForFavors/ios/233333/1.0";
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"88",@"anchorid",@"txt",@"type",groupSendTextField.text,@"content", nil];
            [manager POST:postUrl parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
            {
                
//                [SVProgressHUD showInView:self.view status:@"正在为您合成卡片，请稍等"];
            } success:^(AFHTTPRequestOperation *operation,id responseObject)
            {
                NSLog(@"success");
                [self textClick:textButton];
                
            } failure:^(AFHTTPRequestOperation *operation,NSError *error)
            {
                NSLog(@"error:%@",error);
            }];
        
            break;
        }
        default:
            break;
    }
    
}


- (void)removeSubview{
    for (UIView *view in fuctionBgView.subviews) {
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
}

#pragma mark 录音
- (void)btnDown:(UIButton *)sender
{
    //创建录音文件，准备录音
    if ([recorder prepareToRecord]) {
        //开始
        [recorder record];
    }
    recordTime = 0;
    //设置定时检测
    showSecond = [[UIButton alloc] initWithFrame:CGRectMake(wid/3+5, wid/15, wid/3-10, heigh/20)];
    [showSecond setBackgroundImage:[UIImage imageNamed:@"groupsend_showSencond.png"] forState:UIControlStateNormal];
    [showSecond setTitle:@"0\"" forState:UIControlStateNormal];
//    [showSecond setImage:[UIImage imageNamed:@"groupsend_showSencond.png"] forState:UIControlStateNormal];
    [fuctionBgView addSubview:showSecond];
    timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(detectionVoice) userInfo:nil repeats:YES];
    recordTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateRecordTime:) userInfo:nil repeats:YES];
}
- (void)btnUp:(UIButton *)sender
{
    NSTimeInterval cRecorderTime = recorder.currentTime;
    if (cRecorderTime > 2.0) {//如果录制时间<2 不发送
        NSLog(@"发出去");
        [recordButton setImage:[UIImage imageNamed:@"record_animate_0.png"] forState:UIControlStateNormal];
        [reRecordButton setImage:[UIImage imageNamed:@"groupsend_rerecord.png"] forState:UIControlStateNormal];
        [self removeSubview];
        [fuctionBgView addSubview:huitingButton];
        [fuctionBgView addSubview:reRecordButton];
        [showSecond removeFromSuperview];
        NSLog(@"###@@@@%1.0f",recorder.currentTime);
    }else {
        //删除记录的文件
        [recorder deleteRecording];
        //删除存储的
        showSecond.titleLabel.font = [UIFont systemFontOfSize:14];
        [showSecond setTitle:@"语音时间太短" forState:UIControlStateNormal];
        removeShowSecondHint = [NSTimer scheduledTimerWithTimeInterval:0.7 target:self selector:@selector(removeShowSecondHint:) userInfo:nil repeats:NO];
    }
    
    [recorder stop];
    [timer invalidate];
    [recordTimer invalidate];

    
}
- (void)btnDragUp:(UIButton *)sender
{
    //删除录制文件
    [recorder deleteRecording];
    [recorder stop];
    [timer invalidate];
    [recordTimer invalidate];

    NSLog(@"取消发送");
}
- (void)audio
{
    //录音设置
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init] ;
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    
    NSString *strUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/lll.aac", strUrl]];
    urlPlay = url;
    
    NSError *error;
    //初始化
    recorder = [[AVAudioRecorder alloc]initWithURL:url settings:recordSetting error:&error];
    //开启音量检测
    recorder.meteringEnabled = YES;
    recorder.delegate = self;
}

- (void)detectionVoice
{
    [recorder updateMeters];//刷新音量数据
    //获取音量的平均值  [recorder averagePowerForChannel:0];
    //音量的最大值  [recorder peakPowerForChannel:0];
    
    double lowPassResults = pow(10, (0.05 * [recorder peakPowerForChannel:0]));
//    NSLog(@"%lf",lowPassResults);
    //最大50  0
    //图片 小-》大
    if (0<lowPassResults<=0.45) {
        [recordButton setImage:[UIImage imageNamed:@"record_animate_01.png"] forState:UIControlStateHighlighted];
    }else if (0.45<lowPassResults<=0.56) {
        [recordButton setImage:[UIImage imageNamed:@"record_animate_02.png"] forState:UIControlStateHighlighted];
    }else if (0.56<lowPassResults<=0.9) {
        [recordButton setImage:[UIImage imageNamed:@"record_animate_03.png"] forState:UIControlStateHighlighted];
//    }else if (0.63<lowPassResults<=0.9) {
//        [self.imageView setImage:[UIImage imageNamed:@"record_animate_04.png"]];
//    }else if (0.27<lowPassResults<=0.34) {
//        [self.imageView setImage:[UIImage imageNamed:@"record_animate_05.png"]];
//    }else if (0.34<lowPassResults<=0.41) {
//        [self.imageView setImage:[UIImage imageNamed:@"record_animate_06.png"]];
//    }else if (0.41<lowPassResults<=0.48) {
//        [self.imageView setImage:[UIImage imageNamed:@"record_animate_07.png"]];
//    }else if (0.48<lowPassResults<=0.55) {
//        [self.imageView setImage:[UIImage imageNamed:@"record_animate_08.png"]];
//    }else if (0.55<lowPassResults<=0.62) {
//        [self.imageView setImage:[UIImage imageNamed:@"record_animate_09.png"]];
//    }else if (0.62<lowPassResults<=0.69) {
//        [self.imageView setImage:[UIImage imageNamed:@"record_animate_10.png"]];
//    }else if (0.69<lowPassResults<=0.76) {
//        [self.imageView setImage:[UIImage imageNamed:@"record_animate_11.png"]];
//    }else if (0.76<lowPassResults<=0.83) {
//        [self.imageView setImage:[UIImage imageNamed:@"record_animate_12.png"]];
//    }else if (0.83<lowPassResults<=0.9) {
//        [self.imageView setImage:[UIImage imageNamed:@"record_animate_13.png"]];
    }else {
        [recordButton setImage:[UIImage imageNamed:@"record_animate_0.png"] forState:UIControlStateNormal];
    }
}

- (void)updateRecordTime:(NSTimer *)timer{
    recordTime++;
    NSString *rtime = [[NSString alloc] initWithFormat:@"%d\"",recordTime];
    [showSecond setTitle:rtime forState:UIControlStateNormal];
    NSLog(@"%%saf%d",recordTime);
}

- (void)removeShowSecondHint:(NSTimer *)timer{
    [showSecond removeFromSuperview];
    [removeShowSecondHint invalidate];

}

#pragma mark 播放
- (void) playRecordSound:(UIButton *) btn{
    if (self.avPlay.playing) {
        [self.avPlay stop];
        return;
    }
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:urlPlay error:nil];
    self.avPlay = player;
    [self.avPlay play];
}


- (void) updateImage
{
    [recordButton setImage:[UIImage imageNamed:@"record_animate_0.png"] forState:UIControlStateNormal];
}

#pragma mark 照片上传
//从相册获取图片
-(void) takePictureClick:(UIButton *)tapButtomGesture{
   
    UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"请选择文件来源"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"照相机",@"本地相簿",nil];
    [actionSheet showInView:self.view];
    
    
}

#pragma UIActionSheet Delega
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex = [%d]",buttonIndex);
    switch (buttonIndex) {
        case 0://照相机
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = NO;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //            [self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
        case 1://本地相册
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = NO;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //            [self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:nil];        }
            break;
            
        default:
            break;
    }
}

#pragma UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [upLoadPicButton removeFromSuperview];
    [fuctionBgView addSubview:picImageView];
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    }
    else if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeMovie]) {
        NSString *videoPath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
        self.fileData = [NSData dataWithContentsOfFile:videoPath];
    }
    //    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage:(UIImage *)image {
    //    NSLog(@"保存头像！");
    //    [userPhotoButton setImage:image forState:UIControlStateNormal];
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:@"selfPhoto.jpg"];
    NSLog(@"imageFile->>%@",imageFilePath);
    NSLog(@"##############################");
    success = [fileManager fileExistsAtPath:imageFilePath];
    if(success) {
        success = [fileManager removeItemAtPath:imageFilePath error:&error];
    }
    //    UIImage *smallImage=[self scaleFromImage:image toSize:CGSizeMake(80.0f, 80.0f)];//将图片尺寸改为80*80
    //    UIImage *buttomImage = [[UIImage alloc] init];
    [UIImageJPEGRepresentation(image, 1.0f) writeToFile:imageFilePath atomically:YES];//写入文件
    NSLog(@"**ImageFilePath%@",imageFilePath);
    UIImage *selfPhoto1 = [UIImage imageWithContentsOfFile:imageFilePath];//读取图片文件
    NSLog(@"**ImageFilePath%@",imageFilePath);
    
    //    [userPhotoButton setImage:selfPhoto forState:UIControlStateNormal];
    NSLog(@"%@",selfPhoto1);
    picImageView.image = selfPhoto1;
    picImageData = UIImageJPEGRepresentation(picImageView.image,0.5);
}


#pragma mark textViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    
}

- (void)textViewDidChange:(UITextView *)textView{
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //放弃第一响应者身份
    [groupSendTextField resignFirstResponder];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
