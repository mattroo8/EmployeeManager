//
//  EmployeeListSection.h
//  EmployeeManager
//
//  Created by matt rooney on 17/09/2019.
//  Copyright © 2019 matt rooney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Role.h"
#import "Employee.h"

@interface EmployeeListSection : NSObject

@property Role role;
@property (strong, nonatomic) NSMutableArray<Employee *> *employees;

- (instancetype)initWithRole:(Role)role andEmployees:(NSMutableArray *)employees;

@end
