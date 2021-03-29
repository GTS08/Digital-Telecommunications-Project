function symbols = myhuffmandeco (hcode, dict)
  
    % Check for errors
    if (nargin ~= 2)
        error ("myhuffmanenco: The arguments must be two");
    elseif (~all((hcode == 1) + (hcode == 0)) || ~isvector(hcode))
        error ("myhuffmandeco: hcode must be a binary vector");
    elseif (~iscell (dict))
        error ("myhuffmandeco: dict must be a dictionary from myhuffmandict");
    end

    % Convert the dictionary to a tree represented by an array.
    tree = dict2tree (dict(:,2));

    % Traverse the tree and store the symbols.
    symbols = [];
    pointer = 1;
    for i = 1:length(hcode)
        % If you find a symbol that the pointer is pointing, add it to symbols  
        if (tree(pointer) ~= -1)
            symbols = [symbols, tree(pointer)];
            %Reset the pointer
            pointer = 1;
        end
        % Increment the pointer based on current hcode index
        pointer = 2 * pointer + hcode(i);
    end

    % Check if decoding was successful
    if (tree(pointer) == -1)
        warning ("myhuffmandeco: Decoding was unsuccessful")
    end
    % Return the symbols
    symbols = [symbols, tree(pointer)]';

end

function tree = dict2tree (dict)
  
    % Set the length of dict
    L = length (dict);
    lengths = zeros (1, L);

    % Get lengths of each word in dict
    for i = 1:L
        lengths(i) = length (dict{i});
    end

    % Find the length of the biggest word (depth of the tree)
    m = max(lengths);

    % Initialize the tree (array)
    %tree = zeros(1, 2^(m+1)-1)-1;

    for i = 1:L
        pointer = 1;
        word    = dict{i};
        for bit = word
            pointer = 2 * pointer + bit;
        end
        tree(pointer) = i;
    end
end
