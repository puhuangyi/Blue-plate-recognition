[file path] = uigetfile('*.*');

filename=fullfile(path,file);
tu=imread(filename);

tu1=caijian(tu);%����������������

[y,x]=size(tu1);  
num=round((y*x)/150);  %ȡ�����������1/150��ֵ

tu2=qiege(tu1);   %�����������и�һ�£���ȥ���������Ҷ���ĵط����Ա���һ������

[word1, tu3]=fenli_left(tu2);  %�ü�����ߵ�һ���ַ��������ַ���
subplot(2,2,4);imshow(tu3);

tu4=medfilt2(tu3,[3 3]);     %��ֵ�˲�
tu5=bwareaopen(tu4,num,8);   %ȥ���������1/150��������Ĳ���ͨ���򣨹��˵�����ڶ�λ�����λ�ַ��м�ĵ��Լ������ӵ㣩
tu6=medfilt2(tu5,[3 3]);     %�ٴ��˲�����ʡ�ԣ�

[word2,word3,word4,word5,word6,word7]=fenli(tu6); %��ʣ�µĳ���������вü��������ʣ�������ַ�����

%{
word1 = imresize(word1, [40 20]);
word2 = imresize(word2, [40 20]);
word3 = imresize(word3, [40 20]);
word4 = imresize(word4, [40 20]);
word5 = imresize(word5, [40 20]);
word6 = imresize(word6, [40 20]);
word7 = imresize(word7, [40 20]);
%}
str=shibie_cnn(word1,word2,word3,word4,word5,word6,word7); %���߸��ü��������ַ��������������ʶ�𣬵ó����


disp(str); %��ʾ���

