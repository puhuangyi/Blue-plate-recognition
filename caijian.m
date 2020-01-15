function pic=caijian(tu)
%用途：将图片裁剪到车牌区域

subplot(2,2,1);imshow(tu);
[y,x,z]=size(tu);


myi=double(tu);
blue_y=zeros(y,1);  

%统计纵向蓝色像素（将每行的蓝色像素相加放入[y,1]矩阵所对应的行，y是图片的宽）
for i=1:y
    for j=1:x
        rij = myi(i, j, 1)/(myi(i, j, 3)+eps);
        gij = myi(i, j, 2)/(myi(i, j, 3)+eps);
        bij = myi(i, j, 3);
        if ( (rij < 0.3 && gij < 0.6 && bij > 120) ...
                || (gij < 0.8 && rij < 0.9 && bij > 120) )  %判别是否是蓝色像素
            blue_y(i,1)=blue_y(i,1)+1;                      %是蓝色像素就加1            
        end
    end
end


[~,maxy]=max (blue_y);                                  %找到最大蓝色像素行
%有时候蓝色最大像素行并不是车牌区域，所以要进行如下判别
%当蓝色像素行的上面五行和下面五行都大于最大像素行的一半时，才可认为是最大像素行在车牌区域里面
%说明：有时候最大蓝色像素行可能由于干扰原因，并不在车牌区域位置，所以进行此步骤
while blue_y(maxy-5)<blue_y(maxy)/2 && blue_y(maxy+5)<blue_y(maxy)/2  
    blue_y(maxy)=0;
    [~,maxy]=max(blue_y);
end

%确定车牌区域的上边界
py1=maxy;
while((blue_y(py1,1)>=50)&&(py1>1))
    py1=py1-1;
end

%确定车牌区域的下边界
py2=maxy;
while (blue_y(py2,1)>=5)&&(py2<y)
    py2=py2+1;
end

%x1就是车牌区域的上下边界
x1=tu(py1:py2, :, :);
%subplot(2,2,2);imshow(x1);



blue_x=zeros(1,x);

%统计横向蓝色像素，方法同上
for j=1:x
    for i=py1:py2
        rij = myi(i, j, 1)/(myi(i, j, 3)+eps);
        gij = myi(i, j, 2)/(myi(i, j, 3)+eps);
        bij = myi(i, j, 3);
        if ( (rij < 0.3 && gij < 0.6 && bij > 120) ...
                || (gij < 0.8 && rij < 0.9 && bij > 120) )
            blue_x(1,j)=blue_x(1,j)+1;
            %bw2(i,j)=1;
        end
    end
end

%确定车牌左边界
px1=1;
while(blue_x(1,px1)<10 && (px1<x) )
    px1=px1+1;
end

%确定车牌右边界
px2=x;
while(blue_x(1,px2)<25 && (px2>px1))
    px2=px2-1;
end

%得到车牌区域
dw=tu(py1+10:py2-10, px1+5:px2-5, :);

subplot(2,2,2);imshow(dw);

[y,x,z]=size(dw);
bw=zeros(y,x);


%将车牌区域转为黑白
for i=1:y
    for j=1:x
        if (dw(i,j,1)>140 && dw(i,j,2)>150 && dw(i,j,3)>120 )
            bw(i,j)=1;            
        end
    end
end
subplot(2,2,3);imshow(bw);

pic=bw; %返回车牌区域


