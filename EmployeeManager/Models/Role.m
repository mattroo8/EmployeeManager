//
//  Role.m
//  EmployeeManager
//
//  Created by matt rooney on 15/09/2019.
//  Copyright © 2019 matt rooney. All rights reserved.
//
#import "Role.h"

@implementation RoleUtils

+ (NSString *)stringFromRole:(Role)role {
    switch (role) {
        case TeamLead:
            return @"Team Lead";
            break;
        case QA:
            return @"QA";
            break;
        case SoftwareEngineer:
            return @"Software Engineer";
        default:
            return @"Not found";
            break;
    }
}

+ (NSArray *)allRoles {
    return [NSArray arrayWithObjects:
            [NSNumber numberWithInt:TeamLead],
            [NSNumber numberWithInt:QA],
            [NSNumber numberWithInt:SoftwareEngineer], nil];;
}

@end

