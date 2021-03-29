function [xq, centers, D] = Lloyd_Max(x, N, min_value, max_value)

    % Check for errors
    if (nargin ~= 4)
        error ("myhuffmanenco: The arguments must be four");
    end
        
    % Limit dynamic range of signal
    for i = 1:length(x)
        if x(i) > max_value
            x(i) = max_value;
        elseif x(i) < min_value
            x(i) = min_value;
        end
    end
    
    % Calculate intervals
    intervals = (2^N);
    
    % Calculate distance
    distance = (abs(min_value) + max_value);
    
    % Calculate delta
    delta = distance/intervals;
    
    % Calculate centers
    centers(1) = max_value - (delta/2);
    for i = 2:intervals
        centers(i) = centers(i-1) - (delta);
    end
    centers = flip(centers);
    
    % Counter
    iter=1;

    % Main loop
    while 1

        % Initialize T
        T(1) = -inf;
        for j=2:intervals
            T(j)= ( centers(j-1)+centers(j)) / 2 ;
        end
        T(intervals+1) = inf;

        % Quantize signal
        for i=1:length(x)
            for j=1:intervals
               if ((x(i)<=T(j+1)) && (x(i)>=T(j)))
                       xq(i) = j;
               end
            end
        end

        % Average distortion
        d = mean((x-xq').^2);
        D(iter) = d;

        % New centers
        for k=1:intervals
            centers(k) = mean ( x ( x>T(k) & x<T(k+1) ));
        end

        if (iter > 1)
            diff = abs(D(iter)-D(iter-1));
        else
            diff = abs(D(iter));
        end
        
        if (diff < eps)
            break;
        end
        
        % Incement counter
        iter = iter + 1;

    end
    centers = centers';
    xq = xq';
    
end
