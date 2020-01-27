function out = Filter_Wall(img)
LineInterval = 50;
DarkLevel = 4;
H = size(img,1);
W = size(img,2);
out=img;
LineNum = floor(H/LineInterval);
for k=1:LineNum
    center=randn(1,W);
    center=(center-min(min(center)))/max(max(center));
    Mask=zeros(10,W);
    for i=1:10
        Mask(i,:)=center.*exp(-2*abs(i-5.5));
    end
    Mask=(Mask-min(min(Mask)))/(max(max(Mask))-min(min(Mask)));
    Mask=(1-Mask);
    Mask=(Mask)/(DarkLevel*max(max(Mask)))+1-1/DarkLevel;
    P=out(k*LineInterval-9:k*LineInterval,:,:);
    P=im2double(reshape(P,[10,W,3]));
    out(k*LineInterval-9:k*LineInterval,:,:)=im2uint8(P.*Mask);
end
end

