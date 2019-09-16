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

@interface EmployeeListViewController () <UITableViewDelegate, UITableViewDataSource, EmployeeDetailViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<Employee *> *employees;

@end

@implementation EmployeeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.title = @"Employees";
    self.employees = [[NSMutableArray alloc] initWithArray:[Employee testEmployees]];
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
    Employee *employee = [self.employees objectAtIndex:indexPath.row];
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
    return self.employees.count;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    Employee *employee = [self.employees objectAtIndex:indexPath.row];
    EmployeeDetailViewController *employeeDetailViewController = [[EmployeeDetailViewController alloc] initWithDelegate:self andEmployee:employee];
    [self.navigationController pushViewController:employeeDetailViewController animated:YES];
}

#pragma mark EmployeeDetailDelegate methods

-(void)didSaveEmployee:(Employee *)employee {
    BOOL employeeExists = NO;
    for (int i = 0; i < self.employees.count; i++) {
        Employee *employeeInlist = [self.employees objectAtIndex:i];
        if(employeeInlist.id == employee.id) {
            employeeInlist.firstName = employee.firstName;
            employeeInlist.lastName = employee.lastName;
            employeeInlist.dob = employee.dob;
            employeeInlist.role = employee.role;
            employeeExists = true;
            break;
        }
    }
    if(!employeeExists){
        [self.employees addObject:employee];
    }
    [self.tableView reloadData];
}

@end
