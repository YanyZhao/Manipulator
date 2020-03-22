function [path_new,T_new] = path_opt(path,map,T)
%% input: oringinal path obtained from RRT(n*6, struct)
%  output: optimized path(n*6,struct)
path_new = prun(path,map);
[path_new,T_new] = expand(path_new,map,T);
end
%% prun the path
function path_new = prun(path,map)
%% input: oringinal path obtained from RRT(n*6, struct)
%  output: pruned path(n*6,struct)
path_new = path(1);
[n,m] = size(path); 
i = 1;
%if we only have two sample points:
if n<3
    path_new =  path;
else   
%we have 3 or more sample points:
    while i<n
        for j= i+2:n %following nodes
            q = path(i);
            q_ = path(j);
            if j == n % we have reached the very end of the pruning process
                path_new = [path_new;path(n-1);path(n)];
                return
            end
            if DetCol(q,q_,map)
                % if the connection line contains no collision, ignore it. 
                % else, add the former node into the path
                path_new = [path_new;path(j-1)];
                i = j-1;
                break
            end
        end    
    end    
end
end
%% insert necessary nodes to make the path roughly evenly distributed
function [path_new,T_new] = expand(prunned_path,map,T)
T_new = T;
[n,m]=size(prunned_path);
path_new = prunned_path(1);
insert.val = [];
insert.parent = [];
insert.flag = 0;
max_length = 1;
for i=1:n-1
    length = norm(prunned_path(i).val-prunned_path(i+1).val);
    if length > max_length
        % if the length of connection link is bigger than max_length, add a mid point
        insert.val = (prunned_path(i).val+prunned_path(i+1).val)/2;
        for j=1:50
            % if the mid point contains collision, try some random nodes
            insert.val = prunned_path(i).val+(prunned_path(i+1).val-prunned_path(i).val)*randi([30,70])/100;
            DetCol(insert,prunned_path(i),map)
            if ~DetCol(insert,prunned_path(i),map)
                break
            end
        end
        if j<50
            % add inter-points into the path and tree, set the correct parents to
            % the new node and the following node
            insert.parent = prunned_path(i);
            insert.flag = 1;
            prunned_path(i+1).parent = insert;
            path_new = [path_new;insert];
            T_new = [T_new;insert];
        end
    end
    path_new = [path_new;prunned_path(i+1)];
end
end

