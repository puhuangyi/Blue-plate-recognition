function str=shibie_cnn(word1,word2,word3,word4,word5,word6,word7)

%����gpu��gpu����
warning off parallel:gpu:device:DeviceLibsNeedsRecompiling
try
    gpuArray.eye(2)^2;
catch ME
end
try
    nnet.internal.cnngpu.reluForward(1);
catch ME
end

%����ѵ���õ�����
load('-mat','cnn_net');

%�Բü��������ַ�ת��Ϊ20*20��С����cnnѵ��������Ϊ20*20��
word1 = imresize(word1, [20 20]);
word2 = imresize(word2, [20 20]);
word3 = imresize(word3, [20 20]);
word4 = imresize(word4, [20 20]);
word5 = imresize(word5, [20 20]);
word6 = imresize(word6, [20 20]);
word7 = imresize(word7, [20 20]);

%���е�׼������
mkdir cnn_runing;
path1=pwd;
cd cnn_runing;
path2=fullfile(path1,'cnn_runing');

%����ʶ����ַ�ͼ�񱣴浽���ļ���
imwrite(word1,'word1.jpg');
imwrite(word2,'word2.jpg');
imwrite(word3,'word3.jpg');
imwrite(word4,'word4.jpg');
imwrite(word5,'word5.jpg');
imwrite(word6,'word6.jpg');
imwrite(word7,'word7.jpg');

%������ЩͼƬ����datastore
imds1=imageDatastore('word1.jpg');
imds2=imageDatastore('word2.jpg');
imds3=imageDatastore('word3.jpg');
imds4=imageDatastore('word4.jpg');
imds5=imageDatastore('word5.jpg');
imds6=imageDatastore('word6.jpg');
imds7=imageDatastore('word7.jpg');

%�ص�����Ŀ¼������ʶ��
cd (path1);
an1=classify(net,imds1);
an2=classify(net,imds2);
an3=classify(net,imds3);
an4=classify(net,imds4);
an5=classify(net,imds5);
an6=classify(net,imds6);
an7=classify(net,imds7);

%��ʶ����תΪ�ַ���
a1=char(cellstr(an1));
a2=char(cellstr(an2));
a3=char(cellstr(an3));
a4=char(cellstr(an4));
a5=char(cellstr(an5));
a6=char(cellstr(an6));
a7=char(cellstr(an7));

%���ؽ��
str=[a1 a2 a3 a4 a5 a6 a7];

%ɾ���ļ���
rmdir cnn_runing s;
