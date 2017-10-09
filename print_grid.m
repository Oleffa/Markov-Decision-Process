% Oliver Struckmeier
% Aalto University 2017
function [ out, policy ] = print_grid( R , x_max, y_max, pol, xS, yS)
%Init grid plot
axis([0 x_max 0 y_max]) 
axis off; %turn off ticks
grid on;
hold on;
%Print initial grid, cosmetical
for i=1:x_max
    for j=1:y_max
        rectangle('Position', [i-1, j-1,1,1], 'FaceColor', [1 1 1], 'EdgeColor', [0 0 0], 'LineWidth', 1);
    end
end

%format for an entry:
%x: x-coord
%y: y-coord
%R: reward matrix
%pol: policy matrix

%============Winning points===========
x=5;
y=3;
R(x,y)=10;
pol(x,y)='+';
rectangle('Position', [x-1, y-1,1,1], 'FaceColor', [0 0.6 0], 'EdgeColor', [0 0 0], 'LineWidth', 1);

x=3;
y=3;
R(x,y)=1;
pol(x,y)='+';
rectangle('Position', [x-1, y-1,1,1], 'FaceColor', [0 0.4 0], 'EdgeColor', [0 0 0], 'LineWidth', 1);

%==========Loss point=============
x=1;
y=1;
R(x,y)=-10;
pol(x,y)='-';
rectangle('Position', [x-1, y-1,1,1], 'FaceColor', [0.8 0 0], 'EdgeColor', [0 0 0], 'LineWidth', 1);
%Loss point
x=2;
y=1;
R(x,y)=-10;
pol(x,y)='-';
rectangle('Position', [x-1, y-1,1,1], 'FaceColor', [0.8 0 0], 'EdgeColor', [0 0 0], 'LineWidth', 1);
%Loss point
x=3;
y=1;
R(x,y)=-10;
pol(x,y)='-';
rectangle('Position', [x-1, y-1,1,1], 'FaceColor', [0.8 0 0], 'EdgeColor', [0 0 0], 'LineWidth', 1);
%Loss point
x=4;
y=1;
R(x,y)=-10;
pol(x,y)='-';
rectangle('Position', [x-1, y-1,1,1], 'FaceColor', [0.8 0 0], 'EdgeColor', [0 0 0], 'LineWidth', 1);
%Loss point
x=5;
y=1;
R(x,y)=-10;
pol(x,y)='-';
rectangle('Position', [x-1, y-1,1,1], 'FaceColor', [0.8 0 0], 'EdgeColor', [0 0 0], 'LineWidth', 1);
%===============Obstacles======================
xObs=2;
yObs=3;
R(xObs,yObs)=-0.0001;
pol(xObs,yObs)='#';
rectangle('Position', [xObs-1, yObs-1,1,1], 'FaceColor', [0.5 0.5 0.5], 'EdgeColor', [0 0 0], 'LineWidth', 1);
%Obstacles
xObs=4;
yObs=3;
R(xObs,yObs)=-0.0001;
pol(xObs,yObs)='#';
rectangle('Position', [xObs-1, yObs-1,1,1], 'FaceColor', [0.5 0.5 0.5], 'EdgeColor', [0 0 0], 'LineWidth', 1);
%Obstacles
xObs=2;
yObs=4;
R(xObs,yObs)=-0.0001;
pol(xObs,yObs)='#';
rectangle('Position', [xObs-1, yObs-1,1,1], 'FaceColor', [0.5 0.5 0.5], 'EdgeColor', [0 0 0], 'LineWidth', 1);

%===========Start================
xStart = xS;
yStart = yS;
rectangle('Position', [xStart-1, yStart-1,1,1], 'FaceColor', [1 1 0], 'EdgeColor', [0 0 0], 'LineWidth', 1);

%return the reward and policy matrices
out = R;
policy = pol;

end

