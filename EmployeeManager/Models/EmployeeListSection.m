//
//  EmployeeListSection.m
//  EmployeeManager
//
//  Created by matt rooney on 17/09/2019.
//  Copyright © 2019 matt rooney. All rights reserved.
//

#import "EmployeeListSection.h"

@implementation EmployeeListSection

- (instancetype)initWithRole:(Role)role andEmployees:(NSMutableArray *)employees
{
    self = [super init];
    if (self) {
        self.role = role;
        self.employees = employees;
    }
    return self;
}

@end
