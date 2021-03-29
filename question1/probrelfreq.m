function probrelfreq = probrelfreq(arr, symb)

    freq = tabulate(arr);
    result = freq(:,3);
    
    for i = 1:length(result)
        result(i) = result(i)/100;
    end
    
    if (length(result) < length(symb))
        fill = length(symb) - length(result);
        for k = 1:fill
            result = [result; 0];
        end
    end
    
    probrelfreq = result';
end
