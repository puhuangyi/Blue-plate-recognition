function t = qiege(image)
%��;��ȥ�����õĺ�ɫ����ʹ�ñ߽����ɫ���������
%ע����ʱ��Ƶ��ǲ���ģ��ʶ������������漰���ָ���ַ��롮1���ַ��������ò�����

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
    
    if   n<50                        %�ָ���һ��ͼ��ֱ������
        break;
    end
    if sum(image(:,left+10)) >10 && sum(image(:,left+5))>10  %�ָ���ַ�
        break;
    end
    if ( sum(image(:,left+1)) + sum(image(:,left+3)) )  >m/2  %�ָ1���ַ�
        break;
    end
    
    left=left+5;
    
end

t = imcrop(image, [left top dd hh]);