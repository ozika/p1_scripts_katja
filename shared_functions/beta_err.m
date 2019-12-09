function [err] = beta_err(p, data)


    input = p;
    p =[];
    p.alpha = input(1);
    p.beta = input(2);
    beta_vals = betapdf(0:0.001:1, p.alpha, p.beta);
    
    %normalize (unnecessary)
    data = data./sum(data);
    beta_vals = beta_vals./sum(beta_vals);
    
    err = sum((data - beta_vals).^2);
    if isnan(err)
        err = 9999;
    end
   



end

