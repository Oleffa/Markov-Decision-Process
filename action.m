% Oliver Struckmeier
% Aalto University 2017
function utility_out = action(x, y, sink_x, sink_y, max_x, max_y, utility, states, k, type)
%This function calculates the utility of a special action
    if type == 1 %east
        %Prevent agent from taking turns to not possible states, like out
        %off the grid or into obstacles
        if ((x == sink_x - 1 && y == sink_y) || (max_x == x))
            utility_out = utility(k);
        else
            for i = 1:size(states,1)
                if (states(i,1) == x + 1 && states(i,2) == y)
                    row = i;
                end
            end
            utility_out = utility(row);
        end
    end
    if type == 2 %north
        if ((x == sink_x && y == sink_y-1) || (y == max_y))
            utility_out = utility(k);            
        else
            for i = 1:size(states,1)
                if (states(i,1) == x && states(i,2) == y + 1)
                    row = i;
                end
            end

            utility_out = utility(row);
        end
    end
    if type == 3 %west
        if ((x == sink_x + 1 && y == sink_y) || (x == 1))
            utility_out = utility(k);
        else
            for i = 1:size(states,1)
                if (states(i,1) == x-1 && states(i,2) == y)
                    row = i;
                end
            end
            utility_out = utility(row);
        end
    end
    if type == 4 %south
        if ((x == sink_x && y == sink_y+1) || (y == 1))
            utility_out = utility(k);
        else
            for i=1:size(states,1)
                if (states(i,1) == x && states(i,2) == y-1)
                    row = i;
                end
            end

            utility_out = utility(row);
        end
    end
end

