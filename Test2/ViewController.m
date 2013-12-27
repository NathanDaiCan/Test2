//
//  ViewController.m
//  Test1
//
//  Created by RongHuan Li on 13-12-18.
//  Copyright (c) 2013年 AdaoStudio. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

//static NSString *TableViewCellIdentifier = @"MyCells";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *allRows;

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib
    
    self.view.backgroundColor = [UIColor whiteColor];


    
    //////table view///

    
    self.myTableView =
    [[UITableView alloc] initWithFrame:CGRectMake(10, 150, 300, 300)
                                 style:UITableViewStylePlain];
    
    //  [self.myTableView registerClass:[UITableViewCell class]
    //          forCellReuseIdentifier:TableViewCellIdentifier];
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
    /* Make sure our table view resizes correctly */
    self.myTableView.autoresizingMask =
    UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:self.myTableView];
    
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger result = 0;
    if ([tableView isEqual:self.myTableView])
    {
        result = 1;
    }
    return result;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger result = 0;
    if ([tableView isEqual:self.myTableView]){
        result=self.allRows.count;
        }
    return result;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *result = nil;
    if ([tableView isEqual:self.myTableView]){
        static NSString *TableViewCellIdentifier = @"MyCells";
        result = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
        if (result == nil){
            result = [[UITableViewCell alloc]
                      
                      initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableViewCellIdentifier ];
            
            result.textLabel.text = [NSString stringWithFormat:@"Section %ld, Cell %ld",
                                     (long)indexPath.section,
                                     (long)indexPath.row];
        }
    }

    
    
    
    return result;
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
    
}



- (void) setEditing:(BOOL)editing
           animated:(BOOL)animated{
    
    [super setEditing:editing
             animated:animated];
    
    [self.myTableView setEditing:editing
                        animated:animated];
    
    
}

- (void)  tableView:(UITableView *)tableView
 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
  forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        
        /* First remove this object from the source */
        NSLog(@"done");
        [self.allRows removeObjectAtIndex:indexPath.row];
        
        /* Then remove the associated cell from the Table View */
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationLeft];
        
        
    }
    
}

- (NSMutableArray *) allRows{
    if (_allRows == nil){
        const NSUInteger numberOfItems = 10;
        _allRows = [[NSMutableArray alloc] initWithCapacity:numberOfItems];
        
        for (NSUInteger counter = 0;
             counter < numberOfItems;
             counter++){
            
            [_allRows addObject:
             [[NSString alloc] initWithFormat:@"Cell Item At Index of %lu",
              (unsigned long)counter]];
            
        }
    }
    return _allRows;
}


    
    



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
