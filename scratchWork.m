% you have n dice
% each die has m faces
nFace = 3
nDice = 3
nAct  = 2; %Flip or not
state = randi([1,nFace], nDice,1)

stateSpace = countUp(nDice, nFace);
stateSpace

actionSpace = countUp(nDice, nAct);
actionSpace

%% Test for generating outcome states
action = actionSpace(:, 6)
state = stateSpace(:,3)

numFlipped = sum(action)
nFaces = max(max(stateSpace, [],2),[],1) + 1
replaceRows = find(action)
replaceVals = countUp(length(replaceRows), nFaces)

%Calculate the possible actions for a given roll
outcomes = repmat(state, 1,size(replaceVals,2));
outcomes(replaceRows ,:) = replaceVals
nMatch = size(outcomes,2)
p = 1/nMatch;
pMatrix = zeros( size(stateSpace,2),1);
for vect = 1:nMatch
    sNum = all(stateSpace - repmat(outcomes(:,vect), 1,size(stateSpace,2)) == 0);
    sNum = find(sNum);
    pMatrix(sNum) = p;
end

pMatrix
%generate the transition prob list for state action pair using function
pMatrix2 = tProb(state, action, stateSpace)
sum(sum(pMatrix - pMatrix2)) % if the matrices match this sum is 0
%% Test for generating Transition Matrix


transProb = zeros(size(stateSpace,2),size(actionSpace,2), size(stateSpace,2))
for nState = 1:size(stateSpace,2)
    for nAct = 1:size(actionSpace,2)
        transProb(nState,nAct,:) = tProb(stateSpace(:,nState),actionSpace(:,nAct), stateSpace);
    end
end

transProb
%Generate all transition prob pairs in matrix
transProb2 = generateTransitonProbSet(stateSpace, actionSpace)

sum(transProb- transProb2, 'all')% if the matrices match this sum is 0