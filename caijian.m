function pic=caijian(tu)
%��;����ͼƬ�ü�����������

subplot(2,2,1);imshow(tu);
[y,x,z]=size(tu);


myi=double(tu);
blue_y=zeros(y,1);  

%ͳ��������ɫ���أ���ÿ�е���ɫ������ӷ���[y,1]��������Ӧ���У�y��ͼƬ�Ŀ�
for i=1:y
    for j=1:x
        rij = myi(i, j, 1)/(myi(i, j, 3)+eps);
        gij = myi(i, j, 2)/(myi(i, j, 3)+eps);
        bij = myi(i, j, 3);
        if ( (rij < 0.3 && gij < 0.6 && bij > 120) ...
                || (gij < 0.8 && rij < 0.9 && bij > 120) )  %�б��Ƿ�����ɫ����
            blue_y(i,1)=blue_y(i,1)+1;                      %����ɫ���ؾͼ�1            
        end
    end
end


[~,maxy]=max (blue_y);                                  %�ҵ������ɫ������
%��ʱ����ɫ��������в����ǳ�����������Ҫ���������б�
%����ɫ�����е��������к��������ж�������������е�һ��ʱ���ſ���Ϊ������������ڳ�����������
%˵������ʱ�������ɫ�����п������ڸ���ԭ�򣬲����ڳ�������λ�ã����Խ��д˲���
while blue_y(maxy-5)<blue_y(maxy)/2 && blue_y(maxy+5)<blue_y(maxy)/2  
    blue_y(maxy)=0;
    [~,maxy]=max(blue_y);
end

%ȷ������������ϱ߽�
py1=maxy;
while((blue_y(py1,1)>=50)&&(py1>1))
    py1=py1-1;
end

%ȷ������������±߽�
py2=maxy;
while (blue_y(py2,1)>=5)&&(py2<y)
    py2=py2+1;
end

%x1���ǳ�����������±߽�
x1=tu(py1:py2, :, :);
%subplot(2,2,2);imshow(x1);



blue_x=zeros(1,x);

%ͳ�ƺ�����ɫ���أ�����ͬ��
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

%ȷ��������߽�
px1=1;
while(blue_x(1,px1)<10 && (px1<x) )
    px1=px1+1;
end

%ȷ�������ұ߽�
px2=x;
while(blue_x(1,px2)<25 && (px2>px1))
    px2=px2-1;
end

%�õ���������
dw=tu(py1+10:py2-10, px1+5:px2-5, :);

subplot(2,2,2);imshow(dw);

[y,x,z]=size(dw);
bw=zeros(y,x);


%����������תΪ�ڰ�
for i=1:y
    for j=1:x
        if (dw(i,j,1)>140 && dw(i,j,2)>150 && dw(i,j,3)>120 )
            bw(i,j)=1;            
        end
    end
end
subplot(2,2,3);imshow(bw);

pic=bw; %���س�������


