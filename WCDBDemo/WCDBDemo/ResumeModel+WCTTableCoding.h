//
//  ResumeModel+WCTTableCoding.h
//  WCDBDemo
//
//  Created by 张骏 on 2017/9/14.
//  Copyright © 2017年 ZJ. All rights reserved.
//

#import "ResumeModel.h"
#import <WCDB.h>

@interface ResumeModel (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(keyID)
WCDB_PROPERTY(name)
WCDB_PROPERTY(age)
WCDB_PROPERTY(sex)
WCDB_PROPERTY(location)


@end
