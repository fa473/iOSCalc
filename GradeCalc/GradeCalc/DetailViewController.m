//
//  DetailViewController.m
//  
//
//  Created by Francis Arocha on 11/26/16.
//  Copyright © 2016 Francis Arocha. All rights reserved.
//
#import "DetailViewController.h"


@interface DetailViewController ()

@end

@implementation DetailViewController



- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.courseField.text = self.detailItem.courseID;
        
        //create Strings out of float values
        NSString *hwScoreString = [NSString stringWithFormat:@"%.02f", self.detailItem.avgHWScore];
        NSString *hwWeightString = [NSString stringWithFormat:@"%.02f", self.detailItem.hwWeight];
        NSString *midtermScoreString = [NSString stringWithFormat:@"%.02f", self.detailItem.midtermScore];
        NSString *midtermWeightString = [NSString stringWithFormat:@"%.02f", self.detailItem.midtermWeight];
        NSString *finalScoreString = [NSString stringWithFormat:@"%.02f", self.detailItem.finalScore];
        NSString *finalWeightString = [NSString stringWithFormat:@"%.02f", self.detailItem.finalWeight];
        NSString *courseScoreString = [NSString stringWithFormat:@"%.02f", self.detailItem.score];
        
        //display strings in text fields
        self.hwScoreField.text = hwScoreString;
        self.hwWeightField.text = hwWeightString;
        self.midtermScoreField.text = midtermScoreString;
        self.midtermWeightField.text = midtermWeightString;
        self.finalScoreField.text = finalScoreString;
        self.finalWeightField.text = finalWeightString;
        self.courseGradeField.text = courseScoreString;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    //create "Calculate" button to appear over decimal keypad
    UIButton *calculateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [calculateBtn addTarget:self action:@selector(calculateScore) forControlEvents:UIControlEventTouchUpInside];
    [calculateBtn setTitle:@"Calculate" forState:UIControlStateNormal];
    calculateBtn.backgroundColor = [UIColor orangeColor];
    [calculateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    calculateBtn.frame = CGRectMake(0, 0, self.view.frame.size.width, 60);
    
    self.hwScoreField.inputAccessoryView = calculateBtn;
    self.hwWeightField.inputAccessoryView = calculateBtn;
    self.midtermScoreField.inputAccessoryView = calculateBtn;
    self.midtermWeightField.inputAccessoryView = calculateBtn;
    self.finalScoreField.inputAccessoryView = calculateBtn;
    self.finalWeightField.inputAccessoryView = calculateBtn;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(Course *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

//make the number pad disappear when the user touches anywhere outside a textfield
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.courseField resignFirstResponder];
    [self.hwScoreField resignFirstResponder];
    [self.hwWeightField resignFirstResponder];
    [self.midtermScoreField resignFirstResponder];
    [self.midtermWeightField resignFirstResponder];
    [self.finalScoreField resignFirstResponder];
    [self.finalWeightField resignFirstResponder];
}


- (void)calculateScore {
    //dismiss keyboard
    [self.view endEditing:true];
    
    //convert strings into float values
    float avgHWScore = [self.hwScoreField.text floatValue];
    float hwWeight = [self.hwWeightField.text floatValue];
    float midtermScore = [self.midtermScoreField.text floatValue];
    float midtermWeight = [self.midtermWeightField.text floatValue];
    float finalScore = [self.finalScoreField.text floatValue];
    float finalWeight = [self.finalWeightField.text floatValue];
    
    //course grade calculations
    float hwGrade = avgHWScore * hwWeight;
    float midtermGrade = midtermScore * midtermWeight;
    float finalGrade = finalScore * finalWeight;
    float courseGrade = hwGrade + midtermGrade + finalGrade;
    
    //display grade in textfield
    NSString* formattedGrade = [NSString stringWithFormat:@"%.02f", courseGrade];
    self.courseGradeField.text = formattedGrade;
    
    //update object attributes
    self.detailItem.courseID = self.courseField.text;
    self.detailItem.avgHWScore = avgHWScore;
    self.detailItem.hwWeight = hwWeight;
    self.detailItem.midtermScore = midtermScore;
    self.detailItem.midtermWeight = midtermWeight;
    self.detailItem.finalScore = finalScore;
    self.detailItem.finalWeight = finalWeight;
    self.detailItem.score = courseGrade;
    
    //save object
    NSError *error = nil;
    if (![self.detailItem.managedObjectContext save:&error]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    
    /*---- The following code is to simulate the user tapping the "Calculate" button twice----
     *---- Reason: without this section there is a bug where a new course would not have -----
     *---- its information updated if it was not to be the first course in the list ---------------*/
    
    //convert strings into float values
     avgHWScore = [self.hwScoreField.text floatValue];
     hwWeight = [self.hwWeightField.text floatValue];
     midtermScore = [self.midtermScoreField.text floatValue];
     midtermWeight = [self.midtermWeightField.text floatValue];
     finalScore = [self.finalScoreField.text floatValue];
     finalWeight = [self.finalWeightField.text floatValue];
    
    //course grade calculations
     hwGrade = avgHWScore * hwWeight;
     midtermGrade = midtermScore * midtermWeight;
     finalGrade = finalScore * finalWeight;
     courseGrade = hwGrade + midtermGrade + finalGrade;
    
    //display grade in textfield
     formattedGrade = [NSString stringWithFormat:@"%.02f", courseGrade];
    self.courseGradeField.text = formattedGrade;
    
    //update object attributes
    self.detailItem.courseID = self.courseField.text;
    self.detailItem.avgHWScore = avgHWScore;
    self.detailItem.hwWeight = hwWeight;
    self.detailItem.midtermScore = midtermScore;
    self.detailItem.midtermWeight = midtermWeight;
    self.detailItem.finalScore = finalScore;
    self.detailItem.finalWeight = finalWeight;
    self.detailItem.score = courseGrade;
    
    //save object
    error = nil;
    if (![self.detailItem.managedObjectContext save:&error]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }

}
@end
