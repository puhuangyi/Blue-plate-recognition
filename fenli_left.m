function [word1,image]=fenli_left(pic)
%用途：分离左边第一个字符（现主要用来分离第一个汉字）

[y,x]=size(pic);
size_x=zeros(1,x);

i=1;
while i<=x
    while ( sum(pic(:,i)) > 1 && i<=x )%统计每个y方向上的白色像素，从左边到右边没有白色的地方
        size_x(1,i)=sum(pic(:,i));     %将y方向的白色像素数目放入一维数组size_x中
        i=i+1;
        
        if i>x                          %如果超出图片的边界就回到边界跳出循环
            i=x;
        end       
        if (i>x/10 && sum(pic(:,i))==0) || i==x %发现的白色像素的长度超过十分之一车牌长度的话 
            break;                              %就跳出循环
        end
    end
    
    if i>x/10                                   %如果白色像素的长度超过十分之一车牌长度
        break;                                  %说明是一个字符，跳出循环
    end
    
    while i<=x/10 && sum(size_x(1,i)) ==0       %如果白色像素的长度小于十分之一车牌长度
        size_x(1,i)=5;                          %有可能是汉字的偏旁与主体之间是断开的
        i=i+1;                                  %那么将中间的值值为5，并向右移动
    end                                         %一直到移动到汉字的主体位置
        
end
if i<x/8
    x_1=i-1;
else
    [~,x_1]=min(size_x);
end

x_1=x_1+3;

word1=pic(:,1:x_1);
%figure(3);subplot(2,1,1);imshow(word1);subplot(2,1,2);imshow(pic(:,x_1:end));
size_y_top=zeros(y,1);
size_y_bottom=zeros(y,1);
i=1;

%统计字符边界
while sum(word1(i,:))<=3 && i<y
    size_y_top=sum(word1(i,:));
    i=i+1;
end
i_t=i;
i=y;
while sum(word1(i,:))<=3 && i>1
    size_y_bottom=sum(word1(i,:));
    i=i-1;
end
i_b=i;

word1=logical(word1(i_t:i_b,:));   %转为0，1分布
image=logical(pic(:,x_1:end));