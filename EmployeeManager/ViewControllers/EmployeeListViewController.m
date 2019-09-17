//
//  EmployeeListViewController.m
//  EmployeeManager
//
//  Created by matt rooney on 15/09/2019.
//  Copyright © 2019 matt rooney. All rights reserved.
//

#import "EmployeeListViewController.h"
#import "Employee.h"
#import "Employee+TestData.h"
#import "EmployeeDetailViewController.h"
#import "EmployeeListSection.h"

@interface EmployeeListViewController () <UITableViewDelegate, UITableViewDataSource, EmployeeDetailViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<EmployeeListSection *> *employeeSections;

@end

@implementation EmployeeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.title = @"Employees";
    self.employeeSections = [Employee testEmployees];
    [self setupNavBar];
}

#pragma mark UINavigationBar methods

-(void)setupNavBar {
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPressed)];
    self.navigationItem.rightBarButtonItem = addButton;
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editPressed)];
    self.navigationItem.leftBarButtonItem = editButton;
}

-(void)addPressed {
    EmployeeDetailViewController *employeeDetailViewController = [[EmployeeDetailViewController alloc] initWithDelegate:self andEmployee:nil];
    [self.navigationController pushViewController:employeeDetailViewController animated:YES];
}

-(void)editPressed {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePressed)];
    self.tableView.editing = YES;
}

-(void)donePressed {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editPressed)];
    self.tableView.editing = NO;
}

#pragma mark TableView Delegate methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    EmployeeListSection *section = [self.employeeSections objectAtIndex:indexPath.section];
    Employee *employee = [section.employees objectAtIndex:indexPath.row];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", employee.firstName, employee.lastName];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    cell.detailTextLabel.text = [dateFormatter stringFromDate:employee.dob];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    EmployeeListSection *employeeSection = [self.employeeSections objectAtIndex:section];
    return employeeSection.employees.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.employeeSections.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    EmployeeListSection *employeeSection = [self.employeeSections objectAtIndex:section];
    return [RoleUtils stringFromRole:employeeSection.role];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    EmployeeListSection *section = [self.employeeSections objectAtIndex:indexPath.section];
    Employee *employee = [section.employees objectAtIndex:indexPath.row];
    EmployeeDetailViewController *employeeDetailViewController = [[EmployeeDetailViewController alloc] initWithDelegate:self andEmployee:employee];
    [self.navigationController pushViewController:employeeDetailViewController animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EmployeeListSection *employeeSection = [self.employeeSections objectAtIndex:indexPath.section];
        [tableView beginUpdates];
        [employeeSection.employees removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        if (employeeSection.employees.count == 0) {
            [self.employeeSections removeObjectAtIndex:indexPath.section];
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        }
        [tableView endUpdates];
    }
}

#pragma mark EmployeeDetailDelegate methods

-(void)didSaveEmployee:(Employee *)employee {
    BOOL employeeExists = NO;
    for (EmployeeListSection *section in self.employeeSections){
        for (Employee *employeeInlist in section.employees) {
            if(employeeInlist.id == employee.id) {
                employeeInlist.firstName = employee.firstName;
                employeeInlist.lastName = employee.lastName;
                employeeInlist.dob = employee.dob;
                employeeInlist.role = employee.role;
                employeeExists = true;
                break;
            }
        }
    }
    BOOL createSection = true;
    if(!employeeExists){
        for (EmployeeListSection *section in self.employeeSections) {
            if(section.role == employee.role){
                createSection = false;
                [section.employees addObject:employee];
            }
        }
    }
    if(createSection){
        EmployeeListSection *newSection = [[EmployeeListSection alloc] initWithRole:employee.role andEmployees:[[NSMutableArray alloc] initWithArray:@[employee]]];
        [self.employeeSections addObject:newSection];
    }
    [self.tableView reloadData];
}

@end
