function cw_list = myhuffmandict (sym, source_prob)

    % Check for errors
    if (nargin < 2)
        error ("myhuffmandict: The arguments must be two");
    elseif ((sum(source_prob) - 1.0) > 1e-7)
        error ("myhuffmandict: Probabilities must add up to 1");
    end
    
    origsource_prob = source_prob;
    
    % Find length of probabilities
    L = length (source_prob);
    index = (1:L);
    for itr1 = 1:L
        for itr2 = itr1:L
            if (source_prob(itr1) < source_prob(itr2))
                t = source_prob(itr1);
                source_prob(itr1) = source_prob(itr2);
                source_prob(itr2) = t;

                t = index(itr1);
                index(itr1) = index(itr2);
                index(itr2) = t;
            end
        end
    end
    
    
    % Initialize struct of probability and symbols
    stage_list = {};
    cw_list    = cell (1, L);

    stage_curr = {};
    stage_curr.prob_list = source_prob;
    stage_curr.sym_list = {};
    S = length (source_prob);
    for i = 1:S
        stage_curr.sym_list{i} = (i);
    end


    I = 1;
    while (I < S)
        % Find the current length of the probability list
        L = length (stage_curr.prob_list);

        % Add the last two probabitlities
        nprob = stage_curr.prob_list(L-1) + stage_curr.prob_list(L);
        % Combine the last two symbols into one
        nsym = [stage_curr.sym_list{L-1}(1:end), stage_curr.sym_list{L}(1:end)];

        % Keeps history of changes
        stage_list{I} = stage_curr;


        % Find where to put the combined probabilities
        for i = 1:(L-2)
            if (stage_curr.prob_list(i) < nprob)
                break;
            end
        end


        % Put the combined sum of probabiltities to the index found above
        stage_curr.prob_list = [stage_curr.prob_list(1:i-1) nprob stage_curr.prob_list(i:L-2)];
        % Put the combined symbols to the index found above
        stage_curr.sym_list = {stage_curr.sym_list{1:i-1}, nsym, stage_curr.sym_list{i:L-2}};


        I = I + 1;
    end


    one_cw = 1;
    zero_cw = 0;


    I = I - 1;
    while (I > 0)
        % Set the stage
        stage_curr = stage_list{I};

        % Get the number of current elements
        L = length (stage_curr.sym_list);

        % Get the last element of the stage
        clist = stage_curr.sym_list{L};
        for k = 1:length(clist)
            % Add 1 to respective list
            cw_list{1,clist(k)} = [cw_list{1,clist(k)} one_cw];
        end

        % Get the last minus 1 element of stage
        clist = stage_curr.sym_list{L-1};
        for k = 1:length(clist)
            % Add 0 to respective list
            cw_list{1,clist(k)} = [cw_list{1,clist(k)}, zero_cw];
        end

        % Go to previous stage
        I = I - 1;
    end
    
    S = length (source_prob);
    for itr = (S+1):length (origsource_prob)
        cw_list{1,itr} = -1;
    end
    
    nw_list = cell (1, L);
 
    L = length (source_prob);
    for itr = 1:(L)
        t = cw_list{index(itr)};
        nw_list{index(itr)} = cw_list{itr};
    end
    cw_list = nw_list;
    
    % Format the output
    C = {1, length(sym)};

    for m = 1:length(sym)
        C{1, m} = sym(m);
    end

    for m = 1:length(cw_list)
        C{2, m} = cw_list{1, m};
    end

    cw_list = C';

end
