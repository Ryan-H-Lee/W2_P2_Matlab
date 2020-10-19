%This code generates a Transition Probability p(s'|s,a)
function transProb = generateTransitonProbSet2(stateSpace, actionSpace)
    stateNo = max(stateSpace,[],'all');
    diffStateSets = size(stateSpace,2);
    faceHist = zeros(stateNo,diffStateSets);
    actionNo = size(actionSpace,2);
    for i = 1:stateNo
        faceHist(i,:) = sum(double(stateSpace == i),1);
    end
    
    pageState = zeros(stateNo,diffStateSets,diffStateSets);
    for i = 1:diffStateSets
        pageState(:,:,i) = repmat(faceHist(:,i),1,diffStateSets);
    end
    faceHistPage = repmat(faceHist,1,1,size(stateSpace,2));
    dieDifference = (pageState-faceHistPage)
    dieDifferenceSym = (dieDifference<0).*dieDifference
    dieDifferenceNo = sum(abs(pageState-faceHistPage),1);
    dieDifferenceNo = permute(dieDifference,[2 1 3]);
%     faceHistPage
%     pageState
%     dieDifference
%     permute(dieDifference,[2 1 3])
    transProb = zeros(diffStateSets,actionNo,diffStateSets);
    for i = 1:actionNo
%         for j = 1:sum(actionSpace(:,i))
        if  sum(double(actionSpace(:,i)))==1
            stateRoll = sum(bsxfun(@times,actionSpace(:,i),stateSpace),1);
            rollMatrix = zeros(stateNo,diffStateSets);%,diffStateSets);
            idx = sub2ind(size(rollMatrix), stateRoll, ...
                1:diffStateSets);
% %             diffMatrix(1:diffStateSets,i,1:diffStateSets)=1
            rollMatrix(idx)=1;
            diffMatrix = (bsxfun(@plus,double(rollMatrix),dieDifferenceSym))
%             diffMatrix = sum(abs(diffMatrix),1)
            diffMatrix2 = (sum(abs(diffMatrix),1)==0)+...
                (sum(abs(dieDifference),1==0));
%     transProb = zeros(size(stateSpace,2),size(actionSpace,2), size(stateSpace,2));
%     for nState = 1:size(stateSpace,2)
%         for nAct = 1:size(actionSpace,2)
%             transProb(nState,nAct,:) = tProb(stateSpace(:,nState),actionSpace(:,nAct), stateSpace);
%         end
        end
    end
end