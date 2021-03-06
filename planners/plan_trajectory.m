function [T, path, path_vel, path_acc]=plan_trajectory(param, binary_occupancygrid, start_position, goal_position, start_velocity, goal_velocity, start_acceleration, occupancymap, hilbert_map, planner_type)
%% Run Planner between start and endpoint depending on the planner type
if nargin < 5
    start_velocity = [0.0, 0.0];    
end
if nargin < 6
    goal_velocity = [0.0, 0.0];
end
if nargin < 7
    start_acceleration = [0.0, 0.0];
end
if nargin < 8
    occupancymap = [];
    localmap = [];
else
   localmap = occupancymap.localmap; 
end
if nargin < 9
    hilbert_map = [];
end
if nargin < 10
    planner_type = param.planner.type;
end

path_vel = [0.0, 0.0];
path_acc = [0.0, 0.0];

start_derivatives = [start_velocity; start_acceleration];
end_derivatives = [goal_velocity; [0.0, 0.0]];

% binary_occupancygrid.inflate(0.5);

switch planner_type
    case 'a_star'
        path = a_star(binary_occupancygrid, start_position, goal_position);
    
    case 'polynomial'
        trajectory = polynomial(binary_occupancygrid, start_position, goal_position, start_derivatives, end_derivatives);        
        if isempty(trajectory)
            disp('empty')
        end
        [T, path, path_vel, path_acc] = sample_trajectory(trajectory, 0.1);
        
    case 'chomp'

        trajectory = continous_chomp(binary_occupancygrid, start_position, goal_position, start_velocity, goal_velocity, start_acceleration);
        [T, path, path_vel, path_acc] = sample_trajectory(trajectory, 0.1);

    case 'informativechomp'

        trajectory = informative_chomp(param, binary_occupancygrid, start_position, goal_position, start_velocity, goal_velocity, start_acceleration, localmap, hilbert_map);
        [T, path, path_vel, path_acc] = sample_trajectory(trajectory, 0.1);

    case 'hilbertchomp'

        trajectory = hilbert_chomp(param, binary_occupancygrid, start_position, goal_position, start_velocity, goal_velocity, start_acceleration, localmap, hilbert_map);
        [T, path, path_vel, path_acc] = sample_trajectory(trajectory, 0.1);
        plot_hilbertmap(param, hilbert_map, occupancymap, [start_position, atan2(start_velocity(2), start_velocity(1))], path);

    case 'primitive'
        [T, path, path_vel, path_acc] = primitive(binary_occupancygrid, start_position, goal_position, start_velocity, goal_velocity, start_acceleration);
%         [T, path, path_vel, path_acc] = sample_trajectory(trajectory, 0.1);
end

end