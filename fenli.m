function [w1,w2,w3,w4,w5,w6]=fenli(pic)
%��;�������ַ����Ա�ʶ����Ҫ���ڷ��복�Ƶ�Ӣ����ĸ�����֣�

%pic1=edge(pic,'Canny');
pic1=bwlabel(pic,8);  %����һ����pic��С��ͬ��pic1���󣬰����˱����pic��ÿ����ͨ���������ǩ����Щ��ǩ��ֵΪ1,2,3...
stats=regionprops(pic1,'BoundingBox'); %������ķ���ֵ���о��α�ǣ����Ϊ1,2,3..������������С���α�ǳ���
if length(stats)~=6  %����ǳ����ľ����Ƿ�������������Ϊʣ�������ַ���
    msgbox('fail');  
    return
end


%����ÿ������������
%���䣺BoundingBox:��ʽΪ[ul_corner width]������ ul_corner �� [x y z ...] ��������ʽ�����߽���ӵ����Ͻǡ�boxwidth��[x_width y_width ...]��ʽָ���߽��������ÿ��ά������ĳ��ȡ�
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

    