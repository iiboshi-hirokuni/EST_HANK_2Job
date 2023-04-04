%% plot historical decomposition
   
   ystr = {'  Output' , ' Inflation' , ' Nominal Rate' };
         
   titlestr = { 'Monetary Policy Shock', ...
                'Fiscal Policy Shock' ,...
                'Productivity Shock'   }; 
            
     
   s  = 1983;
   ti =  (s+1/4):0.25:s+(nobs)/4;
   ti = ti(2:end);       
   
   nvar = 3;
   nshock = 3;
   
   
  
  figure('Name','Historical Decomposition','NumberTitle','on','FileName','Fig_decomp_y.fig') 
   
   for i = 1:nvar       
       
       histdecomp_total = zeros(1,size(ti,1));
       
     for j = 1:nshock  
        if j== 1 
           histdecomp_mp = st_save(2:end,i+(j-1)*nshock)';
        elseif j== 2 
           histdecomp_fp = st_save(2:end,i+(j-1)*nshock)';
        elseif j== 3 
           histdecomp_tfp = st_save(2:end,i+(j-1)*nshock)';  
        end     
           histdecomp_total=  histdecomp_total + st_save(2:end,i+(j-1)*nshock)'; 
     end
     
   
histdecomp_ini= YY(2:end,i)' - histdecomp_total;
histdecomp_ini_p =  (histdecomp_ini>0).*histdecomp_ini;
histdecomp_ini_n =  (histdecomp_ini<0).*histdecomp_ini;

histdecomp_mp_p =  (histdecomp_mp>0).*histdecomp_mp;
histdecomp_mp_n =  (histdecomp_mp<0).*histdecomp_mp;

histdecomp_fp_p =  (histdecomp_fp>0).*histdecomp_fp;
histdecomp_fp_n =  (histdecomp_fp<0).*histdecomp_fp;

histdecomp_tfp_p =  (histdecomp_tfp>0).*histdecomp_tfp;
histdecomp_tfp_n =  (histdecomp_tfp<0).*histdecomp_tfp;


  %% Plot Graph
  subplot(3,1,i)
  hold on
   hh = area(ti, [ histdecomp_ini_p; histdecomp_mp_p; ...
                          histdecomp_fp_p; ...
                          histdecomp_tfp_p    ]' );
  
   set(hh,'LineStyle','none') % Set all to same value
   set(hh(1),'FaceColor', [1.0 0.65 0.65])  % steady state
   set(hh(2),'FaceColor', [1.0 0.5 1.0])    % MP
   set(hh(3),'FaceColor', [0.5 0.5 1]  )    % FP
   set(hh(4),'FaceColor',[0.5 0.9 0.5])     % TFP

  
   hh1 = area(ti, [histdecomp_ini_n; histdecomp_mp_n; ...
                          histdecomp_fp_n; ...
                          histdecomp_tfp_n    ]' );
   set(hh1,'LineStyle','none') % Set all to same value
   set(hh1(1),'FaceColor', [1.0 0.65 0.65])  % steady state
   set(hh1(2),'FaceColor', [1.0 0.5 1.0])    % MP
   set(hh1(3),'FaceColor', [0.5 0.5 1])    % FP
   set(hh1(4),'FaceColor',[0.5 0.9 0.5])     % TFP
   
   l1=hh(1);
   l2=hh(2);
   l3=hh(3);
   l4=hh(4);  
   
   
     l5=plot(ti,YY(2:end,i), 'k-', 'LineWidth',2.0 );

    
     hold off  
      title(strcat(ystr(i)),'FontSize',14)
      if i ==3
         lgnd = legend([l1,l2,l3,l4,l5], {'Initial value','Monetary Policy Shock',...
                                           'Government Spending Shock', 'TFP Shock','Observed'}, 'Fontsize',10,'Orientation','horizontal','Box','off'); 
      end
         %        set(lgnd, 'Box', 'off')
%        ylim([-2 3])
      ylabel( {'[ % ]'},'FontSize',12);
      xlim([ 1983  2019  ])
   
   end   
  