% See computational method detailed in "Machine Learning" by Tom M.
% Mitchell (International Edition, 1977) pp. 98.
% "For each network output unit k, calculate its error term..."
% This network is fixed to one output unit per frame when unfolded:
for r = 1:f
    d_k(1,r) = o(1,r)*(1-o(1,r))*(targets(1,r) - o(1,r));
end
% "For each hidden unit h, calculate its error term..."
% This network has num_hidden hidden units.
%Calculating d_h for W terms:
for r = 1:f
    for l = layers:-1:1
        if l == layers
            for m = 1:num_hidden
               d_h_w(l,m,r) = Y(l,m,r)*(1-Y(l,m,r))*W0(m,1)*d_k(1,r);
            end
        else
               d_h_w(l,m,r) = Y(l,m,r)*(1-Y(l,m,r))*dot(W(m,:,l),d_h_w(l+1,:,r));
        end
    end
end
% Calculating d_h for H terms:
for r = 1:f-1
    for l = layers:-1:1
        for m = 1:num_hidden
           d_h_h(l,m,r) = Y(l,m,r+1)*(1-Y(l,m,r+1))*dot(H(m,:,l),d_h_w(l,:,r));
        end
    end
end