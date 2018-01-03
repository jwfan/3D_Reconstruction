function [ F ] = eightpoint( pts1, pts2, M )
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save F, M, pts1, pts2 to q2_1.mat

%     Write F and display the output of displayEpipolarF in your writeup

%load('../data/some_corresp.mat');

%I1=imread('../data/im1.png');
%I2=imread('../data/im2.png');
%M=max(size(I1));
pts1=pts1/M;
pts2=pts2/M;

X1=pts1(:,1);
Y1=pts1(:,2);
X2=pts2(:,1);
Y2=pts2(:,2);

len=size(pts1,1);

u=[X1.*X2,X1.*Y2,X1,Y1.*X2,Y1.*Y2,Y1,X2,Y2,ones(len,1)];

[U,S,V]=svd(u);
F=V(:,9);
F=reshape(F,[3,3]);

[U1,S1,V1]=svd(F);
S1(3,3)=0; %rank=2
F=U1*S1*V1';

F=refineF(F,pts1,pts2);

pts1=pts1*M;
pts2=pts2*M;
m=diag([1/M,1/M,1]);
F=m'*F*m;

%displayEpipolarF(I1,I2,F);

%save('../result/q2_1.mat','F','M','pts1','pts2');
end

