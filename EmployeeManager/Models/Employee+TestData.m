//
//  Employee+TestData.m
//  EmployeeManager
//
//  Created by matt rooney on 16/09/2019.
//  Copyright © 2019 matt rooney. All rights reserved.
//

#import "Employee+TestData.h"
#import "EmployeeListSection.h"

@implementation Employee (TestData)

+(NSMutableArray *)testEmployees {
    
    
    Employee *employee1 = [[Employee alloc] initWithFirstName:@"Matt"
                                                   andLastName:@"Rooney"
                                                        andDob:[NSDate new]
                                                       andRole:TeamLead
                                                         andId:[[NSUUID UUID] UUIDString]];
    
    Employee *employee2 = [[Employee alloc] initWithFirstName:@"Shane"
                                                 andLastName:@"Murphy"
                                                      andDob:[NSDate new]
                                                     andRole:TeamLead
                                                        andId:[[NSUUID UUID] UUIDString]];
                           
    Employee *employee3 = [[Employee alloc] initWithFirstName:@"Dylan"
                                                 andLastName:@"Kilbride"
                                                      andDob:[NSDate new]
                                                     andRole:SoftwareEngineer
                                                        andId:[[NSUUID UUID] UUIDString]];

    Employee *employee4 = [[Employee alloc] initWithFirstName:@"Jeff"
                                                 andLastName:@"Reyes"
                                                      andDob:[NSDate new]
                                                     andRole:QA
                                                        andId:[[NSUUID UUID] UUIDString]];
                           
    Employee *employee5 = [[Employee alloc] initWithFirstName:@"Tomas"
                                                 andLastName:@"Gabor"
                                                      andDob:[NSDate new]
                                                     andRole:SoftwareEngineer
                                                        andId:[[NSUUID UUID] UUIDString]];
    NSMutableArray *sections = [NSMutableArray new];
    [sections addObject:[[EmployeeListSection alloc] initWithRole:TeamLead
                                                     andEmployees:[[NSMutableArray alloc] initWithArray:@[employee1, employee2]]]];
    [sections addObject:[[EmployeeListSection alloc] initWithRole:SoftwareEngineer
                                                     andEmployees:[[NSMutableArray alloc] initWithArray:@[employee3, employee5]]]];
    [sections addObject:[[EmployeeListSection alloc] initWithRole:QA
                                                     andEmployees:[[NSMutableArray alloc] initWithArray:@[employee4]]]];
    return sections;
}

@end
