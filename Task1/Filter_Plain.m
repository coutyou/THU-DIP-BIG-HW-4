function out=Filter_Plain(I)
info_size=size(I);
height=info_size(1);
width=info_size(2);
N=zeros(height,width);
g=zeros(height,width);
imggray=rgb2gray(I);
out=zeros(height,width);

for i=1:height
    for j=1:width
        N(i,j)=255-imggray(i,j);
    end
end

for i=2:height-1
    for j=2:width-1
        sum=1*double(N(i-1,j-1))+2*double(N(i-1,j))+1*double(N(i-1,j+1));
        sum=sum+2*double(N(i,j-1))+4*double(N(i,j))+2*double(N(i,j+1));
        sum=sum+1*double(N(i+1,j-1))+2*double(N(i+1,j))+1*double(N(i+1,j+1));
        sum=sum/16;
        g(i,j)=sum;
    end
end

for i=1:height
    for j=1:width
        b=double(g(i,j));
        a=double(imggray(i,j));
        temp=a+a*b/(256-b);
        out(i,j)=uint8(min(temp,255));
    end
end

out_tmp = out;
out = zeros(size(I));
for i=1:3
    out(:,:,i) = out_tmp;
end
end