//
//  Employee.m
//  EmployeeManager
//
//  Created by matt rooney on 15/09/2019.
//  Copyright © 2019 matt rooney. All rights reserved.
//

#import "Employee.h"

@implementation Employee

- (instancetype)initWithFirstName:(NSString *)firstName
                     andLastName:(NSString *)lastName
                          andDob:(NSDate *)dob
                         andRole:(Role)role
                            andId:(NSString *)id {
    if(self = [super init]) {
        self.firstName = firstName;
        self.lastName = lastName;
        self.dob = dob;
        self.role = role;
        self.id = id;
    }
    return self;
}

@end
