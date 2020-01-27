% �������û������޸ĵĲ�����src_numΪԭͼ��Ŵ�1��4��target_numΪģ���Ŵ�1��6
% Ĭ��ÿһ��ģ���Ӧһ���˾��������޸ģ�
% ����1��Ӧ�ͻ����2��Ӧǽ����3��Ӧë�������4��Ӧ�ڰ׷��5��Ӧ������6��Ӧ���ɷ��
src_num = 1;
target_num = 3;
filter_num = target_num;

% ��ȡԭͼ����ʾ
img_src = imread(strcat('./Դͼ��/sourceImage', int2str(src_num), '.jpg'));
figure(1);
subplot(2,3,1);
imshow(img_src,[]);
title('img\_src');

% ��ȡĿ��ͼ����ʾ
img_target = imread(strcat('./ģ��ͼ��/targetImage', int2str(target_num), '.jpg'));
subplot(2,3,2);
imshow(img_target,[]);
title('img\_target');

% ����ʽ�ض�Ŀ��ͼ����ǰ�����ָ�õ�mask
mask = GetMask(img_target);
subplot(2,3,3);
imshow(mask,[]);
title('mask');

% ��ԭͼ�����˾�����
img_filter = Filter(img_src, filter_num);
subplot(2,3,4);
if target_num == 3 || target_num == 4 || target_num == 5
    imshow(img_filter/255,[]);
else
    imshow(img_filter,[]);
end
title('img\_filter');

% ���б任
img_transform = Transform(img_filter, img_target);
subplot(2,3,5);
imshow(img_transform,[]);
title('img\_transform');

% �õ��������ʾ
img_res = img_transform.*mask + img_target.*(1-mask);
subplot(2,3,6);
imshow(img_res,[]);
title('img\_res');