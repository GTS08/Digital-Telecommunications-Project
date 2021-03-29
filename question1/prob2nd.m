function prob2nd = prob2nd(arr)

    result = [];

        for i=1:length(arr)
            for j=1:length(arr)
                result = [result arr(i)*arr(j)];
            end
        end 

    prob2nd = result;
end
