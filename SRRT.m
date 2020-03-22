function [maximum_try,SR,T,path,path_plot,success] = SRRT(start,goal,map)
%% generative function for SRRT planner
%  input:   start point:start, shape:1,6
%           end point:goal, shape:1,6
%           map
load 'robot.mat' robot
%initialzation
success = 1;
path = [];
path_plot = [];
epsilon = 0.07;
q_start.val = start;
q_goal.val = goal;
q_start.parent = [];
q_goal.parent = [];
q_start.flag = 1;
q_goal.flag = 1;
T = q_start;
%counter for success sampling rate
s = 0; 
%sample success sample rate, it determines the adaptive threshold epsilon
sr = 0.5; 
% recorder for success sample rate
SR = [];
maximum_try = 1;
%% main
% check if end configuration is feasible
if isRobotCollided(q_goal.val,map,robot)
    success = 0;
    disp('invalid goal position')
    return
end
%set maximum sample tries to be 500, if exceeds, return success=0
while maximum_try<501
    % sample nodes in the space
    q_next = sample(q_start,q_goal,sr);
    % find the nearest node
    q_near = Neighbor(q_next,T);
    % entend the node towards q_next
    q_new = Extend(q_near,q_next);
    % check if new node is collision free
    isCol = DetCol(q_near,q_new,map);
    % if new node is collision free, add it to the tree, set the nearest
    % node as its parent and update the success sample rate: sr
    if isCol==0
        T = [T;q_new];
        s = s+1;
        sr = s/maximum_try;
        SR = [SR,sr];
    else
        sr = s/maximum_try;
        SR = [SR,sr];
    end
    % stop condition 1: new node is within epsilon distance to end
    % configuration
    if norm(q_new.val-q_goal.val)< epsilon
        break;
    end
    %stop condition 2: connection of new node and end configuration
    %contains no collision
    if ~DetCol(q_new,q_goal,map)
        break
    end
    maximum_try = maximum_try + 1;    
end
% if try 500 times, return failure
if maximum_try == 501
    success = 0;
    return
end
% find the path by iteration
q = q_new;
while ~isequal(q.val,q_start.val)
    path = [q;path];
    q = q.parent;
end
%add start and end goal to path since the last node might not be within
%epsilon distance to end configuration
path = [q_start;path;q_goal];
path = path_opt(path,map,T);
[a,b] = size(path);
% get the values of path and return it as path_plot. it's for plotting
for i= 1:a
    path_plot = [path_plot;path(i).val];
end
end
