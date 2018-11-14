function local_goal = getLocalGoal(param, binoccupancy_map, curr_pose, path, goal, occupancy_map)

if nargin < 6
    occupancy_map = [];
end

if ~binoccupancy_map.getOccupancy(goal)
    % Local goal is global goal if global goal is free
    local_goal = goal;
else
    switch param.localgoal
        case 'frompath'
            %% Pick Goal from Path
            local_goal = goalfrompath(binoccupancy_map, path, curr_pose(1:2), param.plan_horizon);

        case 'random'
            %% Pick Random Goal
            local_goal = samplePosfromMap(binoccupancy_map);
            
        case 'nextbestview'
            %% Pick Next Best View
            local_goal = getNextBestView(param, binoccupancy_map, curr_pose, goal, occupancy_map);

    end
end


end