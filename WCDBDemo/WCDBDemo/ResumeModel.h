//
//  ResumeModel.h
//  WCDBDemo
//
//  Created by 张骏 on 2017/9/14.
//  Copyright © 2017年 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResumeModel : NSObject

/**
 姓名
 */
@property (nonatomic, copy) NSString *name;

/**
 年龄
 */
@property (nonatomic, assign) NSInteger age;

/**
 性别
 */
@property (nonatomic, copy) NSString *sex;

/**
 位置
 */
@property (nonatomic, copy) NSString *location;

/**
 主键
 */
@property (nonatomic, assign) NSInteger keyID;

@end
