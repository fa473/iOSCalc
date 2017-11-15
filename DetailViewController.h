//
//  DetailViewController.h
//  
//
//  Created by Francis Arocha on 11/26/16.
//  Copyright © 2016 Francis Arocha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "homework3+CoreDataModel.h"

@interface DetailViewController : UIViewController <UITextFieldDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) Course *detailItem;

@property (weak, nonatomic) IBOutlet UITextField *courseField;
@property (weak, nonatomic) IBOutlet UITextField *hwScoreField;
@property (weak, nonatomic) IBOutlet UITextField *hwWeightField;
@property (weak, nonatomic) IBOutlet UITextField *midtermScoreField;
@property (weak, nonatomic) IBOutlet UITextField *midtermWeightField;
@property (weak, nonatomic) IBOutlet UITextField *finalScoreField;
@property (weak, nonatomic) IBOutlet UITextField *finalWeightField;
@property (weak, nonatomic) IBOutlet UITextField *courseGradeField;

- (IBAction)calculateScore:(id)sender;


@end

