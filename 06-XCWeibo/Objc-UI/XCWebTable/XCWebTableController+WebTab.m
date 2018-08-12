//
//  XCWebTableController+WebTab.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/12.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCWebTableController+WebTab.h"



@implementation XCWebTableController (WebTab)

#pragma mark - table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xc_table_cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xc_table_cell"];
    }
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

#pragma mark - table view delegate

#pragma mark - UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.scrollView != scrollView) {
        return;
    }
    CGFloat offsetY = scrollView.contentOffset.y;  /* scrollview的 滑动偏移 */
    
    CGFloat webHeight = self.webView.height;
    CGFloat tabHeight = self.tableView.height;
    
    CGFloat webContentHeight = self.webView.scrollView.contentSize.height;
    CGFloat tabContentHeight = self.tableView.contentSize.height;
    
    if (offsetY <= 0) {   // 最顶部向上滑动
        self.scrollViewContainerView.y = 0;
        self.webView.scrollView.contentOffset = self.tableView.contentOffset = CGPointZero;
    }else if (offsetY < webContentHeight - webHeight){  // web view 内容滚动区间
        self.scrollViewContainerView.y = offsetY;
        self.webView.scrollView.contentOffset = CGPointMake(0, offsetY);
        self.tableView.contentOffset = CGPointZero;;
    }else if (offsetY < webContentHeight){   // web view 已滚动最大范围
        self.scrollViewContainerView.y = webContentHeight - webHeight;
        self.webView.scrollView.contentOffset = CGPointMake(0, webContentHeight - webHeight);
        self.tableView.contentOffset = CGPointZero;
    }else if (offsetY < webContentHeight + tabContentHeight - tabHeight){ // table view 内容滚动区间
        self.scrollViewContainerView.y = offsetY - webHeight;
        self.webView.scrollView.contentOffset = CGPointMake(0, webContentHeight - webHeight);
        self.tableView.contentOffset = CGPointMake(0, offsetY - webContentHeight);
    }else if (offsetY < webContentHeight + tabContentHeight){  // table 已滚动到最大范围
        self.scrollViewContainerView.y = self.scrollView.contentSize.height - self.scrollViewContainerView.height;
        self.webView.scrollView.contentOffset = CGPointMake(0, webContentHeight - webHeight);
        self.tableView.contentOffset = CGPointMake(0, tabContentHeight - tabHeight);
    }
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    CGFloat webContentHeight = self.webView.scrollView.contentSize.height; /*web view 的内容高度 */
    CGFloat tabContentHeight = self.tableView.contentSize.height;   /* tablie 的内容高度 */
    
    if (webContentHeight == self.maxWebContentHeight && tabContentHeight == self.maxTabContentHeight) {return;}
    self.maxWebContentHeight = webContentHeight;  /* 保存最新web内容高度 */
    self.maxTabContentHeight = tabContentHeight;  /*  保存最新tab内容高度 */
    // 设置总的视图滚动范围: web 内容高度 + tab 内容高度;
    self.scrollView.contentSize = CGSizeMake(self.view.width, webContentHeight + tabContentHeight);
    
    CGFloat webHeight = MIN( webContentHeight, self.view.height)  ;
    CGFloat tableHeight = MIN(tabContentHeight, self.view.height) ;  // tab view 的最大高度不超过屏幕高度
    self.webView.height = MAX(0.1, webHeight);    // 限制web view 的最大高度不超过屏幕高度
    // 设置scrollview的高度 =  web view 的高度 + table view 的高度;
    self.scrollViewContainerView.height = webHeight + tableHeight;
    self.tableView.height = tableHeight;
    self.tableView.y = self.webView.bottom;
}

#pragma mark - notification Handle





@end
