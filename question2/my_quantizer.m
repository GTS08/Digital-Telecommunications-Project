function [xq,centers] = my_quantizer(x,N,min_value,max_value)
    
    % Check for errors
    if (nargin ~= 4)
        error ("myhuffmanenco: The arguments must be four");
    end
        
    % Limit dynamic range of singal
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

    % Check for every value of input signal in which interval it belongs
    for i = 1:length(x)
        for j=1:intervals
            if (x(i) >= (centers(j)-(delta/2)) && x(i) <= (centers(j)+(delta/2)))
                xq(i) = j;
            end
        end
    end
    
    xq = xq';
    centers = centers';

end
