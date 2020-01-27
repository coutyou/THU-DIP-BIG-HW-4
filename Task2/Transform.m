function out = Transform(img_src,img_target,target_x,target_y)
src_height = size(img_src,1);
src_width = size(img_src,2);
src_x = [1 1 src_width src_width]';
src_y = [1 src_height src_height 1]';

target_height = size(img_target,1);
target_width = size(img_target,2);

out=img_target;

tform = fitgeotrans([src_x src_y],[target_x target_y],'projective');
ImageRegistered = imwarp(img_src,tform,'OutputView',imref2d(size(out)));

mask = sum(ImageRegistered,3)~=0;
index = find(mask);

out(index) = ImageRegistered(index);
out(index+target_height*target_width) = ImageRegistered(index+target_height*target_width);
out(index+2*target_height*target_width) = ImageRegistered(index+2*target_height*target_width);
end