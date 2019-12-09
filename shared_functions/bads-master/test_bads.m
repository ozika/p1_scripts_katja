%[x,fval,exitflag,output] = bads(noisyfun,x0,lb,ub,plb,pub,[],options);
outcomes         = [0    0   0   0   0   1   0   0   1   0   1];
probabilities    = [0.7  0.6 0.5 0.4 0.3 0.5 0.4 0.3 0.3 0.2 0.15];
X0 = [0.5, 0.5, 0.5];
lb = [0 0 0];
ub = [1 5 5];
cfg = [];
[X, fval] = bads(@PD_3_std_err, X0, lb, ub, [], [], [], [], outcomes, probabilities, cfg);