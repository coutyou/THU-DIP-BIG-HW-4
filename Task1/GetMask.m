function out = GetMask(img)
figure(2);
imshow(img,[]);
title('请先选择前景（图片），后选择背景');

h1=impoly(gca,'Closed',false);
foresub=getPosition(h1);
foregroundInd=floor(sub2ind(size(img),foresub(:,2),foresub(:,1)));

h2=impoly(gca,'Closed',false);
backsub=getPosition(h2);
backgroundInd=floor(sub2ind(size(img),backsub(:,2),backsub(:,1)));

L=superpixels(img,100);
out=lazysnapping(img,L,foregroundInd,backgroundInd);
out=uint8(out);

close(figure(2));
end