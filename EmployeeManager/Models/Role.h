//
//  Role.h
//  EmployeeManager
//
//  Created by matt rooney on 15/09/2019.
//  Copyright © 2019 matt rooney. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    TeamLead,
    QA,
    SoftwareEngineer
} Role;

@interface RoleUtils : NSObject

+ (NSString *)stringFromRole:(Role)role;
+ (NSArray *)allRoles;

@end

