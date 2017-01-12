//
//  SearchCVC.m
//  TRProject
//
//  Created by Jian on 2016/12/2.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "SearchCVC.h"
#import "SearchModel.h"
#import "OnLineCell.h"
#import "RoomVC.h"

#define kWeakSelf __weak SearchCVC *weakSelf = self;
#define kAnimationTime .5


@interface SearchCVC ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) UIView* topView;
@property (nonatomic) UITextField* searchTF;
@property (nonatomic) NSMutableArray<DataItemsModel*>* allSearchResults;
@property (nonatomic) NSInteger page;
@property (nonatomic) UITableView* historyTableView;
@property (nonatomic) UIView* backView;
/**记录搜索历史记录*/
@property (nonatomic) NSMutableArray* historyMuArr;
@end

@implementation SearchCVC

#pragma mark - Lazy

-(UIView *)topView
{
    if(!_topView)
    {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW - 100, 30)];
        _topView.backgroundColor = kRGBA(249, 249, 249, 1);
        _topView.layer.cornerRadius = 15;
        _topView.clipsToBounds = YES;
        _topView.layer.borderColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0].CGColor;
        _topView.layer.borderWidth = 1;
        self.navigationItem.titleView = _topView;
    }
    return _topView;
}

-(UITextField *)searchTF
{
    if (!_searchTF)
    {
        _searchTF = [[UITextField alloc] init];
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        leftView.image = [UIImage imageNamed:@"searchBar_search_icon_20x20_"];
        _searchTF.font = [UIFont systemFontOfSize:15];
        _searchTF.placeholder = @"请输入主播/房间号";
        _searchTF.leftView = leftView;
        _searchTF.leftViewMode = UITextFieldViewModeAlways;
        _searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTF.returnKeyType = UIReturnKeySearch;
        _searchTF.delegate = self;
        [_searchTF addTarget:self action:@selector(clickSearchBtn) forControlEvents:UIControlEventEditingDidEndOnExit];
        [_searchTF becomeFirstResponder];
        [self.topView addSubview:_searchTF];
        [_searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
            make.left.equalTo(10);
            make.right.equalTo(-10);
        }];
    }
    return _searchTF;
}

-(NSMutableArray<DataItemsModel *> *)allSearchResults
{
    if (!_allSearchResults)
    {
        _allSearchResults = [NSMutableArray array];
    }
    return _allSearchResults;
}

-(UIView *)backView
{
    if (!_backView)
    {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 64)];
        _backView.backgroundColor = [UIColor colorWithRGB:0 alpha:0.3];
        [self.view addSubview:_backView];
        kWeakSelf
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            [weakSelf.searchTF endEditing:YES];
        }];
        tap.cancelsTouchesInView = NO;
        [_backView addGestureRecognizer:tap];
    }
    return _backView;
}

-(UITableView *)historyTableView
{
    if (!_historyTableView)
    {
        _historyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 0)];
        _historyTableView.delegate = self;
        _historyTableView.dataSource = self;
        [_historyTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _historyTableView.tableFooterView = [UIView new];
        _historyTableView.bounces = NO;
    
        [self.view addSubview:_historyTableView];
    }
    return _historyTableView;
}



-(NSMutableArray *)historyMuArr
{
    if (!_historyMuArr)
    {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSArray *tmpArr = [user objectForKey:@"searchHistoryArr"];
        _historyMuArr = tmpArr.mutableCopy;
        if (!_historyMuArr.count)
        {
            _historyMuArr = [NSMutableArray array];
        }
    }
    return _historyMuArr;
}

static NSString * const reuseIdentifier = @"Cell";

#pragma mark - Life

-(instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    CGFloat width = (long)((MIN(kScreenH, kScreenW) - 30)/2.0);
    CGFloat height = width * 338/576.0 + 35;
    layout.itemSize = CGSizeMake(width, height);
    
    if (self = [super initWithCollectionViewLayout:layout])
    {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor colorWithRed:244/255.0 green:251/255.0 blue:1.0 alpha:1.0];
    [self.collectionView registerClass:[OnLineCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [TRFactrory addBackItemToVC:self];
    kWeakSelf
    [TRFactrory addSearchItemToVC:self WithAction:^{
        [weakSelf clickSearchBtn];
    }];
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self historyMuArr];
    [self searchTF];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.searchTF resignFirstResponder];
    [[NSUserDefaults standardUserDefaults] setObject:_historyMuArr.copy forKey:@"searchHistoryArr"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)dealloc
{
    NSLog(@"SearchCVC dealloc!");
}

-(void)clickSearchBtn
{
    [self.searchTF resignFirstResponder];
    if(!self.searchTF.text.length) return;
    
    for (NSInteger i = 0; i < self.historyMuArr.count; i++)
    {
        if ([_historyMuArr[i] isEqualToString:_searchTF.text])
        {
            [_historyMuArr removeObjectAtIndex:i];
        }
    }
    
    [_historyMuArr insertObject:self.searchTF.text atIndex:0];
    
    [self.view showLoadPic];
    [NetManager postSearchDataWithKey:self.searchTF.text Page:0 CompletionHandler:^(SearchModel *model, NSError *error) {
        if (!error)
        {
            [self.view hideHUD];
            if (!model.data.items.count)
            {
                [self.view showMsg:@"根据相关法律法规，搜索不到相关内容!"];
                [self.allSearchResults removeAllObjects];
                [self.collectionView reloadData];
            }
            else
            {
                [self.allSearchResults removeAllObjects];
                [self.allSearchResults addObjectsFromArray:model.data.items];
                [self.collectionView reloadData];
                self.page = 0;
            }
        }
    }];
    
    MJWeakSelf
    [self.collectionView addFooterRefresh:^{
        [NetManager postSearchDataWithKey:weakSelf.searchTF.text Page:weakSelf.page + 1 CompletionHandler:^(SearchModel *model, NSError *error) {
            [weakSelf.collectionView endFootRefresh];
            if (!error)
            {
                if (!model.data.items.count)
                {
                    [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
                }
                else
                {
                    [weakSelf.allSearchResults addObjectsFromArray:model.data.items];
                    [weakSelf.view showMsg:@"加载完成"];
                    [weakSelf.collectionView reloadData];
                    weakSelf.page += 1;
                }
            }
        }];
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - TextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"didBeginEditing");
    if (_historyMuArr.count)
    {
        self.backView.hidden = NO;
        self.historyTableView.hidden = NO;
        [_historyTableView reloadData];
        [UIView animateWithDuration:kAnimationTime animations:^{
            _historyTableView.frame = CGRectMake(0, 0, kScreenW, (_historyMuArr.count + 1) * 44);
        }];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:kAnimationTime animations:^{
        _historyTableView.frame = CGRectMake(0, 0, kScreenW,0);
    } completion:^(BOOL finished) {
        _historyTableView.hidden = YES;
        _backView.hidden = YES;
    }];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _historyMuArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _historyMuArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [btn setImage:[UIImage imageNamed:@"searchHistory_delete_icon_15x15_"] forState:UIControlStateNormal];
    btn.contentMode = UIViewContentModeScaleAspectFit;
    MJWeakSelf
    [btn bk_addEventHandler:^(id sender) {
        [weakSelf.historyMuArr removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
        if (weakSelf.historyMuArr.count)
        {
            [UIView animateWithDuration:kAnimationTime animations:^{
                weakSelf.historyTableView.frame = CGRectMake(0, 0, kScreenW, (weakSelf.historyMuArr.count + 1) * 44);
            }];
        }
        else
        {
            [weakSelf.searchTF resignFirstResponder];
        }
    } forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryView = btn;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _searchTF.text = _historyMuArr[indexPath.row];
    [self clickSearchBtn];
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.frame = CGRectMake(0, 0, 44, 0);
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = @"历史搜索";
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [btn setImage:[UIImage imageNamed:@"searchResult_clearAll_icon_25x25_"] forState:UIControlStateNormal];
    MJWeakSelf
    [btn bk_addEventHandler:^(id sender) {
        [weakSelf.historyMuArr removeAllObjects];
        [weakSelf.searchTF resignFirstResponder];
    } forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryView = btn;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.allSearchResults.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OnLineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    DataItemsModel *model = self.allSearchResults[indexPath.row];
    
    [cell.thumbIV setImageURL:model.thumb.lzj_toURL];
    
    NSTextAttachment *strAtt = [[NSTextAttachment alloc]init];
    strAtt.image = [UIImage imageNamed:@"player_audienceCount_icon_10x10_"];
    strAtt.bounds = CGRectMake(1, -2, 10, 10);
    NSAttributedString *str1 = [NSAttributedString attributedStringWithAttachment:strAtt];
    
    NSString *text = model.view > 10000 ? [NSString stringWithFormat:@" %.1lf万",model.view/10000.0] : [NSString stringWithFormat:@" %ld",model.view];
    NSAttributedString *str2 = [[NSAttributedString alloc]initWithString:text attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc]init];
    [muStr appendAttributedString:str1];
    [muStr appendAttributedString:str2];
    
    cell.viewLB.attributedText = muStr;
    [cell.avatarIV setImageURL:model.avatar.lzj_toURL];
    cell.nickLB.text = model.nick;
    cell.titleLB.text = model.title;
    
    UITextField *onlineTF = [cell.contentView viewWithTag:10086];
    if (!onlineTF)
    {
        onlineTF = [[UITextField alloc] init];
        onlineTF.tag = 10086;
        onlineTF.text = @"正在直播";
        onlineTF.backgroundColor = kRGBA(45, 160, 253, 1);
        onlineTF.textColor = [UIColor whiteColor];
        onlineTF.font = [UIFont systemFontOfSize:12];
        onlineTF.textAlignment = NSTextAlignmentCenter;
        onlineTF.layer.cornerRadius = 3;
        onlineTF.clipsToBounds = YES;
        [cell.contentView addSubview:onlineTF];
        [onlineTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(0);
        }];
    }
    onlineTF.hidden = !model.play_status;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DataItemsModel *model = self.allSearchResults[indexPath.row];
    RoomVC *rvc = [[RoomVC alloc] initWithUid:model.uid];
    [self.navigationController pushViewController:rvc animated:YES];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
