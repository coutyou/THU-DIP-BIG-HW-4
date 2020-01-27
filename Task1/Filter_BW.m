function out = Filter_BW(img)
    thresh = graythresh(img);
    out_tmp = uint8(im2bw(img,thresh)).*255;
    out_tmp(sum(out_tmp,3) == 0) = 1;
    out = zeros(size(img));
    for i=1:3
        out(:,:,i) = out_tmp;
    end
end