function isCol = DetCol(q_near,q_new,map)
load 'robot.mat' robot
% consider the case when input is not struct array
Dq1 = isstruct(q_near);
Dq2 = isstruct(q_new);
if Dq1
    q_near = q_near.val;
end
if Dq2
    q_new = q_new.val;
end
% choose 20 inter-points and check them one by one
n = 50;
isCol = 0;
t = linspace(0,1,n)';
morePath = (1-t)*q_near + t*q_new;
for jj = 1:size(morePath,1)
    if isRobotCollided(morePath(jj,:),map,robot)
        isCol=1;
        return
    end
end
end