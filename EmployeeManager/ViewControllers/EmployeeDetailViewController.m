//
//  EmployeeDetailViewController.m
//  EmployeeManager
//
//  Created by matt rooney on 15/09/2019.
//  Copyright © 2019 matt rooney. All rights reserved.
//

#import "EmployeeDetailViewController.h"
#import "Role.h"

@interface EmployeeDetailViewController () <UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) Employee *employee;
@property (weak, nonatomic) id<EmployeeDetailViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *employeeImageView;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *dobTextField;
@property (weak, nonatomic) IBOutlet UITextField *roleTextField;
@property (strong, nonatomic) UIPickerView *rolePickerView;
@property (strong, nonatomic) UIDatePicker *dateOfBirthPicker;

@end

@implementation EmployeeDetailViewController

-(instancetype)initWithDelegate:(id<EmployeeDetailViewControllerDelegate>)delegate
                    andEmployee:(Employee *)employee {
    if(self = [super init]){
        self.delegate = delegate;
        self.employee = employee;
    }
    return self;
}

#pragma mark ViewController lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.employee == nil){
        self.employee = [Employee new];
        self.employee.id = [[NSUUID UUID] UUIDString];
        self.title = @"Add Employee";
    } else {
        self.title = [NSString stringWithFormat:@"%@ %@", self.employee.firstName, self.employee.lastName];
    }
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(savePressed)];
    [self.navigationItem setRightBarButtonItem:saveButton];
    [self setupRolePickerView];
    [self setupDateOfBirthPicker];
    [self updateScreenForEmployee: self.employee];
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped:)];
    [self.employeeImageView setUserInteractionEnabled:YES];
    [self.employeeImageView addGestureRecognizer:gestureRecognizer];
}

#pragma mark NavigationBar methods

-(void)savePressed {
    [self updateEmployee];
    [self.delegate didSaveEmployee:self.employee];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UIPickerView setup

-(void)setupDateOfBirthPicker {
    self.dateOfBirthPicker = [UIDatePicker new];
    self.dateOfBirthPicker.datePickerMode = UIDatePickerModeDate;
    self.dobTextField.inputView = self.dateOfBirthPicker;
    self.dobTextField.inputAccessoryView = [self makeToolBarWithDoneSelector:@selector(donePressedForDOBPickerView) andCancelSelector:@selector(cancelPressedForDOBPickerView)];
}

-(void)setupRolePickerView {
    self.roleTextField.text = [RoleUtils stringFromRole:TeamLead];
    self.rolePickerView = [UIPickerView new];
    self.rolePickerView.delegate = self;
    self.rolePickerView.dataSource = self;
    self.roleTextField.inputView = self.rolePickerView;
    self.roleTextField.inputAccessoryView = [self makeToolBarWithDoneSelector:@selector(donePressedForPickerView) andCancelSelector:@selector(cancelPressedForPickerView)];
}

#pragma mark ToolBar methods

-(UIToolbar *)makeToolBarWithDoneSelector:(SEL)doneSelector andCancelSelector:(SEL)cancelSelector {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 44)];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:doneSelector];
    UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:cancelSelector];
    [toolBar setItems:@[cancelButton, spaceButton, doneButton] animated:NO];
    return toolBar;
}

-(void)donePressedForDOBPickerView {
    self.employee.dob = self.dateOfBirthPicker.date;
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    self.dobTextField.text = [dateFormatter stringFromDate:self.employee.dob];
    [self.dobTextField endEditing:YES];
}

-(void)cancelPressedForDOBPickerView {
    [self.dobTextField endEditing:YES];
}

-(void)donePressedForPickerView {
    self.employee.role = (Role)[self.rolePickerView selectedRowInComponent:0];
    self.roleTextField.text = [RoleUtils stringFromRole:self.employee.role];
    [self.roleTextField endEditing:YES];
}

-(void)cancelPressedForPickerView {
    [self.roleTextField endEditing:YES];
}

#pragma mark PickerViewDelegate methods

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [RoleUtils allRoles].count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    Role role = (Role)[[[RoleUtils allRoles] objectAtIndex:row] intValue];
    return [RoleUtils stringFromRole:role];
}

-(void)imageViewTapped:(UITapGestureRecognizer *)tapGesture {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)updateScreenForEmployee:(Employee *)employee {
    self.firstNameTextField.text = employee.firstName;
    self.lastNameTextField.text = employee.lastName;
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    self.dobTextField.text = [dateFormatter stringFromDate:employee.dob];
    self.roleTextField.text = [RoleUtils stringFromRole:employee.role];
}

-(void)updateEmployee {
    self.employee.firstName = self.firstNameTextField.text;
    self.employee.lastName = self.lastNameTextField.text;
}

@end
