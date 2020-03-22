function q = RandomNode(q_start,q_goal)
q.val = zeros(1,6);
q.parent = [];
q.flag = 1;
q.val(1) = randi([-14,14])/10;
q.val(2) = randi([-12,14])/10;
q.val(3) = randi([-18,17])/10;
q.val(4) = randi([-19,17])/10;
end