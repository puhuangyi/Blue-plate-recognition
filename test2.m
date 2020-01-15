[file path] = uigetfile('*.*');

filename=fullfile(path,file);
tu=imread(filename);

tu1=caijian(tu);%将车牌区域分离出来

[y,x]=size(tu1);  
num=round((y*x)/150);  %取车牌区域面积1/150的值

tu2=qiege(tu1);   %将车牌区域切割一下（舍去掉上下左右多余的地方）以便下一步方便

[word1, tu3]=fenli_left(tu2);  %裁剪出左边第一个字符（中文字符）
subplot(2,2,4);imshow(tu3);

tu4=medfilt2(tu3,[3 3]);     %中值滤波
tu5=bwareaopen(tu4,num,8);   %去掉面积少于1/150车牌区域的不连通区域（过滤掉例如第二位与第三位字符中间的点以及大型杂点）
tu6=medfilt2(tu5,[3 3]);     %再次滤波（可省略）

[word2,word3,word4,word5,word6,word7]=fenli(tu6); %将剩下的车牌区域进行裁剪，输出是剩余六个字符区域

%{
word1 = imresize(word1, [40 20]);
word2 = imresize(word2, [40 20]);
word3 = imresize(word3, [40 20]);
word4 = imresize(word4, [40 20]);
word5 = imresize(word5, [40 20]);
word6 = imresize(word6, [40 20]);
word7 = imresize(word7, [40 20]);
%}
str=shibie_cnn(word1,word2,word3,word4,word5,word6,word7); %将七个裁剪下来的字符区域进行神经网络识别，得出结果


disp(str); %显示结果

