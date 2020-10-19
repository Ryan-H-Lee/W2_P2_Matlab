% state: column vectors of dice where each element is the die value
% maxFace: how many sides do these die have
% Hist: column vectors where the first row is the number of die in a state
%   showing 1, 2nd row is number of 2s etc...
%this function will take a list of dice and their state and return a column

function hist = getFaceHist(state, maxFace)
    nStates = size(state,2);
    %Holds output values
    hist = zeros(maxFace,nStates);
    %Check each face value
    for faceVal = 1:maxFace
        % how many of faceVal are in each column vector state
        hist(faceVal,:) = sum(state == faceVal,1);
    end
end