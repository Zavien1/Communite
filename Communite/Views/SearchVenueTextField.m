//
//  SearchVenueTextField.m
//  Communite
//
//  Created by Zavien Sibilia on 7/22/21.
//

#import "SearchVenueTextField.h"
#import "HostEventViewController.h"

@implementation SearchVenueTextField 

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview: newSuperview];
    
    HostEventViewController *hostEventViewController;
    
    self.venuesArray = hostEventViewController.venuesArray;
    NSLog(@"hello");
    NSLog(@"%@", self.venuesArray);
    
    [self addTarget:self action:@selector(textFieldDidChange)  forControlEvents:UIControlEventEditingChanged];
    [self addTarget:self action:@selector(textFieldDidBeginEditing)  forControlEvents:UIControlEventEditingChanged];
    [self addTarget:self action:@selector(textFieldDidEndEditing)  forControlEvents:UIControlEventEditingChanged];
    [self addTarget:self action:@selector(textFieldDidEndEditingOnExit)  forControlEvents:UIControlEventEditingChanged];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self buildSearchTable];
}

- (void)textFieldDidChange{
    NSLog(@"text is changing");
    [self filter];
    [self updateSearchTable];
    self.tableView.isHidden;
}

- (void)textFieldDidBeginEditing{
    
}

- (void)textFieldDidEndEditing{
    
}

- (void)textFieldDidEndEditingOnExit{
    
}

- (void)filter{
    
}

- (void)buildSearchTable{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.window addSubview:self.tableView];
    
    [self updateSearchTable];
}

- (void)updateSearchTable{
    
    if(self.tableView == self.tableView){
        [super bringSubviewToFront:self.tableView];
        CGFloat tableHeight = 0;
        tableHeight = self.tableView.contentSize.height;
        
        // Set a bottom margin of 10p
        if(tableHeight < self.tableView.contentSize.height){
            tableHeight -= 10;
        }
        
        // Set tableView frame
        CGRect tableViewFrame = CGRectMake(0, 0, self.frame.size.width - 4, tableHeight);
        tableViewFrame.origin = [self convertPoint:tableViewFrame.origin toView:nil];
        tableViewFrame.origin.x += 2;
        tableViewFrame.origin.y += self.frame.size.height + 2;
        [UIView animateWithDuration:0.2 animations:^{
            self.tableView.frame = tableViewFrame;
        }];
        
        //Setting tableView style
         self.tableView.layer.masksToBounds = true;
         self.tableView.separatorInset = UIEdgeInsetsZero;
         self.tableView.layer.cornerRadius = 5.0;
         self.tableView.separatorColor = [UIColor lightGrayColor];
        self.tableView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        
        if(self.isFirstResponder){
            [super bringSubviewToFront:self];
        }
        [self.tableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //TODO: return filtered results
    return self.venuesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SearchTextFieldCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.clearColor;
    cell.textLabel.attributedText = @"hello";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.text = self.venuesArray[indexPath.row];
    [self.tableView isHidden];
    [self endEditing:true];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
