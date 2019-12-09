function [al, be, mu, sigma] = fit_beta_dist(data)
    [X,X0,lb,ub, err] = deal([]);
    nfits = 2;
    lb =[0,0];
    ub  = [10, 10];
    for i = 1:numel(ub)
        X0(i) = lb(i)+rand*(ub(i)-lb(i));
    end
    for i =1:nfits
        [X(i,1:length(X0)), err(i)] = bads(@beta_err, X0, lb, ub, [], [], [], [], data);
    end
    id=find(err==min(err));
    al = X(id(1),1);
    be = X(id(1), 2);
    [al, be, mu, sigma] = beta_ab2ms(al, be);
end

