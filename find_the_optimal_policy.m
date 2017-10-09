% Oliver Struckmeier
% Aalto University 2017
function [ optimal_policy ] = find_the_optimal_policy( discount, livingReward, noise )
%========================INIT============================================
%define the size of the 2D-Array
x_max = 5;
y_max = 5;
xS = 1;                             %x-position of the starting point
yS = 2;                             %y-position of the starting point
r = zeros(x_max, y_max);            %initializing the array that contains the rewards
policy = ones(x_max, y_max);        %initializing the array containing the policies

%===================print graph and build network========================
%this function initializes the animation and can be used to add and remove
%obstacles and terminal states and set their rewards
[r, policy] = print_grid(r, x_max, y_max, policy, xS, yS);

%==================Markov Decision Process===============================
%====Markov INIT====
N = 1000;                      %max number of iterations of Value Iteration
deltaMin = 0.0000000001;       %convergence criterion for iteration     
states = [x_max * y_max, 6];   %matrix to store the 6 values for x, y, reward, utility, utility, policey in this order
                               %used for easy data transfer to other
                               %functions

%putting the 6 values in the states list
state_index = 1;                            %index for tracking the current state
for i = 1:x_max
    for j = 1:y_max
          states(state_index,1) = i;
          states(state_index,2) = j;
          states(state_index,3) = r(i,j);
          states(state_index,4) = 0;
          states(state_index,5) = 0;
          states(state_index,6) = policy(i,j);
          state_index = state_index + 1;
    end
end
r = states(:,3);                  %instantaneous reward
utility_update = states(:,4);     %utility used in updates
utility = states(:,5);            %long-term utility
policy = states(:,6);             %policy

%do while the current delta is smaller than the delta limit and until we
%reached the amount of steps we want to take for the value iteration
n=0;
while 1
    states(:,5)=states(:,4);    %utility=utility_update
    utility=utility_update;    
    n=n+1;    
    delta = 0;                  %value for convergence   
    for i=1:x_max
        for j=1:y_max
            %do the actual markov decision process
            policy_update = MDP(i,j,states, discount, noise, livingReward);
            %extract the return data
            utility_update = policy_update(:,1);
            policy = policy_update(:,2);
            %fill data into states list
            states(:,4) = utility_update;
            states(:,6) = policy;
            %calculate convergence factor
            k = find(states(:,1) == i & states(:,2) == j);
            delta_update=abs(utility_update(k) - utility(k));
            if delta_update > delta
                delta = delta_update;
            end
        end
    end
    %stop condition (1000 passes or reaching convergence limit)
    if (delta < deltaMin || n > N)
        break;
    end    
end

%output the rewards and policy to the gui
for i = 1 : x_max
    for j = 1 : y_max
        cur = find(states(:,1) == i & states(:,2) == j);
        text(i-.8, j-.4, strcat('r = ', num2str(utility(cur))), 'color', [0 0.9 0])
        if policy(cur) == 1
            text(i-.5, j-.6, '\rightarrow', 'color', [0 0 0])
        end
        if policy(cur) == 2
            text(i-.5, j-.6, '\uparrow', 'color', [0 0 0])
        end
        if policy(cur) == 3
            text(i-.5, j-.6, '\leftarrow', 'color', [0 0 0])
        end
        if policy(cur) == 4
            text(i-.5, j-.6, '\downarrow', 'color', [0 0 0])
        end
    end
end
%build policy matrix:
pol = zeros(x_max, y_max);
pol = rot90(vec2mat(policy, x_max));
optimal_policy = pol;
end

