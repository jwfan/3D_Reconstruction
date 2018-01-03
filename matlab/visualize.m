% Q4.2:
% Integrating everything together.
% Loads necessary files from ../data/ and visualizes 3D reconstruction
% using scatter3

I1=imread('../data/im1.png');
I2=imread('../data/im2.png');
load('../data/some_corresp.mat');
load('../data/intrinsics.mat');
load('../data/templeCoords.mat');
M=max(size(x1));
len=size(pts1,1);
F=eightpoint(pts1,pts2,M);
E=essentialMatrix(F,K1,K2);
P=zeros(len,3);

x2=zeros(M,1);
y2=zeros(M,1);
for i=1:M
    [x2(i),y2(i)]=epipolarCorrespondence(I1,I2,F,x1(i),y1(i));
end
pts1=[x1,y1];
pts2=[x2,y2];

M2s=camera2(E);
M1=[diag([1,1,1]),zeros(3,1)];
for i=1:4
   p=triangulate(K1*M1,pts1,K2*M2s(:,:,i),pts2);
   if all(p(:,3)>0)
      P=p;
      M2=M2s(:,:,i);
      break;
   end
end

scatter3(P(:,1),P(:,2),P(:,3));
C1=K1*M1;
C2=K2*M2;
save('q4_2.mat','F','M1','M2','C1','C2');
