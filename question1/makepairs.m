function makepairs = makepairs(arr)

    result = [];
    
    i = 1;
    while i <= length(arr)
        result = [result 26*(arr(i)-1) + arr(i+1) ];
        i = i + 2;
    end

    makepairs = result';
end
