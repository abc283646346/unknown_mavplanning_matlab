function phi_hat = kernelFeatures(param, x_query, map, option)
    % X : Query point
    % X_data : Sample points
    % Create data from binary occupancy points
    res = 1/(param.hilbertmap.resolution);
    [X, Y] = meshgrid(res:res:map.XWorldLimits(2), res:res:map.YWorldLimits(2));
    X = X(:);
    Y= Y(:);
    xy = [X, Y];

   phi_hat = zeros(size(xy, 1), 1);
   
   switch option
       case 'rbf'
           phi_hat = kRadial(x_query, xy, param.hilbertmap.radius);
       case 'sparse'
           phi_hat = kSparse(x_query, xy, param.hilbertmap.radius);
       case 'threshold'
           phi_hat = kThreshold(x_query, xy, param.hilbertmap.radius);
   end

end

function k = kRadial(x, x_hat, radius)

    x = reshape(x', [1, 2, size(x, 1)]);
    r = vecnorm(x-x_hat, 2, 2);
    
    k = exp(-0.5*(r.^2)/((0.5*radius)^2));
    k = squeeze(k);

end


function k = kSparse(x, x_hat, radius)
    k= zeros(size(x_hat, 1), 1, size(x, 1));
%     omega = eye(2); % Omega is positive semi definite
    rth = radius;
%     r = sqrt((x-x_hat)*omega*(x-x_hat)');
    x = x;
    x = reshape(x', [1, 2, size(x, 1)]);
    r =  (1/rth)*vecnorm(x-x_hat, 2, 2);
    
    mask = r < 1;
    k(mask) = (2 + cos(2*pi()*r(mask))/3).*(1-r(mask)) + (1/(2*pi()))*sin(2*pi()*r(mask));
    k = squeeze(k);

end

function k = kThreshold(x, x_hat, radius)
    k= zeros(size(x_hat, 1), 1, size(x, 1)); 
    rth = radius;
    x = reshape(x', [1, 2, size(x, 1)]);
    r = vecnorm(x-x_hat, 2, 2);
    
    thr_mask = r < rth;
    
    k(thr_mask) = (rth - r(thr_mask)) / rth;
    k = squeeze(k);
end