function pMatrix = tProb( state, action, stateSpace)
outcomes = takeAction( state, action, stateSpace);

nMatch = size(outcomes,2)
p = 1/nMatch;
pMatrix = zeros( size(stateSpace,2),1);
for vect = 1:nMatch
    outcomes(:,vect);
    stateSpace - repmat(outcomes(:,vect), 1,size(stateSpace,2));
    sNum = all(stateSpace - repmat(outcomes(:,vect), 1,size(stateSpace,2)) == 0);
    sNum = find(sNum);
    pMatrix(sNum) = p;
end

end