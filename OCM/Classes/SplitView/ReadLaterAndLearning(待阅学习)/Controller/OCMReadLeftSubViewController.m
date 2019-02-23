//
//  OCMReadSubViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/1.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMReadLeftSubViewController.h"
#import "ReadLeftTableViewCell.h"
#import "ReadLeftSubItem.h"

@interface OCMReadLeftSubViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UISearchBar *searchBar;
@property (nonatomic,strong)ReadLeftTableViewCell *readLeftCell;
@property (nonatomic,strong)NSArray *dataArr;
@property (nonatomic,assign)BOOL isShowSubCell;
@end

@implementation OCMReadLeftSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self setUpUI];
    [self endEditing];
    [self initData];
}
- (void)initData {
    _isShowSubCell = NO;
    NSArray *arr = @[
                    @{
                        @"bigTitle":@"早会内容",@"isParentCell":@"YES"
                        },
                    @{
                        @"bigTitle":@"早会内容",@"title":@"开会内容.....111......",@"auther":@"佚名作者",@"dateStr":@"2017-12-5 12:30:23",@"subCell":@"YES"
                        },
                    @{
                        @"bigTitle":@"早会内容",@"title":@"开会内容.....222......",@"auther":@"佚名作者",@"dateStr":@"2017-12-5 12:30:23",@"subCell":@"YES"
                        },
                    @{
                        @"bigTitle":@"早会内容",@"title":@"开会内容......333.....",@"auther":@"佚名作者",@"dateStr":@"2017-12-5 12:30:23",@"subCell":@"YES"
                        },
                    @{
                        @"bigTitle":@"工作内容",@"isParentCell":@"YES"
                        },
                    @{
                        @"bigTitle":@"工作内容",@"title":@"工作内容......555.....",@"auther":@"佚名作者",@"dateStr":@"2017-12-5 12:30:23",@"subCell":@"YES"
                        },
                    @{
                        @"bigTitle":@"工作内容",@"title":@"工作内容......666.....",@"auther":@"佚名作者",@"dateStr":@"2017-12-5 12:30:23",@"subCell":@"YES"
                        },
                    @{
                        @"bigTitle":@"休息内容",@"isParentCell":@"YES"
                        },
                    @{
                        @"bigTitle":@"休息内容",@"title":@"休息内容......777.....",@"auther":@"佚名作者",@"dateStr":@"2017-12-5 12:30:23",@"subCell":@"YES"
                        },
                    @{
                        @"bigTitle":@"休息内容",@"title":@"休息内容......888.....",@"auther":@"佚名作者",@"dateStr":@"2017-12-5 12:30:23",@"subCell":@"YES"
                        },
                    ];
    NSMutableArray *mutableArr = [NSMutableArray new];
    for (NSDictionary *dict in arr) {
        ReadLeftSubItem *item = [ReadLeftSubItem itemWithDict:dict];
        [mutableArr addObject:item];
    }
    _dataArr = mutableArr.mutableCopy;
}
- (void)setUpUI {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 200, self.view.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
#pragma mark -- 点击背景收回键盘
- (void)endEditing {
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignKeyBoard)];
    tapGes.delegate = self;
    [self.view addGestureRecognizer:tapGes];
}
- (void)resignKeyBoard {
    [_searchBar resignFirstResponder];
}
#pragma mark -- UIGestureRecognizerDelegate
//如果是tableviewcell,拦截触摸事件
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}
#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

static NSString *ID = @"cell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReadLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ReadLeftTableViewCell alloc] initWithStyle:0 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    cell.item = _dataArr[indexPath.row];
    if (!cell.item.isParentCell && cell.item.subCell) { //点击了大标题,改变大标题下的子cell的显示状态
        cell.hidden = YES;
    } else if (!cell.item.isParentCell && !cell.item.subCell) {//点击了大标题,改变大标题下的子cell的显示状态
        cell.hidden = NO;
    } else {
        cell.backgroundColor = [UIColor grayColor];
    }
    return  cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReadLeftSubItem *item = _dataArr[indexPath.row];
    if (!item.isParentCell && item.subCell){
        return 0;
    } else if (!item.isParentCell && !item.subCell){
        return 100;
    } else {
        return 44;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
        _searchBar.delegate = self;
        return _searchBar;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ReadLeftSubItem *item = _dataArr[indexPath.row];
    if (!item.isParentCell) {
        
    } else {
        BOOL isOpen = NO;
        for (ReadLeftSubItem *subItem in _dataArr) {
            if ([item.bigTitle isEqualToString:subItem.bigTitle]) {
                if (!subItem.isParentCell) {
                    subItem.subCell = !subItem.subCell;
                    isOpen = subItem.subCell;
                }
            }
        }
        ReadLeftTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (isOpen) cell.iconView.transform = CGAffineTransformRotate(cell.iconView.transform, M_PI_2);
        else cell.iconView.transform = CGAffineTransformRotate(cell.iconView.transform, -M_PI_2);
        [self.tableView reloadData];
    }
}
#pragma mark -- UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    // called when text starts editing
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    OCMLog(@"searchBarTextDidEndEditing");
    // called when text ends editing
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    OCMLog(@"textDidChange");
    // called when text changes (including clear)
}
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0) {
    return YES;
    // called before text changes
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    OCMLog(@"searchBarSearchButtonClicked");
    [self.searchBar resignFirstResponder];
    // called when keyboard search button pressed
}
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED {
    OCMLog(@"searchBarBookmarkButtonClicked");
    // called when bookmark button pressed
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED {
    OCMLog(@"searchBarCancelButtonClicked");
    // called when cancel button pressed
}
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar NS_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED {
    OCMLog(@"searchBarResultsListButtonClicked");
} // called when search results button pressed

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope NS_AVAILABLE_IOS(3_0) {
    OCMLog(@"selectedScopeButtonIndexDidChange");
}
#pragma mark -- dealloc
- (void)dealloc {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
