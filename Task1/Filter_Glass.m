function out=Filter_Glass(img)
size_info=size(img);
height=size_info(1);
width=size_info(2);
N=5;
out=zeros(height,width,3);
for i=1:height
    for j=1:width
       temp=uint8(rand()*(N^2-1));
       m=temp/N;
       n=mod(temp,N);
       h=mod(double(i-1)+double(m),double(height));
       w=mod(double(j-1)+double(n),double(width));
       if w==0
           w=width;
       end
        if h==0
            h=height;
        end
       out(i,j,:)=img(h,w,:);       
    end
end
end