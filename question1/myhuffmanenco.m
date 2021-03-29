function hcode = myhuffmanenco (sig, dict)

    % Error messages
    if (nargin ~= 2)
        error ("myhuffmanenco: The arguments must be two");
    elseif (~iscell(dict))
        error ("myhuffmanenco: The dict must be a cell");
    elseif (max (sig) > length (dict) || min (sig) < 1)
        error ("myhuffmanenco: Sig elements must be in the range of [1,N]");
    end

    % Get the column of codes from dict
    codes = dict(:,2)';

    % Encode the signal based on above codes
    hcode = [codes{sig}]';
  
end
