function [ P, err ] = triangulate( C1, p1, C2, p2 )
% triangulate:
%       C1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       C2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points

%       P - Nx3 matrix of 3D coordinates
%       err - scalar of the reprojection error

% Q3.2:
%       Implement a triangulation algorithm to compute the 3d locations
%

N=size(p1,1);
p1_=[p1';ones(1,N)];
p2_=[p1';ones(1,N)];

P=zeros(N,3);
C1_1=C1(1,:);
C1_2=C1(2,:);
C1_3=C1(3,:);
C2_1=C2(1,:);
C2_2=C2(2,:);
C2_3=C2(3,:);

for i=1:N
   p1x=p1(i,1);
   p1y=p1(i,2);
   p2x=p2(i,1);
   p2y=p2(i,2);
   A=[p1x*C1_3-C1_1;
       p1y*C1_3-C1_2;
       p2x*C2_3-C2_1;
       p2y*C2_3-C2_2];
   [U,S,V]=svd(A);
   v=V(:,4);
   P(i,:)=v(1:3)';
   P(i,:)=P(i,:)./ v(4);
end


%error
P_=[P';ones(1,N)];
p1_hat=C1*P_;
p2_hat=C2*P_;


err=sum(sum((p1_-p1_hat).^2))+sum(sum((p2_-p2_hat).^2));




end
