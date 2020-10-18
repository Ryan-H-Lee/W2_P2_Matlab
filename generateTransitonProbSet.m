%This code generates a Transition Probability p(s'|s,a)
function transProb = generateTransitonProbSet(stateSpace, actionSpace)
    transProb = zeros(size(stateSpace,2),size(actionSpace,2), size(stateSpace,2));
    for nState = 1:size(stateSpace,2)
        for nAct = 1:size(actionSpace,2)
            transProb(nState,nAct,:) = tProb(stateSpace(:,nState),actionSpace(:,nAct), stateSpace);
        end
    end
end