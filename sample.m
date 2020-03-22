function q = sample(q_start,q_goal,sr)
p = rand();
% those are different epsilon functions
% epsilon = (exp(2*sr)-1)/(1.25*exp(2));%SR1
% epsilon = (exp(2*sr)-1)/(1.58*exp(2));%SR2
% epsilon = (exp(2*sr)-1)/exp(2);%SR3
epsilon = (exp(2*sr)-1)/(0.87*exp(2));%SR4
if p>epsilon
    q = RandomNode(q_start,q_goal);
else
    q = q_goal;
end
end


