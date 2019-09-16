//
//  EmployeeDetailViewController.h
//  EmployeeManager
//
//  Created by matt rooney on 15/09/2019.
//  Copyright © 2019 matt rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Employee.h"

@protocol EmployeeDetailViewControllerDelegate <NSObject>

-(void)didSaveEmployee:(Employee *)employee;

@end

@interface EmployeeDetailViewController : UIViewController

-(instancetype)initWithDelegate:(id<EmployeeDetailViewControllerDelegate>)delegate andEmployee:(Employee *)employee;

@end
