clc
close all
clear all

  addpath(genpath('./AutoDiff'));
  addpath(genpath('./function_phact'));
  addpath(genpath('./function_3'));
  
% Turn off the warning message from auto diff
% You should read the warning once, but turn it off after reading it.
   warning('off','AutoDiff:maxmin')
   addpath(genpath('./function_kalman'));

   load_data;
   dataplot;
   
  I          = 100;
  J          = 2;
  n_v = I*J + 1;    % number of jump variables (value function + inflation)
  n_g = I*J + 2 ;   % number of endogeneous state variables (distribution + monetary + Fiscal policy)
  n_p = 6;          % number of static relations: bond-market clearing, labor market clearing, consumption, output, total assets
  n_shocks = 3;     % only monetary policy shock is considered
  nEErrors = n_v;
  nVars = n_v + n_g + n_p;
  
  [G1, impact,inv_state_red,from_spline] = solve_HANK(I,J,n_v,n_g,n_p,n_shocks);
   
   T = 40;
   N = 40;
   dt = T/N;
    vAggregateShock	= zeros(1,N);
    trans_mat = inv_state_red*from_spline;
    
   ZZ0 = zeros(3,size(trans_mat,1));
   ZZ0(2,n_v+n_g+4) = 100; %output
   ZZ0(1,n_v) = 100; %inflation
   ZZ0(3,n_v+n_g+6) = 400; %interest rate
   
   ZZ1 = zeros(3,size(trans_mat,1));
%    ZZ1(2,n_v+n_g+4) = 100; %output
   
   ZZ = [ZZ0*trans_mat -ZZ1*trans_mat] ;
%    ZZ = [ZZ0*trans_mat] ;
   m = 2;
   
   [rloglh,obsmean] = eval_HANK(G1,impact,T,N,vAggregateShock,'implicit',trans_mat,[n_v,n_v+n_g-2:n_v+n_g+6],YY, ZZ,m);
   
   disp('log lik is ')
   disp(rloglh)
      
   figure(200)
   plot( (ZZ*obsmean')')
   legend({'pi','y','r'},'FontSize',12)
   
   