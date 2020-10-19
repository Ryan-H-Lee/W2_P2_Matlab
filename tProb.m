% tProb: retruns a List of probabilites of each output state
% state: a vector of die values
% action: a boolian vector of flip no flip
function pMatrix = tProb( state, action, stateSpace)
%Calculate the possible outcome states for a given roll
nFaces = stateSpace(end,end);
nFlipped = sum(action);
nDice = size(state,1);
%Generate a vector to turn state into index (count in base nFaces)
basisVector = nFaces.^[0:(nDice-1)];

% Get the probability of each outcome
p = 1/(nFaces^nFlipped);
% Use non changing values to count by base nFaces
baseVal = sum(((state-1).*~(logical(action)))'.*basisVector) + 1;
% Use changing values to index the rest of the set
offsets = sum( ( countUp(nFlipped,nFaces)' .* basisVector(find(action)) ),2);

% Assign the probability to the correct row
pMatrix = zeros( size(stateSpace,2),1);
pMatrix( baseVal + offsets) = p*ones(size(offsets,1),1);

% for vect = 1:nMatch
%     % If the vectors match subtracting should give all 0s so all will be
%     % one
%     sNum = all(stateSpace - repmat(outcomes(:,vect), 1,size(stateSpace,2)) == 0);
%     % Find the index for the one value with 1 
%     sNum = find(sNum);
%     pMatrix(sNum) = p; %assign a probability to that state.
% end

end