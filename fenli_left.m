function [word1,image]=fenli_left(pic)
%��;��������ߵ�һ���ַ�������Ҫ���������һ�����֣�

[y,x]=size(pic);
size_x=zeros(1,x);

i=1;
while i<=x
    while ( sum(pic(:,i)) > 1 && i<=x )%ͳ��ÿ��y�����ϵİ�ɫ���أ�����ߵ��ұ�û�а�ɫ�ĵط�
        size_x(1,i)=sum(pic(:,i));     %��y����İ�ɫ������Ŀ����һά����size_x��
        i=i+1;
        
        if i>x                          %�������ͼƬ�ı߽�ͻص��߽�����ѭ��
            i=x;
        end       
        if (i>x/10 && sum(pic(:,i))==0) || i==x %���ֵİ�ɫ���صĳ��ȳ���ʮ��֮һ���Ƴ��ȵĻ� 
            break;                              %������ѭ��
        end
    end
    
    if i>x/10                                   %�����ɫ���صĳ��ȳ���ʮ��֮һ���Ƴ���
        break;                                  %˵����һ���ַ�������ѭ��
    end
    
    while i<=x/10 && sum(size_x(1,i)) ==0       %�����ɫ���صĳ���С��ʮ��֮һ���Ƴ���
        size_x(1,i)=5;                          %�п����Ǻ��ֵ�ƫ��������֮���ǶϿ���
        i=i+1;                                  %��ô���м��ֵֵΪ5���������ƶ�
    end                                         %һֱ���ƶ������ֵ�����λ��
        
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

%ͳ���ַ��߽�
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

word1=logical(word1(i_t:i_b,:));   %תΪ0��1�ֲ�
image=logical(pic(:,x_1:end));