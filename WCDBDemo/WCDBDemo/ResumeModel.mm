//
//  ResumeModel.m
//  WCDBDemo
//
//  Created by 张骏 on 2017/9/14.
//  Copyright © 2017年 ZJ. All rights reserved.
//

#import "ResumeModel.h"
#import <WCDB.h>

@implementation ResumeModel


WCDB_IMPLEMENTATION(ResumeModel)
WCDB_SYNTHESIZE(ResumeModel, name)
WCDB_SYNTHESIZE(ResumeModel, age)
WCDB_SYNTHESIZE(ResumeModel, sex)
WCDB_SYNTHESIZE(ResumeModel, location)
WCDB_SYNTHESIZE(ResumeModel, keyID)

WCDB_PRIMARY(ResumeModel, keyID)

 
@end
