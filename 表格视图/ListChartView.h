//
//  ListChatView.h
//  柱状图
//
//  Created by apple on 15/12/4.
//  Copyright © 2015年 cheniue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListChartView;
@protocol ListChartViewDelegate
@optional
////表单行数
- (NSInteger)rowForList:(ListChartView*)list;
////表单列数
- (NSInteger)columnForList:(ListChartView*)list;
////表单显示范围
- (CGRect)boundsForList:(ListChartView*)list;
////表单某一格的边框颜色
- (UIColor*)listChart:(ListChartView*)list borderColorForRow:(NSInteger)row column:(NSInteger)column;
/////表单某一行的背景颜色
- (UIColor*)listChart:(ListChartView*)list backgroundColorForRow:(NSInteger)row column:(NSInteger)column;
/////表单某一格的大小
- (CGSize)listChart:(ListChartView*)list itemSizeForRow:(NSInteger)row column:(NSInteger)column;
/////表单某一格字体的大小
- (UIFont*)listChart:(ListChartView*)list fontForRow:(NSInteger)row column:(NSInteger)column;
/////表单某一格字体的颜色
- (UIColor*)listChart:(ListChartView*)list textColorForRow:(NSInteger)row column:(NSInteger)column;
/////表单某一格的文字
- (NSString*)listChart:(ListChartView*)list textForRow:(NSInteger)row column:(NSInteger)column;
@end
#define DelegateResponds(selector) (self.delegate != nil && [(NSObject*)self.delegate respondsToSelector:selector])

@interface ListChartView : UIView
@property(nonatomic,strong)UIColor *listBackgroundColor;
@property(nonatomic,strong)UIColor *borderColor;
@property(nonatomic,assign)CGFloat borderWidth;
@property(nonatomic,assign)CGFloat cornerRadius;
@property(nonatomic,strong)UIFont *textFont;
@property(nonatomic,strong)UIColor *textColor;
@property(nonatomic,assign)NSTextAlignment alignment;
@property(nonatomic,assign)id<ListChartViewDelegate> delegate;
-(CGSize)itemDefaultSize;
@end
