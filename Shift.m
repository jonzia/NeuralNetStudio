for r = f:-1:2
    X(:,r) = X(:,r-1);
    targets(:,r) = targets(:,r-1);
end