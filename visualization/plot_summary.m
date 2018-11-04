function [videoObj] = plot_summary(param, globalmap, partialmap, mavpath, globalpath, mavpose, videoObj)

    plot_binmap(param, globalmap, mavpath, globalpath, mavpose);
    videoObj = plot_localmap(param, partialmap, mavpose, mavpath, globalpath, videoObj);
    drawnow
end

function plot_binmap(param, map, localpath, globalpath, pose)
    
    subplot(1,2,1);
    
    show(map); hold on;
    plot(localpath(:, 1), localpath(:, 2), 'g'); hold on;
    plot(localpath(end, 1), localpath(end, 2), 'b'); hold on;
    plot(globalpath(:, 1), globalpath(:, 2), 'r'); hold on;
    plot(pose(1), pose(2), 'xr','MarkerSize',10); hold on;
    rectangle('Position',[pose(1)-0.5*param.localmap.width, ...
                          pose(2)-0.5*param.localmap.height, ...
                          param.localmap.width, ...
                          param.localmap.height], ...
                          'EdgeColor', 'b');
    hold off;
    
end

function [video_obj] = plot_localmap(param, map, pose, localpath, globalpath, video_obj)
    
    subplot(1,2,2);
    
    show(map); hold on;
    switch param.mapping
        case 'local'
            plot(0.5*param.localmap.width, 0.5*param.localmap.height, 'xr','MarkerSize',10); hold off;
        case 'increment'
            plot(localpath(:, 1), localpath(:, 2), 'g'); hold on;
            plot(localpath(end, 1), localpath(end, 2), 'b'); hold on;
            plot(pose(1), pose(2), 'xr','MarkerSize',10); hold off;
    end
    image = occupancyMatrix(map);
    frame = image;
    writeVideo(video_obj, frame);
end

function plot_map(map, pose, intsectionPts, angles)    
    show(map);
    hold on;
    plot(pose(1), pose(2), 'xr','MarkerSize',10);
    hold on;
    plot(intsectionPts(:,1),intsectionPts(:,2) , '*r'); % Intersection points
    hold on;
    for i = 1:size(intsectionPts, 1)
        plot([pose(1),intsectionPts(i,1)],...
            [pose(2),intsectionPts(i,2)],'-b') % Plot intersecting rays
    end
    hold off;
end
