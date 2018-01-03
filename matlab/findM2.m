% Q3.3:
%       1. Load point correspondences
%       2. Obtain the correct M2
%       3. Save the correct M2, C2, p1, p2, R and P to q3_3.mat

I1=imread('../data/im1.png');
I2=imread('../data/im2.png');
load('../data/some_corresp.mat');
load('../data/intrinsics.mat');
M=max(size(I1));
len=size(pts1,1);

F=eightpoint(pts1,pts2,M);
E=essentialMatrix(F,K1,K2);
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

p1=pts1;
p2=pts2;
C2=K2*M2;
save('../result/q3_3.mat','M2','C2','p1','p2','P');

%save('q2_6.mat', 'F', 'pts1', 'pts2');
%save('q4_1.mat', 'F', 'pts1', 'pts2');