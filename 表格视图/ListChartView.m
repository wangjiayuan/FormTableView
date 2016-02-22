//
//  ListChartView.m
//  柱状图
//
//  Created by apple on 15/12/4.
//  Copyright © 2015年 cheniue. All rights reserved.
//

#import "ListChartView.h"

@implementation ListChartView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        _borderColor = [UIColor lightGrayColor];
        _borderWidth = 1.0f/[UIScreen mainScreen].scale;
        _textFont = [UIFont systemFontOfSize:14.0f];
        _textColor = [UIColor blackColor];
        _alignment = NSTextAlignmentCenter;
        _cornerRadius = 5.0f;
    }
    return self;
}
-(UIColor *)listBackgroundColor
{
    if (!_listBackgroundColor)
    {
        return self.backgroundColor;
    }
    else
    {
        return _listBackgroundColor;
    }
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
///绘制背景
-(void)drawFill:(CGContextRef)context
{
    CGRect listBounds = [self itemsBounds];
    NSInteger rows = [self rows];
    NSInteger columns = [self columns];
    ///视图背景
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    UIBezierPath *fullPath  = [UIBezierPath bezierPathWithRect:self.bounds];
    CGContextAddPath(context, fullPath.CGPath);
    CGContextFillPath(context);
    CGContextSetFillColorWithColor(context, self.listBackgroundColor.CGColor);
    ///表格背景
    UIBezierPath *listPath  = [UIBezierPath bezierPathWithRoundedRect:listBounds cornerRadius:self.cornerRadius];
    CGContextAddPath(context, listPath.CGPath);
    CGContextFillPath(context);
    ///只有一个单元格
    ///1、底色 2、边框 3、文本
    if (rows == 1 && columns == 1)
    {
        UIColor *itemColor = [self color:0 column:0];
        CGContextSetFillColorWithColor(context, itemColor.CGColor);
        UIBezierPath *itemPath  = [UIBezierPath bezierPathWithRoundedRect:[self rect:0 column:0] cornerRadius:self.cornerRadius];
        CGContextAddPath(context, itemPath.CGPath);
        CGContextFillPath(context);
    }
    else if(rows == 1)//只有一行
    {
        for (NSInteger c = 0; c<columns; c++)
        {
            if (c==0)//左端
            {
                CGRect itemRect = [self rect:0 column:c];
                if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                {
                    ////不占位取消绘制
                    continue;
                }
                
                [self fillTopLeftCornerRadius:context itemRect:itemRect row:0 column:c];
                [self fillBottomLeftCornerRadius:context itemRect:itemRect row:0 column:c];
                [self fillRect:context itemRect:itemRect row:0 column:c haveTopLeft:YES haveTopRight:NO haveBottomLeft:YES haveBottomRight:NO];

            }
            else if (c==(columns-1))//右端
            {
                CGRect itemRect = [self rect:0 column:c];
                if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                {
                    ////不占位取消绘制
                    continue;
                }
                [self fillTopRightCornerRadius:context itemRect:itemRect row:0 column:c];
                [self fillBottomRightCornerRadius:context itemRect:itemRect row:0 column:c];
                [self fillRect:context itemRect:itemRect row:0 column:c haveTopLeft:NO haveTopRight:YES haveBottomLeft:NO haveBottomRight:YES];
            }
            else//普通
            {
                [self context:context fill:0 column:c];
            }
        }
    }
    else if(columns == 1)//只有一列
    {
        for (NSInteger r = 0; r<rows; r++)
        {
            if (r==0)//顶端
            {
                CGRect itemRect = [self rect:r column:0];
                if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                {
                    ////不占位取消绘制
                    continue;
                }
                
                [self fillTopLeftCornerRadius:context itemRect:itemRect row:r column:0];
                [self fillTopRightCornerRadius:context itemRect:itemRect row:r column:0];
                [self fillRect:context itemRect:itemRect row:r column:0 haveTopLeft:YES haveTopRight:YES haveBottomLeft:NO haveBottomRight:NO];

            }
            else if (r==(rows-1))//底端
            {
                CGRect itemRect = [self rect:r column:0];
                if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                {
                    ////不占位取消绘制
                    continue;
                }
                [self fillBottomLeftCornerRadius:context itemRect:itemRect row:r column:0];
                [self fillBottomRightCornerRadius:context itemRect:itemRect row:r column:0];
                [self fillRect:context itemRect:itemRect row:r column:0 haveTopLeft:NO haveTopRight:NO haveBottomLeft:YES haveBottomRight:YES];

            }
            else//普通
            {
                [self context:context fill:r column:0];
            }
        }
    }
    else
    {
        for (NSInteger row = 0; row < rows; row++)
        {
            for (NSInteger column = 0; column < columns; column++)
            {
                ///四个角
                if (row == 0 && column == 0)//左上角
                {
                    CGRect itemRect = [self rect:row column:column];
                    if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                    {
                        ////不占位取消绘制
                        continue;
                    }
                    
                    [self fillTopLeftCornerRadius:context itemRect:itemRect row:row column:column];
                    [self fillRect:context itemRect:itemRect row:row column:column haveTopLeft:YES haveTopRight:NO haveBottomLeft:NO haveBottomRight:NO];

                }
                else if (row == (rows-1) && column == 0)//左下角
                {
                    CGRect itemRect = [self rect:row column:column];
                    if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                    {
                        ////不占位取消绘制
                        continue;
                    }
                    
                    [self fillBottomLeftCornerRadius:context itemRect:itemRect row:row column:column];
                    [self fillRect:context itemRect:itemRect row:row column:column haveTopLeft:NO haveTopRight:NO haveBottomLeft:YES haveBottomRight:NO];

                }
                else if (row == 0 && column == (columns-1))//右上角
                {
                    CGRect itemRect = [self rect:row column:column];
                    if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                    {
                        ////不占位取消绘制
                        continue;
                    }
                    
                    [self fillTopRightCornerRadius:context itemRect:itemRect row:row column:column];
                    [self fillRect:context itemRect:itemRect row:row column:column haveTopLeft:NO haveTopRight:YES haveBottomLeft:NO haveBottomRight:NO];

                }
                else if (row == (rows-1) && column == (columns-1))//右下角
                {
                    CGRect itemRect = [self rect:row column:column];
                    if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                    {
                        ////不占位取消绘制
                        continue;
                    }
                    
                    [self fillBottomRightCornerRadius:context itemRect:itemRect row:row column:column];
                    [self fillRect:context itemRect:itemRect row:row column:column haveTopLeft:NO haveTopRight:NO haveBottomLeft:NO haveBottomRight:YES];

                }
                else//其它
                {
                    [self context:context fill:row column:column];
                }
            }
        }
    }
}
///绘制边框
-(void)drawBorder:(CGContextRef)context
{
    NSInteger rows = [self rows];
    NSInteger columns = [self columns];
    
    ///只有一个单元格
    ///1、底色 2、边框 3、文本
    if (rows == 1 && columns == 1)
    {
        UIBezierPath *itemPath  = [UIBezierPath bezierPathWithRoundedRect:[self rect:0 column:0] cornerRadius:self.cornerRadius];
        CGContextSetStrokeColorWithColor(context, [self borderColor:0 column:0].CGColor);
        CGContextSetLineWidth(context, self.borderWidth);
        CGContextAddPath(context, itemPath.CGPath);
        CGContextStrokePath(context);
    }
    else if(rows == 1)//只有一行
    {
        for (NSInteger c = 0; c<columns; c++)
        {
            if (c==0)//左端
            {
                CGRect itemRect = [self rect:0 column:c];
                if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                {
                    ////不占位取消绘制
                    continue;
                }
                UIBezierPath *itemPath = [UIBezierPath bezierPath];
                
                [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y)];
                [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y)];
                [itemPath addArcWithCenter:CGPointMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y+self.cornerRadius) radius:self.cornerRadius startAngle:-M_PI_2 endAngle:-M_PI clockwise:NO];
                [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+self.cornerRadius)];
                [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height-self.cornerRadius)];
                [itemPath addArcWithCenter:CGPointMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y+itemRect.size.height-self.cornerRadius) radius:self.cornerRadius startAngle:-M_PI endAngle:M_PI_2 clockwise:NO];
                [itemPath moveToPoint:CGPointMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y+itemRect.size.height)];
                [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height)];
                
                if ([self borderForRight:0 column:c])
                {
                    [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height)];
                    [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y)];
                }
                
                CGContextSetStrokeColorWithColor(context, [self borderColor:0 column:c].CGColor);
                CGContextSetLineWidth(context, self.borderWidth);
                CGContextAddPath(context, itemPath.CGPath);
                CGContextStrokePath(context);
            }
            else if (c==(columns-1))//右端
            {
                CGRect itemRect = [self rect:0 column:c];
                if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                {
                    ////不占位取消绘制
                    continue;
                }
                UIBezierPath *itemPath = [UIBezierPath bezierPath];
                [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y)];
                [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y)];
                [itemPath addArcWithCenter:CGPointMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y+self.cornerRadius) radius:self.cornerRadius startAngle:-M_PI_2 endAngle:0.0f clockwise:YES];
                [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+self.cornerRadius)];
                [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height-self.cornerRadius)];
                [itemPath addArcWithCenter:CGPointMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y+itemRect.size.height-self.cornerRadius) radius:self.cornerRadius startAngle:0.0f endAngle:M_PI_2 clockwise:YES];
                [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y+itemRect.size.height)];
                [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height)];
                
                if ([self borderForLeft:0 column:c])
                {
                    [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height)];
                    [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y)];
                }
                
                CGContextSetStrokeColorWithColor(context, [self borderColor:0 column:c].CGColor);
                CGContextSetLineWidth(context, self.borderWidth);
                CGContextAddPath(context, itemPath.CGPath);
                CGContextStrokePath(context);
            }
            else//普通
            {
                [self context:context draw:0 column:c];
            }
        }
    }
    else if(columns == 1)//只有一列
    {
        for (NSInteger r = 0; r<rows; r++)
        {
            if (r==0)//顶端
            {
                CGRect itemRect = [self rect:r column:0];
                if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                {
                    ////不占位取消绘制
                    continue;
                }
                UIBezierPath *itemPath = [UIBezierPath bezierPath];
                
                [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height)];
                [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+self.cornerRadius)];
                [itemPath addArcWithCenter:CGPointMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y+self.cornerRadius) radius:self.cornerRadius startAngle:-M_PI endAngle:-M_PI_2 clockwise:YES];
                [itemPath moveToPoint:CGPointMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y)];
                [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y)];
                [itemPath addArcWithCenter:CGPointMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y+self.cornerRadius) radius:self.cornerRadius startAngle:-M_PI_2 endAngle:0.0f clockwise:YES];
                [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+self.cornerRadius)];
                [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height)];
                
                if ([self borderForBottom:r column:0])
                {
                    [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height)];
                    [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height)];
                }
                CGContextSetStrokeColorWithColor(context, [self borderColor:r column:0].CGColor);
                CGContextSetLineWidth(context, self.borderWidth);
                CGContextAddPath(context, itemPath.CGPath);
                CGContextStrokePath(context);
            }
            else if (r==(rows-1))//底端
            {
                CGRect itemRect = [self rect:r column:0];
                if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                {
                    ////不占位取消绘制
                    continue;
                }
                UIBezierPath *itemPath = [UIBezierPath bezierPath];
                [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y)];
                [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height-self.cornerRadius)];
                [itemPath addArcWithCenter:CGPointMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y+itemRect.size.height-self.cornerRadius) radius:self.cornerRadius startAngle:-M_PI endAngle:M_PI_2 clockwise:NO];
                [itemPath moveToPoint:CGPointMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y+itemRect.size.height)];
                [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y+itemRect.size.height)];
                [itemPath addArcWithCenter:CGPointMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y+itemRect.size.height-self.cornerRadius) radius:self.cornerRadius startAngle:M_PI_2 endAngle:0.0f clockwise:NO];
                [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height-self.cornerRadius)];
                [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y)];
                if ([self borderForTop:r column:0])
                {
                    [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y)];
                    [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y)];
                }
                CGContextSetStrokeColorWithColor(context, [self borderColor:r column:0].CGColor);
                CGContextSetLineWidth(context, self.borderWidth);
                CGContextAddPath(context, itemPath.CGPath);
                CGContextStrokePath(context);
            }
            else//普通
            {
                [self context:context draw:r column:0];
            }
        }
    }
    else
    {
        for (NSInteger row = 0; row < rows; row++)
        {
            for (NSInteger column = 0; column < columns; column++)
            {
                ///四个角
                if (row == 0 && column == 0)//左上角
                {
                    CGRect itemRect = [self rect:row column:column];
                    if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                    {
                        ////不占位取消绘制
                        continue;
                    }
                    UIBezierPath *itemPath = [UIBezierPath bezierPath];
                    
                    [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height)];
                    [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+self.cornerRadius)];
                    [itemPath addArcWithCenter:CGPointMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y+self.cornerRadius) radius:self.cornerRadius startAngle:-M_PI endAngle:-M_PI_2 clockwise:YES];
                    [itemPath moveToPoint:CGPointMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y)];
                    [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y)];
                    
                    if ([self borderForRight:row column:column])
                    {
                        [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y)];
                        [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height)];
                    }
                    if ([self borderForBottom:row column:column])
                    {
                        [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height)];
                        [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height)];
                    }

                    CGContextSetStrokeColorWithColor(context, [self borderColor:row column:column].CGColor);
                    CGContextSetLineWidth(context, self.borderWidth);
                    CGContextAddPath(context, itemPath.CGPath);
                    CGContextStrokePath(context);
                }
                else if (row == (rows-1) && column == 0)//左下角
                {
                    CGRect itemRect = [self rect:row column:column];
                    if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                    {
                        ////不占位取消绘制
                        continue;
                    }
                    UIBezierPath *itemPath = [UIBezierPath bezierPath];
                    [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y)];
                    [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height-self.cornerRadius)];
                    [itemPath addArcWithCenter:CGPointMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y+itemRect.size.height-self.cornerRadius) radius:self.cornerRadius startAngle:-M_PI endAngle:M_PI_2 clockwise:NO];
                    [itemPath moveToPoint:CGPointMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y+itemRect.size.height)];
                    [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height)];
                    
                    if ([self borderForRight:row column:column])
                    {
                        [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height)];
                        [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y)];
                    }
                    if ([self borderForTop:row column:column])
                    {
                        [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y)];
                        [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y)];
                    }

                    CGContextSetStrokeColorWithColor(context, [self borderColor:row column:column].CGColor);
                    CGContextSetLineWidth(context, self.borderWidth);
                    CGContextAddPath(context, itemPath.CGPath);
                    CGContextStrokePath(context);
                }
                else if (row == 0 && column == (columns-1))//右上角
                {
                    CGRect itemRect = [self rect:row column:column];
                    if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                    {
                        ////不占位取消绘制
                        continue;
                    }
                    UIBezierPath *itemPath = [UIBezierPath bezierPath];
                    [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y)];
                    [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y)];
                    [itemPath addArcWithCenter:CGPointMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y+self.cornerRadius) radius:self.cornerRadius startAngle:-M_PI_2 endAngle:0.0f clockwise:YES];
                    [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+self.cornerRadius)];
                    [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height)];
                    
                    if ([self borderForBottom:row column:column])
                    {
                        [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height)];
                        [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height)];
                    }
                    if ([self borderForLeft:row column:column])
                    {
                        [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height)];
                        [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y)];
                    }

                    CGContextSetStrokeColorWithColor(context, [self borderColor:row column:column].CGColor);
                    CGContextSetLineWidth(context, self.borderWidth);
                    CGContextAddPath(context, itemPath.CGPath);
                    CGContextStrokePath(context);
                }
                else if (row == (rows-1) && column == (columns-1))//右下角
                {
                    CGRect itemRect = [self rect:row column:column];
                    if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                    {
                        ////不占位取消绘制
                        continue;
                    }
                    UIBezierPath *itemPath = [UIBezierPath bezierPath];
                    [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y)];
                    [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height-self.cornerRadius)];
                    [itemPath addArcWithCenter:CGPointMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y+itemRect.size.height-self.cornerRadius) radius:self.cornerRadius startAngle:0.0f endAngle:M_PI_2 clockwise:YES];
                    [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y+itemRect.size.height)];
                    [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height)];
                    
                    if ([self borderForLeft:row column:column])
                    {
                        [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height)];
                        [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y)];
                    }
                    if ([self borderForTop:row column:column])
                    {
                        [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y)];
                        [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y)];
                    }

                    CGContextSetStrokeColorWithColor(context, [self borderColor:row column:column].CGColor);
                    CGContextSetLineWidth(context, self.borderWidth);
                    CGContextAddPath(context, itemPath.CGPath);
                    CGContextStrokePath(context);
                }
                else//其它
                {
                    [self context:context draw:row column:column];
                }
            }
        }
    }
}
///绘制文字
-(void)drawText:(CGContextRef)context
{
    NSInteger rows = [self rows];
    NSInteger columns = [self columns];

    ///只有一个单元格
    ///1、底色 2、边框 3、文本
    if (rows == 1 && columns == 1)
    {
        [self drawText:0 column:0];
    }
    else if(rows == 1)//只有一行
    {
        for (NSInteger c = 0; c<columns; c++)
        {
            if (c==0)//左端
            {
                CGRect itemRect = [self rect:0 column:c];
                if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                {
                    ////不占位取消绘制
                    continue;
                }
                [self drawText:0 column:c];
            }
            else if (c==(columns-1))//右端
            {
                CGRect itemRect = [self rect:0 column:c];
                if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                {
                    ////不占位取消绘制
                    continue;
                }
                [self drawText:0 column:c];
            }
            else//普通
            {
                CGRect itemRect = [self rect:0 column:c];
                if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                {
                    ////不占位取消绘制
                    continue;
                }
                [self drawText:0 column:c];
            }
        }
    }
    else if(columns == 1)//只有一列
    {
        for (NSInteger r = 0; r<rows; r++)
        {
            if (r==0)//顶端
            {
                CGRect itemRect = [self rect:r column:0];
                if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                {
                    ////不占位取消绘制
                    continue;
                }
                [self drawText:r column:0];
            }
            else if (r==(rows-1))//底端
            {
                CGRect itemRect = [self rect:r column:0];
                if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                {
                    ////不占位取消绘制
                    continue;
                }
                [self drawText:r column:0];
            }
            else//普通
            {
                CGRect itemRect = [self rect:r column:0];
                if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                {
                    ////不占位取消绘制
                    continue;
                }
                [self drawText:r column:0];
            }
        }
    }
    else
    {
        for (NSInteger row = 0; row < rows; row++)
        {
            for (NSInteger column = 0; column < columns; column++)
            {
                ///四个角
                if (row == 0 && column == 0)//左上角
                {
                    CGRect itemRect = [self rect:row column:column];
                    if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                    {
                        ////不占位取消绘制
                        continue;
                    }
                    
                    [self drawText:row column:column];
                }
                else if (row == (rows-1) && column == 0)//左下角
                {
                    CGRect itemRect = [self rect:row column:column];
                    if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                    {
                        ////不占位取消绘制
                        continue;
                    }
                    
                    [self drawText:row column:column];
                }
                else if (row == 0 && column == (columns-1))//右上角
                {
                    CGRect itemRect = [self rect:row column:column];
                    if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                    {
                        ////不占位取消绘制
                        continue;
                    }
                    
                    [self drawText:row column:column];
                }
                else if (row == (rows-1) && column == (columns-1))//右下角
                {
                    CGRect itemRect = [self rect:row column:column];
                    if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                    {
                        ////不占位取消绘制
                        continue;
                    }
                    
                    [self drawText:row column:column];
                }
                else//其它
                {
                    CGRect itemRect = [self rect:row column:column];
                    if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                    {
                        ////不占位取消绘制
                        continue;
                    }
                    [self drawText:row column:column];
                }
            }
        }
    }
}
///重绘函数
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
//    [self drawFillBorderText:context];
    [self drawFill:context];
    [self drawBorder:context];
    [self drawText:context];
}
///背景边框文字
-(void)drawFillBorderText:(CGContextRef)context
{
    CGRect listBounds = [self itemsBounds];
    NSInteger rows = [self rows];
    NSInteger columns = [self columns];
    ///视图背景
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    UIBezierPath *fullPath  = [UIBezierPath bezierPathWithRect:self.bounds];
    CGContextAddPath(context, fullPath.CGPath);
    CGContextFillPath(context);
    CGContextSetFillColorWithColor(context, self.listBackgroundColor.CGColor);
    ///表格背景
    UIBezierPath *listPath  = [UIBezierPath bezierPathWithRoundedRect:listBounds cornerRadius:self.cornerRadius];
    CGContextAddPath(context, listPath.CGPath);
    CGContextFillPath(context);
    ///只有一个单元格
    ///1、底色 2、边框 3、文本
    if (rows == 1 && columns == 1)
    {
        UIColor *itemColor = [self color:0 column:0];
        CGContextSetFillColorWithColor(context, itemColor.CGColor);
        UIBezierPath *itemPath  = [UIBezierPath bezierPathWithRoundedRect:[self rect:0 column:0] cornerRadius:self.cornerRadius];
        CGContextAddPath(context, itemPath.CGPath);
        CGContextFillPath(context);
        CGContextSetStrokeColorWithColor(context, [self borderColor:0 column:0].CGColor);
        CGContextSetLineWidth(context, self.borderWidth);
        CGContextAddPath(context, itemPath.CGPath);
        CGContextStrokePath(context);
        [self drawText:0 column:0];
    }
    else if(rows == 1)//只有一行
    {
        for (NSInteger c = 0; c<columns; c++)
        {
            if (c==0)//左端
            {
                CGRect itemRect = [self rect:0 column:c];
                if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                {
                    ////不占位取消绘制
                    continue;
                }
                UIBezierPath *itemPath = [UIBezierPath bezierPath];
                
                [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y)];
                [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y)];
                [itemPath addArcWithCenter:CGPointMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y+self.cornerRadius) radius:self.cornerRadius startAngle:-M_PI_2 endAngle:-M_PI clockwise:NO];
                [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+self.cornerRadius)];
                [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height-self.cornerRadius)];
                [itemPath addArcWithCenter:CGPointMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y+itemRect.size.height-self.cornerRadius) radius:self.cornerRadius startAngle:-M_PI endAngle:M_PI_2 clockwise:NO];
                [itemPath moveToPoint:CGPointMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y+itemRect.size.height)];
                [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height)];
                
                if ([self borderForRight:0 column:c])
                {
                    [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height)];
                    [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y)];
                }
                
                [self fillTopLeftCornerRadius:context itemRect:itemRect row:0 column:c];
                [self fillBottomLeftCornerRadius:context itemRect:itemRect row:0 column:c];
                [self fillRect:context itemRect:itemRect row:0 column:c haveTopLeft:YES haveTopRight:NO haveBottomLeft:YES haveBottomRight:NO];
                CGContextSetStrokeColorWithColor(context, [self borderColor:0 column:c].CGColor);
                CGContextSetLineWidth(context, self.borderWidth);
                CGContextAddPath(context, itemPath.CGPath);
                CGContextStrokePath(context);
                [self drawText:0 column:c];
            }
            else if (c==(columns-1))//右端
            {
                CGRect itemRect = [self rect:0 column:c];
                if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                {
                    ////不占位取消绘制
                    continue;
                }
                UIBezierPath *itemPath = [UIBezierPath bezierPath];
                [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y)];
                [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y)];
                [itemPath addArcWithCenter:CGPointMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y+self.cornerRadius) radius:self.cornerRadius startAngle:-M_PI_2 endAngle:0.0f clockwise:YES];
                [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+self.cornerRadius)];
                [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height-self.cornerRadius)];
                [itemPath addArcWithCenter:CGPointMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y+itemRect.size.height-self.cornerRadius) radius:self.cornerRadius startAngle:0.0f endAngle:M_PI_2 clockwise:YES];
                [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y+itemRect.size.height)];
                [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height)];
                
                if ([self borderForLeft:0 column:c])
                {
                    [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height)];
                    [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y)];
                }
                [self fillTopRightCornerRadius:context itemRect:itemRect row:0 column:c];
                [self fillBottomRightCornerRadius:context itemRect:itemRect row:0 column:c];
                [self fillRect:context itemRect:itemRect row:0 column:c haveTopLeft:NO haveTopRight:YES haveBottomLeft:NO haveBottomRight:YES];
                CGContextSetStrokeColorWithColor(context, [self borderColor:0 column:c].CGColor);
                CGContextSetLineWidth(context, self.borderWidth);
                CGContextAddPath(context, itemPath.CGPath);
                CGContextStrokePath(context);
                [self drawText:0 column:c];
            }
            else//普通
            {
                [self context:context fillDrawWrite:0 column:c];
            }
        }
    }
    else if(columns == 1)//只有一列
    {
        for (NSInteger r = 0; r<rows; r++)
        {
            if (r==0)//顶端
            {
                CGRect itemRect = [self rect:r column:0];
                if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                {
                    ////不占位取消绘制
                    continue;
                }
                UIBezierPath *itemPath = [UIBezierPath bezierPath];
                
                [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height)];
                [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+self.cornerRadius)];
                [itemPath addArcWithCenter:CGPointMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y+self.cornerRadius) radius:self.cornerRadius startAngle:-M_PI endAngle:-M_PI_2 clockwise:YES];
                [itemPath moveToPoint:CGPointMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y)];
                [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y)];
                [itemPath addArcWithCenter:CGPointMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y+self.cornerRadius) radius:self.cornerRadius startAngle:-M_PI_2 endAngle:0.0f clockwise:YES];
                [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+self.cornerRadius)];
                [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height)];
                
                if ([self borderForBottom:r column:0])
                {
                    [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height)];
                    [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height)];
                }
                [self fillTopLeftCornerRadius:context itemRect:itemRect row:r column:0];
                [self fillTopRightCornerRadius:context itemRect:itemRect row:r column:0];
                [self fillRect:context itemRect:itemRect row:r column:0 haveTopLeft:YES haveTopRight:YES haveBottomLeft:NO haveBottomRight:NO];
                CGContextSetStrokeColorWithColor(context, [self borderColor:r column:0].CGColor);
                CGContextSetLineWidth(context, self.borderWidth);
                CGContextAddPath(context, itemPath.CGPath);
                CGContextStrokePath(context);
                [self drawText:r column:0];
            }
            else if (r==(rows-1))//底端
            {
                CGRect itemRect = [self rect:r column:0];
                if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                {
                    ////不占位取消绘制
                    continue;
                }
                UIBezierPath *itemPath = [UIBezierPath bezierPath];
                [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y)];
                [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height-self.cornerRadius)];
                [itemPath addArcWithCenter:CGPointMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y+itemRect.size.height-self.cornerRadius) radius:self.cornerRadius startAngle:-M_PI endAngle:M_PI_2 clockwise:NO];
                [itemPath moveToPoint:CGPointMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y+itemRect.size.height)];
                [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y+itemRect.size.height)];
                [itemPath addArcWithCenter:CGPointMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y+itemRect.size.height-self.cornerRadius) radius:self.cornerRadius startAngle:M_PI_2 endAngle:0.0f clockwise:NO];
                [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height-self.cornerRadius)];
                [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y)];
                if ([self borderForTop:r column:0])
                {
                    [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y)];
                    [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y)];
                }
                [self fillBottomLeftCornerRadius:context itemRect:itemRect row:r column:0];
                [self fillBottomRightCornerRadius:context itemRect:itemRect row:r column:0];
                [self fillRect:context itemRect:itemRect row:r column:0 haveTopLeft:NO haveTopRight:NO haveBottomLeft:YES haveBottomRight:YES];
                CGContextSetStrokeColorWithColor(context, [self borderColor:r column:0].CGColor);
                CGContextSetLineWidth(context, self.borderWidth);
                CGContextAddPath(context, itemPath.CGPath);
                CGContextStrokePath(context);
                [self drawText:r column:0];
            }
            else//普通
            {
                [self context:context fillDrawWrite:r column:0];
            }
        }
    }
    else
    {
        for (NSInteger row = 0; row < rows; row++)
        {
            for (NSInteger column = 0; column < columns; column++)
            {
                ///四个角
                if (row == 0 && column == 0)//左上角
                {
                    CGRect itemRect = [self rect:row column:column];
                    if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                    {
                        ////不占位取消绘制
                        continue;
                    }
                    UIBezierPath *itemPath = [UIBezierPath bezierPath];
                    
                    [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height)];
                    [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+self.cornerRadius)];
                    [itemPath addArcWithCenter:CGPointMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y+self.cornerRadius) radius:self.cornerRadius startAngle:-M_PI endAngle:-M_PI_2 clockwise:YES];
                    [itemPath moveToPoint:CGPointMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y)];
                    [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y)];
                    
                    if ([self borderForRight:row column:column])
                    {
                        [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y)];
                        [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height)];
                    }
                    if ([self borderForBottom:row column:column])
                    {
                        [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height)];
                        [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height)];
                    }
                    [self fillTopLeftCornerRadius:context itemRect:itemRect row:row column:column];
                    [self fillRect:context itemRect:itemRect row:row column:column haveTopLeft:YES haveTopRight:NO haveBottomLeft:NO haveBottomRight:NO];
                    CGContextSetStrokeColorWithColor(context, [self borderColor:row column:column].CGColor);
                    CGContextSetLineWidth(context, self.borderWidth);
                    CGContextAddPath(context, itemPath.CGPath);
                    CGContextStrokePath(context);
                    [self drawText:row column:column];
                }
                else if (row == (rows-1) && column == 0)//左下角
                {
                    CGRect itemRect = [self rect:row column:column];
                    if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                    {
                        ////不占位取消绘制
                        continue;
                    }
                    UIBezierPath *itemPath = [UIBezierPath bezierPath];
                    [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y)];
                    [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height-self.cornerRadius)];
                    [itemPath addArcWithCenter:CGPointMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y+itemRect.size.height-self.cornerRadius) radius:self.cornerRadius startAngle:-M_PI endAngle:M_PI_2 clockwise:NO];
                    [itemPath moveToPoint:CGPointMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y+itemRect.size.height)];
                    [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height)];
                    
                    if ([self borderForRight:row column:column])
                    {
                        [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height)];
                        [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y)];
                    }
                    if ([self borderForTop:row column:column])
                    {
                        [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y)];
                        [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y)];
                    }
                    [self fillBottomLeftCornerRadius:context itemRect:itemRect row:row column:column];
                    [self fillRect:context itemRect:itemRect row:row column:column haveTopLeft:NO haveTopRight:NO haveBottomLeft:YES haveBottomRight:NO];
                    CGContextSetStrokeColorWithColor(context, [self borderColor:row column:column].CGColor);
                    CGContextSetLineWidth(context, self.borderWidth);
                    CGContextAddPath(context, itemPath.CGPath);
                    CGContextStrokePath(context);
                    [self drawText:row column:column];
                }
                else if (row == 0 && column == (columns-1))//右上角
                {
                    CGRect itemRect = [self rect:row column:column];
                    if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                    {
                        ////不占位取消绘制
                        continue;
                    }
                    UIBezierPath *itemPath = [UIBezierPath bezierPath];
                    [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y)];
                    [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y)];
                    [itemPath addArcWithCenter:CGPointMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y+self.cornerRadius) radius:self.cornerRadius startAngle:-M_PI_2 endAngle:0.0f clockwise:YES];
                    [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+self.cornerRadius)];
                    [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height)];
                    
                    if ([self borderForBottom:row column:column])
                    {
                        [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height)];
                        [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height)];
                    }
                    if ([self borderForLeft:row column:column])
                    {
                        [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height)];
                        [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y)];
                    }
                    [self fillTopRightCornerRadius:context itemRect:itemRect row:row column:column];
                    [self fillRect:context itemRect:itemRect row:row column:column haveTopLeft:NO haveTopRight:YES haveBottomLeft:NO haveBottomRight:NO];
                    CGContextSetStrokeColorWithColor(context, [self borderColor:row column:column].CGColor);
                    CGContextSetLineWidth(context, self.borderWidth);
                    CGContextAddPath(context, itemPath.CGPath);
                    CGContextStrokePath(context);
                    [self drawText:row column:column];
                }
                else if (row == (rows-1) && column == (columns-1))//右下角
                {
                    CGRect itemRect = [self rect:row column:column];
                    if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
                    {
                        ////不占位取消绘制
                        continue;
                    }
                    UIBezierPath *itemPath = [UIBezierPath bezierPath];
                    [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y)];
                    [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height-self.cornerRadius)];
                    [itemPath addArcWithCenter:CGPointMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y+itemRect.size.height-self.cornerRadius) radius:self.cornerRadius startAngle:0.0f endAngle:M_PI_2 clockwise:YES];
                    [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y+itemRect.size.height)];
                    [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height)];
                    
                    if ([self borderForLeft:row column:column])
                    {
                        [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height)];
                        [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y)];
                    }
                    if ([self borderForTop:row column:column])
                    {
                        [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y)];
                        [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y)];
                    }
                    [self fillBottomRightCornerRadius:context itemRect:itemRect row:row column:column];
                    [self fillRect:context itemRect:itemRect row:row column:column haveTopLeft:NO haveTopRight:NO haveBottomLeft:NO haveBottomRight:YES];
                    CGContextSetStrokeColorWithColor(context, [self borderColor:row column:column].CGColor);
                    CGContextSetLineWidth(context, self.borderWidth);
                    CGContextAddPath(context, itemPath.CGPath);
                    CGContextStrokePath(context);
                    [self drawText:row column:column];
                }
                else//其它
                {
                    [self context:context fillDrawWrite:row column:column];
                }
            }
        }
    }
}
////正常直角实现效果
-(void)context:(CGContextRef)context fillDrawWrite:(NSInteger)row column:(NSInteger)column
{
    CGRect itemRect = [self rect:row column:column];
    if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
    {
        ////不占位取消绘制
        return;
    }
    UIBezierPath *itemPath = [UIBezierPath bezierPath];
    
    if ([self borderForLeft:row column:column])
    {
        [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y)];
        [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height)];
    }
    if ([self borderForRight:row column:column])
    {
        [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y)];
        [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height)];
    }
    if ([self borderForTop:row column:column])
    {
        [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y)];
        [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y)];
    }
    if ([self borderForBottom:row column:column])
    {
        [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height)];
        [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height)];
    }
    UIBezierPath *fillPath = [UIBezierPath bezierPathWithRect:itemRect];
    [fillPath closePath];
    UIColor *itemColor = [self color:row column:column];
    CGContextSetFillColorWithColor(context, itemColor.CGColor);
    CGContextAddPath(context, fillPath.CGPath);
    CGContextFillPath(context);
    CGContextSetStrokeColorWithColor(context, [self borderColor:row column:column].CGColor);
    CGContextSetLineWidth(context, self.borderWidth);
    CGContextAddPath(context, itemPath.CGPath);
    CGContextStrokePath(context);
    [self drawText:row column:column];
}
///填充
-(void)context:(CGContextRef)context fill:(NSInteger)row column:(NSInteger)column
{
    CGRect itemRect = [self rect:row column:column];
    if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
    {
        ////不占位取消绘制
        return;
    }
    
    UIBezierPath *fillPath = [UIBezierPath bezierPathWithRect:itemRect];
    [fillPath closePath];
    UIColor *itemColor = [self color:row column:column];
    CGContextSetFillColorWithColor(context, itemColor.CGColor);
    CGContextAddPath(context, fillPath.CGPath);
    CGContextFillPath(context);

}
///画边框
-(void)context:(CGContextRef)context draw:(NSInteger)row column:(NSInteger)column
{
    CGRect itemRect = [self rect:row column:column];
    if (itemRect.size.width<=0.0f||itemRect.size.height<=0.0f)
    {
        ////不占位取消绘制
        return;
    }
    UIBezierPath *itemPath = [UIBezierPath bezierPath];
    
    if ([self borderForLeft:row column:column])
    {
        [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y)];
        [itemPath addLineToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height)];
    }
    if ([self borderForRight:row column:column])
    {
        [itemPath moveToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y)];
        [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height)];
    }
    if ([self borderForTop:row column:column])
    {
        [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y)];
        [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y)];
    }
    if ([self borderForBottom:row column:column])
    {
        [itemPath moveToPoint:CGPointMake(itemRect.origin.x, itemRect.origin.y+itemRect.size.height)];
        [itemPath addLineToPoint:CGPointMake(itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height)];
    }
    
    CGContextSetStrokeColorWithColor(context, [self borderColor:row column:column].CGColor);
    CGContextSetLineWidth(context, self.borderWidth);
    CGContextAddPath(context, itemPath.CGPath);
    CGContextStrokePath(context);
}
///绘制文本
-(void)drawText:(NSInteger)row column:(NSInteger)column
{
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = self.alignment;
    NSString *text = [self text:row column:column];
    CGRect defaultRect = [self textRect:row column:column];
    UIFont *font = [self textFont:row column:column];
    NSDictionary *attributes = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[self textColor:row column:column],NSParagraphStyleAttributeName:paragraphStyle};
    CGSize size = [text boundingRectWithSize:CGSizeMake(defaultRect.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    CGFloat height = MIN(defaultRect.size.height, size.height);
    CGRect rect = CGRectMake(defaultRect.origin.x+(defaultRect.size.width-size.width)/2.0f, defaultRect.origin.y+(defaultRect.size.height-height)/2.0f, size.width, size.height);
    [text drawInRect:rect withAttributes:attributes];
}
///单元格文字
- (NSString*)text:(NSInteger)row column:(NSInteger)column
{
    if (DelegateResponds(@selector(listChart:textForRow:column:)))
    {
        NSString *text = [self.delegate listChart:self textForRow:row column:column];
        if (text)
        {
            return text;
        }
        return @"";
    }
    return @"";
}
///单元格文字颜色
- (UIColor*)textColor:(NSInteger)row column:(NSInteger)column
{
    if (DelegateResponds(@selector(listChart:textColorForRow:column:)))
    {
        UIColor *color = [self.delegate listChart:self textColorForRow:row column:column];
        if (color)
        {
            return color;
        }
        return self.textColor;
    }
    return self.textColor;
}
////单元格文字字体
- (UIFont*)textFont:(NSInteger)row column:(NSInteger)column
{
    if (DelegateResponds(@selector(listChart:fontForRow:column:)))
    {
        UIFont *font = [self.delegate listChart:self fontForRow:row column:column];
        if (font)
        {
            return font;
        }
        return self.textFont;
    }
    return self.textFont;
}
///单元格文本位置
- (CGRect)textRect:(NSInteger)row column:(NSInteger)column
{
    return CGRectInset([self rect:row column:column], 2.5f, 2.5f);
}
///单元格背景色
- (UIColor*)color:(NSInteger)row column:(NSInteger)column
{
    if (DelegateResponds(@selector(listChart:backgroundColorForRow:column:)))
    {
        UIColor *color = [self.delegate listChart:self backgroundColorForRow:row column:column];
        if (color)
        {
            return color;
        }
        return self.listBackgroundColor;
    }
    return self.listBackgroundColor;
}
///表单范围
- (CGRect)itemsBounds
{
    CGRect listBounds = self.bounds;
    if (DelegateResponds(@selector(boundsForList:)))
    {
        listBounds = [self.delegate boundsForList:self];
    }
    return listBounds;
}
////单元格大小
- (CGSize)size:(NSInteger)row column:(NSInteger)column
{
    if (DelegateResponds(@selector(listChart:itemSizeForRow:column:)))
    {
        return [self.delegate listChart:self itemSizeForRow:row column:column];
    }
    return CGSizeMake([self itemsBounds].size.width/[self columns], [self itemsBounds].size.height/[self rows]);
}
///单元格位置
- (CGRect)rect:(NSInteger)row column:(NSInteger)column
{
    CGFloat x = [self itemsBounds].origin.x;
    CGFloat y = [self itemsBounds].origin.y;
    for (NSInteger i=0; i<row; i++)
    {
        y += [self size:i column:column].height;
    }
    for (NSInteger j=0; j<column; j++)
    {
        x += [self size:row column:j].width;
    }
    CGSize size = [self size:row column:column];
    return CGRectMake(x, y, size.width, size.height);
}
///单元格边框颜色
- (UIColor*)borderColor:(NSInteger)row column:(NSInteger)column
{
    if (DelegateResponds(@selector(listChart:borderColorForRow:column:)))
    {
        UIColor *color = [self.delegate listChart:self borderColorForRow:row column:column];
        if (color)
        {
            return color;
        }
        return self.borderColor;
    }
    return self.borderColor;
}
////总行数
- (NSInteger)rows
{
    NSInteger rows = 1;
    if (DelegateResponds(@selector(rowForList:)))
    {
        rows = [self.delegate rowForList:self];
    }
    return rows;
}
///总列数
- (NSInteger)columns
{
    NSInteger columns = 1;
    if (DelegateResponds(@selector(columnForList:)))
    {
        columns = [self.delegate columnForList:self];
    }
    return columns;
}
///是否绘制上边框
- (BOOL)borderForTop:(NSInteger)row column:(NSInteger)column
{
    NSInteger influenceRow = row - 1;
    NSInteger influenceColumn = column;
    if (influenceRow < 0 || influenceRow >= [self rows])
    {
        return YES;
    }
    if (influenceColumn < 0 || influenceColumn >= [self columns])
    {
        return YES;
    }
    if (DelegateResponds(@selector(listChart:borderColorForRow:column:)))
    {
        if ([self.delegate listChart:self borderColorForRow:row column:column])
        {
            return YES;
        }
        
        if ([self.delegate listChart:self borderColorForRow:influenceRow column:influenceColumn])
        {
            return NO;
        }
        
    }
    return NO;
}
///是否绘制下边框
- (BOOL)borderForBottom:(NSInteger)row column:(NSInteger)column
{
    NSInteger influenceRow = row + 1;
    NSInteger influenceColumn = column;
    if (influenceRow < 0 || influenceRow >= [self rows])
    {
        return YES;
    }
    if (influenceColumn < 0 || influenceColumn >= [self columns])
    {
        return YES;
    }
    
    if (DelegateResponds(@selector(listChart:borderColorForRow:column:)))
    {
        
        if ([self.delegate listChart:self borderColorForRow:influenceRow column:influenceColumn])
        {
            return NO;
        }

    }
    return YES;
}
///是否绘制左边框
- (BOOL)borderForLeft:(NSInteger)row column:(NSInteger)column
{
    NSInteger influenceRow = row;
    NSInteger influenceColumn = column - 1;
    if (influenceRow < 0 || influenceRow >= [self rows])
    {
        return YES;
    }
    if (influenceColumn < 0 || influenceColumn >= [self columns])
    {
        return YES;
    }
    
    if (DelegateResponds(@selector(listChart:borderColorForRow:column:)))
    {
        if ([self.delegate listChart:self borderColorForRow:row column:column])
        {
            return YES;
        }
        
        if ([self.delegate listChart:self borderColorForRow:influenceRow column:influenceColumn])
        {
            return NO;
        }
        
    }
    return NO;
}
//是否绘制右边框
- (BOOL)borderForRight:(NSInteger)row column:(NSInteger)column
{
    NSInteger influenceRow = row;
    NSInteger influenceColumn = column + 1;
    if (influenceRow < 0 || influenceRow >= [self rows])
    {
        return YES;
    }
    if (influenceColumn < 0 || influenceColumn >= [self columns])
    {
        return YES;
    }
    
    if (DelegateResponds(@selector(listChart:borderColorForRow:column:)))
    {
        
        if ([self.delegate listChart:self borderColorForRow:influenceRow column:influenceColumn])
        {
            return NO;
        }
    }
    return YES;
}
///左上角圆角填充
-(void)fillTopLeftCornerRadius:(CGContextRef)context itemRect:(CGRect)itemRect row:(NSInteger)row column:(NSInteger)column
{
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, itemRect.origin.x+self.cornerRadius, itemRect.origin.y+self.cornerRadius);
    CGContextAddArc(context, itemRect.origin.x+self.cornerRadius, itemRect.origin.y+self.cornerRadius, self.cornerRadius, -M_PI_2 ,-M_PI ,YES);
    CGContextAddLineToPoint(context, itemRect.origin.x+self.cornerRadius, itemRect.origin.y+self.cornerRadius);
    CGContextClosePath(context);
    UIColor *itemColor = [self color:row column:column];
    CGContextSetFillColorWithColor(context, itemColor.CGColor);
    CGContextFillPath(context);
}
///左下角圆角填充
-(void)fillBottomLeftCornerRadius:(CGContextRef)context itemRect:(CGRect)itemRect row:(NSInteger)row column:(NSInteger)column
{
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, itemRect.origin.x, itemRect.origin.y+itemRect.size.height-self.cornerRadius);
    CGContextAddArc(context, itemRect.origin.x+self.cornerRadius, itemRect.origin.y+itemRect.size.height-self.cornerRadius,self.cornerRadius ,-M_PI ,M_PI_2 ,YES);
    CGContextAddLineToPoint(context, itemRect.origin.x+self.cornerRadius, itemRect.origin.y+itemRect.size.height-self.cornerRadius);
    CGContextClosePath(context);
    UIColor *itemColor = [self color:row column:column];
    CGContextSetFillColorWithColor(context, itemColor.CGColor);
    CGContextFillPath(context);
}
///右上角圆角填充
-(void)fillTopRightCornerRadius:(CGContextRef)context itemRect:(CGRect)itemRect row:(NSInteger)row column:(NSInteger)column
{
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y);
    CGContextAddArc(context, itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y+self.cornerRadius,self.cornerRadius ,-M_PI_2 ,0.0f ,NO);
    CGContextAddLineToPoint(context, itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y+self.cornerRadius);
    CGContextClosePath(context);
    UIColor *itemColor = [self color:row column:column];
    CGContextSetFillColorWithColor(context, itemColor.CGColor);
    CGContextFillPath(context);
}
///右下角圆角填充
-(void)fillBottomRightCornerRadius:(CGContextRef)context itemRect:(CGRect)itemRect row:(NSInteger)row column:(NSInteger)column
{
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, itemRect.origin.x+itemRect.size.width, itemRect.origin.y+itemRect.size.height-self.cornerRadius);
    CGContextAddArc(context, itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y+itemRect.size.height-self.cornerRadius,self.cornerRadius ,0.0f ,M_PI_2 ,NO);
    CGContextAddLineToPoint(context, itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y+itemRect.size.height-self.cornerRadius);
    CGContextClosePath(context);
    UIColor *itemColor = [self color:row column:column];
    CGContextSetFillColorWithColor(context, itemColor.CGColor);
    CGContextFillPath(context);
}
////填充矩形
-(void)fillRect:(CGContextRef)context itemRect:(CGRect)itemRect row:(NSInteger)row column:(NSInteger)column haveTopLeft:(BOOL)htl haveTopRight:(BOOL)htr haveBottomLeft:(BOOL)hbl haveBottomRight:(BOOL)hbr
{
    UIColor *itemColor = [self color:row column:column];
    CGContextSetFillColorWithColor(context, itemColor.CGColor);
    
    if (htl)//有左上角圆角
    {
        UIBezierPath *tlPath = [UIBezierPath bezierPathWithRect:CGRectMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y, itemRect.size.width-self.cornerRadius*2.0f, self.cornerRadius)];
        CGContextAddPath(context, tlPath.CGPath);
        CGContextFillPath(context);
    }
    else
    {
        UIBezierPath *tlPath = [UIBezierPath bezierPathWithRect:CGRectMake(itemRect.origin.x, itemRect.origin.y, itemRect.size.width-self.cornerRadius, self.cornerRadius)];
        CGContextAddPath(context, tlPath.CGPath);
        CGContextFillPath(context);
    }
    if (htr)//有右上角
    {
        UIBezierPath *trPath = [UIBezierPath bezierPathWithRect:CGRectMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y+self.cornerRadius, self.cornerRadius, itemRect.size.height-self.cornerRadius*2.0f)];
        CGContextAddPath(context, trPath.CGPath);
        CGContextFillPath(context);
    }
    else
    {
        UIBezierPath *trPath = [UIBezierPath bezierPathWithRect:CGRectMake(itemRect.origin.x+itemRect.size.width-self.cornerRadius, itemRect.origin.y, self.cornerRadius, itemRect.size.height-self.cornerRadius)];
        CGContextAddPath(context, trPath.CGPath);
        CGContextFillPath(context);
    }
    if (hbr)//有右下角
    {
        UIBezierPath *brPath = [UIBezierPath bezierPathWithRect:CGRectMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y+itemRect.size.height-self.cornerRadius, itemRect.size.width-self.cornerRadius*2.0f, self.cornerRadius)];
        CGContextAddPath(context, brPath.CGPath);
        CGContextFillPath(context);
    }
    else
    {
        UIBezierPath *brPath = [UIBezierPath bezierPathWithRect:CGRectMake(itemRect.origin.x+self.cornerRadius, itemRect.origin.y+itemRect.size.height-self.cornerRadius, itemRect.size.width-self.cornerRadius, self.cornerRadius)];
        CGContextAddPath(context, brPath.CGPath);
        CGContextFillPath(context);
    }
    if (hbl)///有左下角
    {
        UIBezierPath *blPath = [UIBezierPath bezierPathWithRect:CGRectMake(itemRect.origin.x, itemRect.origin.y+self.cornerRadius, self.cornerRadius, itemRect.size.height-self.cornerRadius*2.0f)];
        CGContextAddPath(context, blPath.CGPath);
        CGContextFillPath(context);
    }
    else
    {
        UIBezierPath *blPath = [UIBezierPath bezierPathWithRect:CGRectMake(itemRect.origin.x, itemRect.origin.y+self.cornerRadius, self.cornerRadius, itemRect.size.height-self.cornerRadius)];
        CGContextAddPath(context, blPath.CGPath);
        CGContextFillPath(context);
    }
    UIBezierPath *fillPath = [UIBezierPath bezierPathWithRect:CGRectMake(itemRect.origin.x+self.cornerRadius*0.5f, itemRect.origin.y+self.cornerRadius*0.5f, itemRect.size.width-self.cornerRadius, itemRect.size.height-self.cornerRadius)];
    CGContextAddPath(context, fillPath.CGPath);
    CGContextFillPath(context);
}
-(CGSize)itemDefaultSize
{
    return CGSizeMake([self itemsBounds].size.width*1.0f/[self columns], [self itemsBounds].size.height*1.0f/[self rows]);
}
@end
