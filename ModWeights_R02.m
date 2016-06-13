% To update the output weights, delta_w must be calculated for each
% term in the time series and accumulated.

% Calculating delta_w for final layer
delta_W0 = zeros(num_hidden,1);
for r = 1:f
    for m = 1:num_hidden
        delta_W0(m,1) = delta_W0(m,1) + n*d_k(1,r)*Y(layers,m,r);
    end
end
W0 = W0 + delta_W0;

% To update the rest of the W terms, delta_w must be calculated for
% each term.
delta_W = zeros(num_hidden,num_hidden,layers);
for r = 1:f;
    for l = 1:layers
        if l == 1
            for m = 1:num_hidden
                delta_W(1:num_inputs,m,l) = delta_W(1:num_inputs,m,l) + n*d_h_w(l,m,r)*X(:,r);
            end
        else
            for m = 1:num_hidden
                delta_W(:,m,l) = delta_W(:,m,l) + transpose(n*d_h_w(l,m,r)*Y(l-1,:,r));
            end
        end
    end
end
W = W + delta_W;

% To update the H terms, we follow the same process as above.
delta_H = zeros(num_hidden,num_hidden,layers);
for r = 1:f-1
    for l = 1:layers
        for m = 1:num_hidden
            delta_H(:,m,l) = delta_H(:,m,l) + transpose(n*d_h_w(l,m,r)*Y(l,:,r+1));
        end
    end
end
H = H + delta_H;