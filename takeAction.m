% takeAction: generates new possbile states given a state and an action
% state: is the column vector with each element representing the showing
%        face of a diece
% action: is a column vector of flip not flip for a given dice
% outcomes: is a list of column vectors with possible exit states

function outcomes = takeAction( state, action, stateSpace)
% add up the number of fliped (1s) die
numFlipped = sum(action);
% get highest face number from the state space
nFaces = max(max(stateSpace, [],2), [], 1) + 1;

% Identify which rows will be changed
replaceRows = find(action);
% Generate values for the rows that are changing
replaceVals = countUp(length(replaceRows), nFaces);

% Start the output matrix by, copying the old state, for each new state
outcomes = repmat(state, 1,size(replaceVals,2));
% Replace the changed rows with the set of values generated in replaceVals
outcomes(replaceRows ,:) = replaceVals;


end