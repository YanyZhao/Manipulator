function q_near = Neighbor(q_curr,T)
%% find the closest valid node in T w.r.t current q
% input. current q: q_curr, Tree T
% output. closest q(struct)
[n,m] = size(T);
q_near = T(1);
min_dis = norm(q_near.val-q_curr.val);
if n>2
    for i=2:n
        %choose neighbors nodes that are valid
        if T(i).flag==1
            q = T(i);
            dis = norm(q.val-q_curr.val);
            if dis<min_dis
                min_dis = dis;
                q_near = T(i);
            end
        end
    end
end
end