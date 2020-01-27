function out=Filter_Oil(img)
img=uint16(img);
radius=5;
intensity_level=100;

%�������ͼƬ����תΪuint16�ͣ��������ʱ������Χ
image_size=size(img);
height=image_size(1); %ͼƬ�ĸ߶�
width=image_size(2); %ͼƬ�Ŀ��
out=zeros(height,width,3);

%��һ��ͬ����С�������¼���ͼ������ݣ���ʼ��Ϊ��
for x=1:height
    for y=1:width
        intensity_counter=zeros(intensity_level,1);
        %ǿ�ȼ���������¼����ÿ��ǿ�ȳ��ִ���
        sum_r=uint16(zeros(intensity_level,1));
        %r�����ۼ�������¼ÿ��ǿ��r�����ĺ�
        sum_g=uint16(zeros(intensity_level,1)); %g�����ۼ���
        sum_b=uint16(zeros(intensity_level,1)); %b�����ۼ���
        for i=(x-radius):(x+radius)
            for j=(y-radius):(y+radius) %����ı���
                if i>0&&i<=height&&j>0&&j<=width
                    intensity=(img(i,j,1)+img(i,j,2)+img(i,j,3))/3*intensity_level/255;
                    %����ÿһ���ص�ǿ��
                    if intensity==0
                        intensity=1;
                    end %ǿ�Ȳ���Ϊ�㣬���������±������
                    intensity_counter(intensity)=intensity_counter(intensity)+1;
                    %ͳ��ǿ�ȳ��ֵĴ���
                    sum_r(intensity)=sum_r(intensity)+img(i,j,1);
                    %ͬһǿ�ȵ�r�������
                    sum_g(intensity)=sum_g(intensity)+img(i,j,2);
                    sum_b(intensity)=sum_b(intensity)+img(i,j,3);
                end
            end
        end
        intensity_counter_max=max(intensity_counter);
        %�ҳ�ͬһǿ�ȳ������Ĵ���
        for i=1:intensity_level
            if intensity_counter(i)==intensity_counter_max
                index=i;
            end
        end
        %���������Ĵ������ظ�����ȡǿ�ȴ��������Ϊ���
        out(x,y,1)=sum_r(index)/intensity_counter(index);
        %�������ε�ǿ��ֵ��Ӧ���ص�r����ȡƽ��ֵ����Ϊ��ǰ���������r����
        out(x,y,2)=sum_g(index)/intensity_counter(index);
        %�����g����
        out(x,y,3)=sum_b(index)/intensity_counter(index);
        %�����b����
    end
end
out=uint8(out);%��uint16ͼ��ת��ΪmatlabĬ�ϵ�uint8��
end