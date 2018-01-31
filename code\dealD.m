function dealD(matrix,str)

name{1}=strcat(str,'rectal_temp');
name{2}=strcat(str,'pulse');
name{3}=strcat(str,'resp_rate');
name{4}=strcat(str,'nas_ref_ph');
name{5}=strcat(str,'pack_cell');
name{6}=strcat(str,'total_prot');
name{7}=strcat(str,'abd_total_prot');

matrix=matrix(:,[4 5 6 16 19 20 22]);

% for i=1:length(matrix) 
%     for j=4:18
%         sh(i,j-3) = str2double(matrix{i,j});
%     end
% end

for line=1:7
  current_line=matrix(:,line);
  current_line=str2double(current_line);
  % 绘制直方图
  fig=figure();
  hist(current_line);   
  xlabel(name{line});
  ylabel('Value');
  saveas(fig,['D:/figure/hist/hist_',name{line},'.jpg']);
  % 绘制qq图,检验是否为正态分布
  fig= figure();
  qqplot(current_line);
  xlabel(name{line});
  ylabel('Value');
  saveas(fig,['D:/figure/qq/qq_',name{line},'.jpg']);
  % 绘制盒图
  fig= figure();
  boxplot(current_line);
%   meanvalue=mean(current_line);
%   yyy=line([-1000,1000],[meanvalue,meanvalue]);
%   set(yyy,'linestyle',':')
  ylabel(name{line})
  saveas(fig,['D:/figure/box/box_',name{line},'.jpg']);
end    
    
end