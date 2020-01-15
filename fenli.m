function [w1,w2,w3,w4,w5,w6]=fenli(pic)
%用途：分离字符，以便识别（主要用于分离车牌的英文字母与数字）

%pic1=edge(pic,'Canny');
pic1=bwlabel(pic,8);  %返回一个和pic大小相同的pic1矩阵，包含了标记了pic中每个连通区域的类别标签，这些标签的值为1,2,3...
stats=regionprops(pic1,'BoundingBox'); %对上面的返回值进行矩形标记，标记为1,2,3..的区域再用最小矩形标记出来
if length(stats)~=6  %看标记出来的矩形是否满足六个（因为剩下六个字符）
    msgbox('fail');  
    return
end


%返回每个函数的区域
%补充：BoundingBox:形式为[ul_corner width]，这里 ul_corner 以 [x y z ...] 的坐标形式给出边界盒子的左上角、boxwidth以[x_width y_width ...]形式指出边界盒子沿着每个维数方向的长度。
w1=pic(round(stats(1).BoundingBox(2)):floor(stats(1).BoundingBox(2)+stats(1).BoundingBox(4)),...
         round(stats(1).BoundingBox(1)):floor(stats(1).BoundingBox(1)+stats(1).BoundingBox(3)));
subplot(2,3,1);imshow(w1);
w2=pic(round(stats(2).BoundingBox(2)):floor(stats(2).BoundingBox(2)+stats(2).BoundingBox(4)),...
         round(stats(2).BoundingBox(1)):floor(stats(2).BoundingBox(1)+stats(2).BoundingBox(3)));
subplot(2,3,2);imshow(w2);
w3=pic(round(stats(3).BoundingBox(2)):floor(stats(3).BoundingBox(2)+stats(3).BoundingBox(4)),...
         round(stats(3).BoundingBox(1)):floor(stats(3).BoundingBox(1)+stats(3).BoundingBox(3)));
subplot(2,3,3);imshow(w3);
w4=pic(round(stats(4).BoundingBox(2)):floor(stats(4).BoundingBox(2)+stats(4).BoundingBox(4)),...
         round(stats(4).BoundingBox(1)):floor(stats(4).BoundingBox(1)+stats(4).BoundingBox(3)));
subplot(2,3,4);imshow(w4);
w5=pic(round(stats(5).BoundingBox(2)):floor(stats(5).BoundingBox(2)+stats(5).BoundingBox(4)),...
         round(stats(5).BoundingBox(1)):floor(stats(5).BoundingBox(1)+stats(5).BoundingBox(3)));
subplot(2,3,5);imshow(w5);
w6=pic(round(stats(6).BoundingBox(2)):floor(stats(6).BoundingBox(2)+stats(6).BoundingBox(4)),...
         round(stats(6).BoundingBox(1)):floor(stats(6).BoundingBox(1)+stats(6).BoundingBox(3)));
subplot(2,3,6);imshow(w6);

    