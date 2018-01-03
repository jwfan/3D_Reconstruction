function [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
% epipolarCorrespondence:
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

% Q4.1:
%           Implement a method to compute (x2,y2) given (x1,y1)
%           Use F to only scan along the epipolar line
%           Experiment with different window sizes or weighting schemes
%           Save F, pts1, and pts2 used to generate view to q4_1.mat
%
%           Explain your methods and optimization in your writeup

window=11;
win=(window-1)/2;
sigma=5;
kernel=fspecial('gaussian',[window window],sigma);
[H,W]=size(im1);
p1=[x1;y1;1];
epLine=F*p1;
epLine=epLine/norm(epLine);

patch1=double(im1(((y1-win):(y1+win)),(x1-win):(x1+win)));

X1=1:W;
Y1=round(-(epLine(1)*X1+epLine(3))/epLine(2));
Y2=1:H;
X2=round(-(epLine(2)*Y2+epLine(3))/epLine(1));

points1=(X1-win)>0 & (X1+win)<=W & (Y1-win)>0 & (Y1+win)<=H;
points2=(X2-win)>0 & (X2+win)<=W & (Y2-win)>0 & (Y2+win)<=H;

if (epLine(1)/epLine(2))>1
    X=X1;
    Y=Y1;
    points=points1;
else
    X=X2;
    Y=Y2;
    points=points2;
end

err=Inf;
for i=find(points)
    if ((x1-X(i))^2+(y1-Y(i))^2)<300
        patch2=double(im2((Y(i)-win):(Y(i)+win),(X(i)-win):(X(i)+win)));
        Error= sum(sum(kernel.* (patch1-patch2)));
        if Error<err
            err=Error;
            x2=X(i);
            y2=Y(i);
        end
    end
end

%epipolarMatchGUI(im1, im2, F);
%save('q2_6.mat', 'F', 'pts1', 'pts2');
%save('q4_1.mat', 'F', 'pts1', 'pts2');
end

