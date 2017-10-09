% Oliver Struckmeier
% Aalto University 2017
function new_utility_policy = MDP(x,y,states, discount_factor, noise, living_reward)
%=============INIT======================
%init reward, utility and policy matrices
r=states(:,3);
utility_updates=states(:,4);
utility=states(:,5);
policy=states(:,6);
%init action array
action_buffer=[];
%init parameters for determining actions
success = (1 - noise);                          %refactor fail probabilty
fail = (1 - success) / 2;                       %split fail probabilty
boundary_x = max(states(:,1));                  %maximum x and y coordinates for the coordinate system
boundary_y = max(states(:,2));
sink_list = find(states(:,3) == 0);             %find all states with zer0 to be the sinks and save x and y
sink_x = states(sink_list(1),1);                %coordinates of these states
sink_y = states(sink_list(1),2);
%========================================
for k = 1:size(states,1)
    if (states(k,1) == x && states(k,2) == y)
        if r(k) ~= 0 %us the reward value of an unreachable state if the next state would be unreachable
            utility_updates(k) = r(k);
        else
            action_east = action(x, y, sink_x, sink_y, boundary_x,  0        , utility, states, k, 1);
            action_north= action(x, y, sink_x, sink_y, 0         , boundary_y, utility, states, k, 2);
            action_west = action(x, y, sink_x, sink_y, 0         ,  0        , utility, states, k, 3);
            action_south= action(x, y, sink_x, sink_y, 0         ,  0        , utility, states, k, 4);
            %save them in a buffer and add the possiblities of failure and
            %sucess up
            action_buffer(1) = action_north * success + (action_west + action_east) * fail;
            action_buffer(2) = action_south * success + (action_west + action_east) * fail;
            action_buffer(3) = action_west * success + (action_south + action_north) * fail;
            action_buffer(4) = action_east * success + (action_south + action_north) * fail;
            %then add living reward, reward and scale with discount factor
            for t = 1:4
               action_buffer(t) = discount_factor * (action_buffer(t) + living_reward + r(k));
            end
            %find the best action
            best_action = 1;
            for i = 1:size(action_buffer,2)
                %if the current action has a higher utility than the best
                %so far update the best action
                if action_buffer(best_action) < action_buffer(i)
                    best_action = i;
                end   
            end
            %update the update utility matrix with the best action
            utility_updates(k) = action_buffer(best_action);
            %update policy matrix
            if best_action == 4
               policy(k) = 1; %east
            end  
            if best_action == 1
               policy(k) = 2; %north
            end
            if best_action == 3
               policy(k) = 3; %west
            end
            if best_action == 2
               policy(k) = 4; %south
            end                      
        end        
    end
end
new_utility_policy = [utility_updates,policy];
end

