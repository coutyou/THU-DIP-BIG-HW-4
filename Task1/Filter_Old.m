function out=Filter_Old(img)
[h,w,k]=size(img);

R=double(img(:,:,1));
G=double(img(:,:,2));
B=double(img(:,:,3));

rR=R*0.393+G*0.769+B*0.198;
rG=R*0.349+G*0.686+B*0.168;
rB=R*0.272+G*0.534+B*0.131;

randR=rand()*0.5+0.5;
randG=rand()*0.5+0.5;
randB=rand()*0.5+0.5;

imgn=zeros(h,w,k);
imgn(:,:,1)=randR*rR+(1-randR)*R;
imgn(:,:,2)=randG*rG+(1-randG)*G;
imgn(:,:,3)=randB*rB+(1-randB)*B;

out = uint8(imgn);
end