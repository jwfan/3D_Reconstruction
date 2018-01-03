function [ F ] = sevenpoint( pts1, pts2, M )
% sevenpoint:
%   pts1 - 7x2 matrix of (x,y) coordinates
%   pts2 - 7x2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.2:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save recovered F (either 1 or 3 in cell), M, pts1, pts2 to q2_2.mat

%     Write recovered F and display the output of displayEpipolarF in your writeup

%I1=imread('../data/im1.png');
%I2=imread('../data/im2.png');
%M=max(size(I1));

%cpselect(I1,I2);
%save('../data/q2_2_1_corresp.mat','pts1','pts2');
%load('../data/q2_2_1_corresp.mat');
pts1=pts1/M;
pts2=pts2/M;

X1=pts1(:,1);
Y1=pts1(:,2);
X2=pts2(:,1);
Y2=pts2(:,2);

len=size(pts1,1);

u=[X1.*X2,X1.*Y2,X1,Y1.*X2,Y1.*Y2,Y1,X2,Y2,ones(len,1)];

[U,S,V]=svd(u);
F1=V(:,9);
F1=reshape(F1,[3,3]);
F2=V(:,8);
F2=reshape(F2,[3,3]);

syms lambda;
r=solve(det(lambda*F1+(1-lambda)*F2)==0);
r=real(double(r));
F=cell(1,size(r,1));
m=diag([1/M,1/M,1]);
for i=1:size(r,1)
   F{i}=r(i)*F1+(1-r(i))*F2;
   F{i}=refineF(F{i},pts1,pts2);
   F{i}= m'*F{i}*m;
end
pts1=pts1*M;
pts2=pts2*M;

%displayEpipolarF(I1,I2,F(:,:,1));
%f=F{1};
%save('../result/q2_2.mat','f','M','pts1','pts2');
end

