//
//  ViewController.m
//  WCDBDemo
//
//  Created by 张骏 on 2017/9/14.
//  Copyright © 2017年 ZJ. All rights reserved.
//

#import "ViewController.h"
#import <WCDB.h>
#import "ResumeModel+WCTTableCoding.h"

static NSString *const resumeTable = @"resumeTable";

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *ageField;
@property (weak, nonatomic) IBOutlet UITextField *sexField;
@property (weak, nonatomic) IBOutlet UITextField *locationField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;
@property (weak, nonatomic) IBOutlet UIButton *enumBtn;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (nonatomic, strong) WCTDatabase *dataBase;
@property (nonatomic, strong) NSMutableArray *resumeArray;

@end

@implementation ViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepare];
}


#pragma mark - private
- (void)prepare{
    
    //初始化数据库
    
    NSString *basePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) firstObject];
    _dataBase = [[WCTDatabase alloc] initWithPath:[basePath stringByAppendingPathComponent:@"data"]];
    
    BOOL result = [_dataBase createTableAndIndexesOfName:resumeTable withClass:ResumeModel.class];

    [self refreshStauts];
}


- (void)refreshStauts{
    
    NSArray *resumeArray = [_dataBase getObjectsOfClass:ResumeModel.class fromTable:resumeTable orderBy:ResumeModel.keyID.order()];
    if (!resumeArray) {
        _resumeArray = [NSMutableArray array];
    } else {
        _resumeArray = resumeArray.mutableCopy;
    }
    
    NSLog(@"%@", _resumeArray);
}


#pragma mark - userInteraction
- (IBAction)saveBtnClicked:(id)sender {
    
    if (!_nameField.text.length) {
        _statusLabel.text = @"请输入姓名";
        return;
    }
    
    ResumeModel *resumeModel = [ResumeModel new];
    resumeModel.name = _nameField.text;
    resumeModel.age = _ageField.text.integerValue;
    resumeModel.sex = _sexField.text;
    resumeModel.location = _locationField.text;
    
    if (_resumeArray.count) {
        resumeModel.keyID = [_resumeArray.lastObject keyID] + 1;
    } else {
        resumeModel.keyID = 0;
    }
    
    BOOL isSuccess = [_dataBase insertObject:resumeModel into:resumeTable];
    if (isSuccess) {
        [self refreshStauts];
        _statusLabel.text = @"保存成功";
    } else {
        _statusLabel.text = @"保存失败";
    }
}


- (IBAction)delBtnClicked:(id)sender {
    
    if (!_nameField.text.length) {
        _statusLabel.text = @"请输入姓名";
        return;
    }
    
    BOOL isSuccess = [_dataBase deleteObjectsFromTable:resumeTable where:ResumeModel.name == _nameField.text];
    if (isSuccess) {
        [self refreshStauts];
        _statusLabel.text = @"删除成功";
    } else {
        _statusLabel.text = @"删除失败";
    }
}


- (IBAction)enumBtnClicked:(id)sender {
    
    if (_resumeArray.count) {
        
        _statusLabel.text = nil;
        
        [_resumeArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self performSelector:@selector(showWithResume:) withObject:obj afterDelay:idx * 0.5];
        }];
    } else {
        _statusLabel.text = @"没有简历了";
        
        [self performSelector:@selector(showWithResume:) withObject:[ResumeModel new] afterDelay:0];
    }
}


- (void)showWithResume:(ResumeModel *)resumeModel{
    
    _nameField.text = resumeModel.name;
    _ageField.text = [NSString stringWithFormat:@"%zd", resumeModel.age];
    _sexField.text = resumeModel.sex;
    _locationField.text = resumeModel.location;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
