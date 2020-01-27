% 以下是用户可以修改的参数，src_num为原图编号从1到4，target_num为模板编号从1到6
% 默认每一个模板对应一种滤镜，可以修改：
% 其中1对应油画风格，2对应墙体风格，3对应毛玻璃风格，4对应黑白风格，5对应素描风格，6对应怀旧风格
src_num = 1;
target_num = 3;
filter_num = target_num;

% 读取原图并显示
img_src = imread(strcat('./源图像/sourceImage', int2str(src_num), '.jpg'));
figure(1);
subplot(2,3,1);
imshow(img_src,[]);
title('img\_src');

% 读取目标图并显示
img_target = imread(strcat('./模板图像/targetImage', int2str(target_num), '.jpg'));
subplot(2,3,2);
imshow(img_target,[]);
title('img\_target');

% 交互式地对目标图进行前背景分割，得到mask
mask = GetMask(img_target);
subplot(2,3,3);
imshow(mask,[]);
title('mask');

% 对原图进行滤镜操作
img_filter = Filter(img_src, filter_num);
subplot(2,3,4);
if target_num == 3 || target_num == 4 || target_num == 5
    imshow(img_filter/255,[]);
else
    imshow(img_filter,[]);
end
title('img\_filter');

% 进行变换
img_transform = Transform(img_filter, img_target);
subplot(2,3,5);
imshow(img_transform,[]);
title('img\_transform');

% 得到结果并显示
img_res = img_transform.*mask + img_target.*(1-mask);
subplot(2,3,6);
imshow(img_res,[]);
title('img\_res');