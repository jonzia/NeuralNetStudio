% Finding hidden unit values
for r = f:-1:1
    if r < f
        for l = 1:layers
            if l == 1
                for m = 1:num_hidden
                    temp = dot(X(:,r),W(1:num_inputs,m,l)) + dot(Y(l,:,r+1),H(:,m,l));
                    Y(l,m,r) = 1/(1 + exp(-k*temp));
                end
            else
                    temp = dot(Y(l-1,:,r),W(:,m,l)) + dot(Y(l,:,r+1),H(:,m,l));
                    Y(l,m,r) = 1/(1 + exp(-k*temp));
            end
        end
    else
        for l = 1:layers
            if l == 1
                for m = 1:num_hidden
                    temp = dot(X(:,r),W(1:num_inputs,m,l));
                    Y(l,m,r) = 1/(1 + exp(-k*temp));
                end
            else
                    temp = dot(Y(l-1,:,r),W(:,m,l));
                    Y(l,m,r) = 1/(1 + exp(-k*temp));
            end
        end
    end
end
% Finding output values (o) to compare to training values (t)
for r = 1:f
    temp = dot(W0(:,1),Y(layers,:,r));
    o(1,r) = 1/(1 + exp(-k*temp));
end