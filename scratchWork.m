% you have n dice
% each die has m faces
nFace = 6
nDice = 5
nActs  = 2; %Flip or not
faceWorth = [1:nFace]'; %How many points is a face worth
maxH = 2;
gamma = 1;


stateSpace = countUp(nDice, nFace);
%Offset state space by 1 so that they match the die faces ie 1,2,3 not 0,1,2
stateSpace = stateSpace + ones(size(stateSpace));

actionSpace = countUp(nDice, nActs);
actionSpace

%% Test for generating outcome states
action = actionSpace(:, 4)
state = stateSpace(:,1)

numFlipped = sum(action)
nFaces = max(max(stateSpace, [],2),[],1)
replaceRows = find(action)
replaceVals = countUp(length(replaceRows), nFaces) + 1;

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


% transProb = zeros(size(stateSpace,2),size(actionSpace,2), size(stateSpace,2));
% for nStates = 1:size(stateSpace,2)
%     for nActs = 1:size(actionSpace,2)
%         transProb(nStates,nActs,:) = tProb(stateSpace(:,nStates),actionSpace(:,nActs), stateSpace);
%     end
% end
% 
% transProb
%Generate all transition prob pairs in matrix
transProb = generateTransitonProbSet(stateSpace, actionSpace)

% sum(transProb- transProb2, 'all')% if the matrices match this sum is 0

%% Reward Function
% Ways to get rewards are defined to have the from: r(s,a,s')

faceHist = getFaceHist(stateSpace,nFace)
%If we are allowing Heads to be 1 tails to be 2
stateReward = max( faceHist.*faceWorth,[],1)';
%Assuming the points only depend on the final state then r(s,a,s') is just
%Ns,Na coppies of stateReward
rsas = zeros(size(stateSpace,2),size(actionSpace,2),size(stateSpace,2));
%Tile the state Reward vector for all state action pairs
for ind = 1:size(stateSpace,2)
    for act = 1:size(actionSpace,2)
        rsas(ind,act,:) = stateReward;
    end
end


%% Value Iteration
% %at H = 0 the values are the current values of the state sum of max dice
% faceHist = getFaceHist(stateSpace,nFace);
% val = zeros( size(max( faceHist.*faceWorth,[],1)'));
% nActs = size(actionSpace,2);
% nStates = size(stateSpace,2);
% 
% valLast = val
% for step = 1:maxH
%     %Loop through all starting states
%     for sNum = 1:nStates
%         %For each state find the Value for each action
%         for aNum = 1:nActs
%             %sum accross the s' for a state and action Pair 
%             newPolicyVals(sNum,aNum) = sum( transProb(sNum,aNum,:).*( rsas(sNum,aNum,:) + gamma*valLast(sNum) ));
%         end
%         [bestVal, a] = max(newPolicyVals(sNum,:));
%         valLast(sNum) = bestVal; 
%         policy(sNum,step) = a;
%     end
% end
% 
% policy
% valLast