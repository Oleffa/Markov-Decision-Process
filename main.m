% Oliver Struckmeier
% Aalto University 2017

%====================Part 1========================
find_the_optimal_policy(0.9, 0.0, 0.2)

%====================Part 2========================
%a) prefer close exit (+1) risking the cliff (-10):     0.2, 0.1, 0.0
%find_the_optimal_policy(0.2, 0.1, 0.0)
%find_the_optimal_policy(0.2, 3, 0.0) %if the living reward is greater than 3 it takes the further away terminal state
%b) prefer close exit (+1) avoiding cliff (-10):        0.9, 0.0, 0.2
%find_the_optimal_policy(0.9, 0.0, 0.01)
%find_the_optimal_policy(0.5, 2, 0.1)
%c) prefer distant exit (+10), risking cliff (-10):     0.01, 9.0, 0.0
%find_the_optimal_policy(0.1, 9.0, 0.0)
%d) prefer distant exit (+10), avoiding cliff (-10):    0.9, 0.2, 0.2
%find_the_optimal_policy(0.9, 0.2, 0.2)
