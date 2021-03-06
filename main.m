%% Navigator
% Navigator runs a receding horizon planner between a randomly sampled
% start and goal point that are not unoccupied.
% 
% The implementation is included from the following papers
%   - Oleynikova (2016), Continuous-time trajectory optimization for online UAV replanning

%% Setup & loading
clc; clear all; close all;

% Parameters
% parameterfile = Param_TINYRANDOMFOREST;
% parameterfile = Param_RANDOMFOREST;
parameterfile = Param_LOCALRANDOMFOREST;
% parameterfile = Param_CORRIDOR;
% parameterfile = Param_LOCALCORRIDOR;
% parameterfile = Param_CORNER;
% parameterfile = Param_LOCALCORNER

num_trials = 2; % Number of trials for statistics
Test_planner = {'hilbertchomp', 'chomp'}; % Configuration for different test sets
Test_map = {'local', 'increment'};
Test_goalselection = {'frompath', 'nextbestview'};

% Test_planner = {'chomp'}; % Configuration for different test sets
% Test_map = {'increment'};
% Test_goalselection = {'nextbestview'};


%% Initialize variables for statistics
num_tests = size(Test_planner, 2);

D = zeros(num_tests, num_trials); % Distance traveled
T = zeros(num_tests, num_trials); % Time taken
S = zeros(num_tests, num_trials); % Success Mask

%% Navigate through environment and store results
for i = 1:num_trials
    for j=1:num_tests
        % Switch test cases
        parameterfile.planner.type = Test_planner{j};
        parameterfile.mapping = Test_map{j};
        parameterfile.localgoal = Test_goalselection{j};

        %% Generate Map only once
        if parameterfile.map_generate
            [map, start_pos, goal_pos] = generate_envwithPos(parameterfile, parameterfile.start_point, parameterfile.goal_point);
            parameterfile.start_point = start_pos;
            parameterfile.goal_point = goal_pos;
            save map;
            parameterfile.map_generate = false;
        else
            map = load('map.mat', 'map');
            map = map.map;
        end
        %% Start Navigation

        [time, path, failure] = navigate(parameterfile, map); % All Navigation works in here
        S(j, i) = ~failure;
        
        if ~failure
            distance_traveled = pathlength(path);
            D(j, i) = distance_traveled;
            T(j, i) = time;
        end
    end
    parameterfile.map_generate = true;
end

%% Calculate analytics
calc_analytics(D, T, S, num_tests, Test_planner, Test_goalselection);