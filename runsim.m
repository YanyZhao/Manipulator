%% Setup

close all
addpath('utils')
addpath('maps')

profile on

%% Simulation Parameters
%
% Define any additional parameters you may need here. Add the parameters to
% the robot and map structures to pass them to astar or rrt.

map = loadmap('map4.txt');
start = [0,0,0,0,0,0];
goal = [1.3,1.3,1.3,0,0,0];
[maximum_try,SR,T,path,path_plot,success] = SRRT(start,goal,map);
%% following function is for evaluation: success rate, computation time .. 
% s_rate = 0;
% tic;
% total_step=0;
% total_len=0;
% maxDiff = 0;
% for j =1:100
%     q1 = randi([-14,14])/10;
%     q2 = randi([-12,14])/10;
%     q3 = randi([-18,17])/10;
%     q4 = randi([-19,17])/10;
%     goal = [q1,q2,q3,q4,0,0];
%     [maximum_try,SR,T,path,path_plot,success] = SRRT(start,goal,map);
    
%     [path] = rrt(map,start,goal);
%     [n,m] = size(path);
%     if n>1
%         len = zeros((n-1),1);
%         w = zeros(n,3);
%         for i=1:n
%             ans = calculateFK_sol(path(i,:));
%             w(i,:)= ans(6,:);
%         end
%         for i=1:n-1
%          len(i)=norm(w(i,:)-w(i+1,:));
%         end
%         total_len = total_len + sum(len);
%         total_step = total_step + sum(len)/(n-1);
% %         maxDiff = maxDiff+ (max(len)-min(len));
%     end
%     if mod(j,10)==0
%         j
%     end
%     s_rate = s_rate + success;
% end
% maxDiff
% total_len
% total_step
% toc;
% s_rate = s_rate/100
    


%% Run the simulation
profile off

%% Plot the output

% plotLynxPath(map,path_plot,10);

profile viewer
