function q_new = Extend(q_curr,q_next)
% extend the current node some distance to the next node
yita = randi([1,7])/10;
q_new.val = q_curr.val+yita*(q_next.val-q_curr.val);
q_new.parent = q_curr;
q_new.flag = 1;
end