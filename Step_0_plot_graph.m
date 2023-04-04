% clc
% clear all
% close all

set(0,'defaultAxesFontSize',12);
set(0,'defaultAxesFontName','century');
set(0,'defaultTextFontSize',12);
set(0,'defaultTextFontName','century');

%% load para
  load('./output/save_para_HANK_US_4800_5.mat')  
    parasim_US=para_Resamp;
    lik_stock_US = post_Resamp;
  
  load('./output/save_para_HANK_JP_4800_5.mat')  
  
    parasim_JP=para_Resamp;
    lik_stock_JP = post_Resamp;
%%    
% load('./output/r_star/save_step1_para_111_10000_1600_3.mat')
% load('./output/r_star/save_step1_para_011_10000_1600_3.mat')    
%   % print parameters with no solution
%   indet =0 % No =0
% load('./output/r_star/save_step1_para_111_10000_1600_1.mat')
%  load('./output/r_star/save_step1_para_011_10000_1600_1.mat')
  %% print parameters with no solution
%     indet =1 % yes =1
 
% set beta
% parasim(:,2)= exp(parasim(:,1).*parasim(:,4)./100)./(1 +parasim(:,21)./100);
% parasim(:,21)= (exp(parasim(:,1).*parasim(:,4)./100)./parasim(:,2)-1).*100;

%%

% parasim_det = [];
% parasim_indet = [];

% for i=1:length(lik_stock)
%   if lik_stock(i,2)== -1000000
%      parasim_indet = [parasim_indet; parasim(i,:)];
%   else
%      parasim_det = [parasim_det; parasim(i,:)];
%   end    
% end

var_plot=[1,2,3,5,6,7,12,13,14,15,16,17];

para_names_p = char('\gamma','\phi_1','\phi_0','\theta',...
                    '\theta','\phi \pi','\phi y',...
                    'labtax','gov bond target','lump transfer pc','govbcrule fixnomB',...
                    '\sigma MP','\theta MP','\sigma FP','\theta FP','\sigma TFP',...
                    '\theta TFP');  

n=6;
npara = 17;

for j =1:2
    
    figure(100000*j)
    
for i= 1:n  
    
    ii = var_plot(n*(j-1)+i);      
  
    subplot(n,n,n*(i-1)+i)
        yyaxis right
          [density,x]  = ksdensity(parasim_US(1:end,ii));     
           plot(x,density,'LineStyle','-','Color','b',...
          'LineWidth',2.5);
           y=linspace(min(density),max(density),size(x,2));
     hold on
           yyaxis right
          [density,x]  = ksdensity(parasim_JP(1:end,ii));     
           plot(x,density,'LineStyle','-','Color','r',...
          'LineWidth',2.5);
           y=linspace(min(density),max(density),size(x,2));
    hold off          
    title(para_names_p(ii,:),'FontSize',14);  
%    end
  
  for k = 2:n   
      kk = var_plot((j-1)*n+k);      
   if (k > i)&&(kk<npara+1)  
   subplot(n,n,n*(k-1)+i)
    
      scatter(parasim_US(1:end,ii),parasim_US(1:end,kk),2,'filled','b')      
   hold on
     scatter(parasim_JP(1:end,ii),parasim_JP(1:end,kk),2,'filled','r')    
   hold off
   if (k==n)&&(i==n-1)
       legend({'US','Japan'},'FontSize',12);  
   end    
      if mod(n*(k-1)+i,6)==1
         ylabel([ para_names_p(kk,:)  ],'FontSize',14); 
      end   
      if k==n
        xlabel([ para_names_p(ii,:)  ],'FontSize',14);  
      end  
   end 
    if kk ==npara
       break 
    end   
  end
    if ii ==npara
       break 
     end 
 end
 
 
end 


