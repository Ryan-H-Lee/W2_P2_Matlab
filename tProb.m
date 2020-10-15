% tProb: retruns a List of probabilites of each output state
% state: a vector of die values
% action: a boolian vector of flip no flip
function pMatrix = tProb( state, action, stateSpace)
%Calculate the possible outcome states for a given roll
outcomes = takeAction( state, action, stateSpace);

nMatch = size(outcomes,2);
% Get the probability of each outcome
p = 1/nMatch;
% Assign the probability to the correct row
pMatrix = zeros( size(stateSpace,2),1);
for vect = 1:nMatch
    % If the vectors match subtracting should give all 0s so all will be
    % one
    sNum = all(stateSpace - repmat(outcomes(:,vect), 1,size(stateSpace,2)) == 0);
    % Find the index for the one value with 1 
    sNum = find(sNum);
    pMatrix(sNum) = p; %assign a probability to that state.
end

end