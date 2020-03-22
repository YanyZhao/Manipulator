function [T,path_plot,success] = Regrow(Trimmed_tree,start,goal,map)
%% Initial conditions
%input:
%        start point:start, shape:1,6
%        end point:goal, shape:1,6
%        Trimmed Tree
%output:
%        path_plot: path for plot, shape:n*6
%        success:boolin, whether goal is feasible
%        New tree: T
success = 1;
epsilon = 0.07;
q_start.val = start;
q_goal.val = goal;
q_start.parent = [];
q_goal.parent = [];
q_start.flag = 1;
q_goal.flag = 1;
path = [];
[len,wid] = size(Trimmed_tree);
T = Trimmed_tree(1:len-1,:);
%% main
maximum_try = 0;
while maximum_try<10000
    q_next = sample(q_goal);
    q_near = Neighbor(q_next,T);
    q_new = Extend(q_near,q_next);
    isCol = DetCol(q_near,q_new,map);
    if isCol==0
        T = [T;q_new];
        if norm(q_new.val-q_goal.val)< epsilon
            break;
        end
    end

    maximum_try = maximum_try + 1;    
end
if maximum_try == 10000
    success = 0;
    return
end
% get regrowed tree T
q_goal.parent = q_new;
T = [T;q_goal];
% get path(all structure entries)
q = q_new;
while ~isequal(q.val,q_start.val)
    path = [q;path];
    q = q.parent;
end
path = [q_start;path];
path_new = path_opt(path,map);
% get path for plotting(all float value entries)
path_plot = [];
[a,b] = size(path_new);
for i= 1:a
    path_plot = [path_plot;path_new(i).val];
end

end