function outcomes = takeAction( state, action, stateSpace)
numFlipped = sum(action);
nFaces = max(stateSpace, [],'all') + 1;
replaceRows = find(action);
replaceVals = countUp(length(replaceRows), nFaces);

outcomes = repmat(state, 1,size(replaceVals,2));
outcomes(replaceRows ,:) = replaceVals;


end