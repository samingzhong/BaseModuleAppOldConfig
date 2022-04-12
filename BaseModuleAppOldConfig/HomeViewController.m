//
//  HomeViewController.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxm on 2022/4/12.
//

#import "HomeViewController.h"
#import "Masonry.h"
#import "UIView+randomBGColor.h"
#import "TableViewCellTypeA.h"


typedef NS_ENUM(NSInteger, CellType) {
    CellTypeA = 0,
};



@interface HomeViewController () < UITableViewDelegate, UITableViewDataSource >
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}


- (void)setupUI {
    UIView *headerView = UIView.new;
    [headerView setRandomBGColor];
    [self.view addSubview:headerView];
    
    [self.view addSubview:self.tableView];
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            // Fallback on earlier versions
            make.top.mas_equalTo(self.view.mas_top);
        };
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerView.mas_bottom);
        make.left.right.mas_equalTo(headerView);
        make.bottom.mas_equalTo(0);
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeightForType(CellTypeA);
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"typeA";
    TableViewCellTypeA *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    // config cell
//    cell.textLabel.text = @(indexPath.row).stringValue;
    
    return cell;
}



CGFloat cellHeightForType(CellType type) {
    switch (type) {
        case CellTypeA:
            return 150;
            break;
            
        default:
            break;
    }
}




- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setRandomBGColor];
        
        [_tableView registerClass:TableViewCellTypeA.class forCellReuseIdentifier:@"typeA"];
    }
    
    return _tableView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
