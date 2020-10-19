% David Martinez
% 10/18/20

%% Set-up Variables

clc
clear all

%%
clc
nFace = 2
nDice = 2
nActs  = 2; %Flip or not
faceWorth = [1:nFace]'; %How many points is a face worth
maxH = 2;
gamma = 1;
targetScore = 2;


stateSpace = countUp(nDice, nFace);
%Offset state space by 1 so that they match the die faces ie 1,2,3 not 0,1,2
stateSpace = stateSpace + ones(size(stateSpace));
stateSpace

actionSpace = countUp(nDice, nActs);
actionSpace

faceHist = getFaceHist(stateSpace,nFace);
faceHist

transProb = generateTransitonProbSet2(stateSpace, actionSpace)

transProb = generateTransitonProbSet(stateSpace, actionSpace);
transProb

% yazScore = getscore(faceHist);
% yazScore

% stateReward = [yazScore>=targetScore];
% stateReward = yazScore;
% stateReward

% % valueFunction = zeros(1, size(actionSpace,2),...
% %     size(stateSpace,2));

% valueFunction = pagemtimes(double(repmat(stateReward,1,1,...
%     size(stateSpace,2))),transProb);
% valueFunction