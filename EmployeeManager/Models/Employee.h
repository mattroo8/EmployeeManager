//
//  Employee.h
//  EmployeeManager
//
//  Created by matt rooney on 15/09/2019.
//  Copyright © 2019 matt rooney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Role.h"

NS_ASSUME_NONNULL_BEGIN

@interface Employee : NSObject

- (instancetype)initWithFirstName:(NSString *)firstName
                     andLastName:(NSString *)lastName
                          andDob:(NSDate *)dob
                         andRole:(Role)role
                            andId:(NSString *)id;

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSDate *dob;
@property (assign, nonatomic) Role role;

@end

NS_ASSUME_NONNULL_END
