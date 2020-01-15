function t = qiege(image)
%用途：去掉不用的黑色区域，使得边界与白色点紧密连接
%注：当时设计的是采用模板识别，所以下面会涉及到分割常规字符与‘1’字符，但已用不上了

[m,n]=size(image);
top = 1; 
bottom = m;
left = 1;
right = n;
while 1
    
    while sum(image(top,:))==0 && top<=m  
        top = top + 1;
    end
    while sum(image(bottom,:))==0 && bottom>=1
        bottom = bottom - 1;
    end
    while sum(image(:,left))<m/20 && left<=n
        left = left + 1;
    end
    while sum(image(:,right))<m/20 && right>=1
        right = right - 1;
    end
    dd = right - left; 
    hh = bottom - top; 
    length=round(hh/4);
    
    if   n<50                        %分割到最后一张图就直接跳出
        break;
    end
    if sum(image(:,left+10)) >10 && sum(image(:,left+5))>10  %分割常规字符
        break;
    end
    if ( sum(image(:,left+1)) + sum(image(:,left+3)) )  >m/2  %分割“1”字符
        break;
    end
    
    left=left+5;
    
end

t = imcrop(image, [left top dd hh]);