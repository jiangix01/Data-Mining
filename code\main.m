%清除环境变量
close all;
clear variables;
clc;
warning off; 

%读取文件
[surgery,age,hosp_num,rectal_temp,pulse,resp_rate,...
    extre_temp,per_pulse,muc_memb,cap_ref,pain,peris,abd_dist,nas_tube,...
    nas_ref,nas_ref_ph,rec_exam,abdomen,pack_cell,total_prot,abd_apper,...
    abd_total_prot,outcome,surg_les,les_t1,les_t2,les_t3,...
    pathology] = textread('./horse.txt','%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s');

bia = cell(1,1);
%构造标称属性矩阵、数值属性矩阵和总矩阵
nominal = [surgery,age,hosp_num,extre_temp,per_pulse,muc_memb,cap_ref,...
    pain,peris,abd_dist,nas_tube,nas_ref,rec_exam,abdomen,abd_apper,...
    outcome,surg_les,les_t1,les_t2,les_t3,pathology];
numeric = [rectal_temp,pulse,resp_rate,nas_ref_ph,pack_cell,total_prot,...
    abd_total_prot];
all =[surgery,age,hosp_num,rectal_temp,pulse,resp_rate,extre_temp,...
    per_pulse,muc_memb,cap_ref,pain,peris,abd_dist,nas_tube,nas_ref,...
    nas_ref_ph,rec_exam,abdomen,pack_cell,total_prot,abd_apper,...
    abd_total_prot,outcome,surg_les,les_t1,les_t2,les_t3,pathology];

%对标称属性统计频数
fre_surgery=tabulate(nominal(:,1));
fre_age=tabulate(nominal(:,2));
fre_hosp_num=tabulate(nominal(:,3));
fre_extre_temp=tabulate(nominal(:,4));
fre_per_pulse=tabulate(nominal(:,5));
fre_muc_memb=tabulate(nominal(:,6));
fre_cap_ref=tabulate(nominal(:,7));
fre_pain=tabulate(nominal(:,8));
fre_peris=tabulate(nominal(:,9));
fre_abd_dist=tabulate(nominal(:,10));
fre_nas_tube=tabulate(nominal(:,11));
fre_nas_ref=tabulate(nominal(:,12));
fre_rec_exam=tabulate(nominal(:,13));
fre_abdomen=tabulate(nominal(:,14));
fre_abd_apper=tabulate(nominal(:,15));
fre_outcome=tabulate(nominal(:,16));
fre_surg_les=tabulate(nominal(:,17));
fre_les_t1=tabulate(nominal(:,18));
fre_les_t2=tabulate(nominal(:,19));
fre_les_t3=tabulate(nominal(:,20));
fre_pathology=tabulate(nominal(:,21));

info{1,1}='info';
info{2,1}='rectal_temp';
info{3,1}='pulse';
info{4,1}='resp_rate';
info{5,1}='nas_ref_ph';
info{6,1}='pack_cell';
info{7,1}='total_prot';
info{8,1}='abd_total_prot';
info{1,2}='min';
info{1,3}='q1';
info{1,4}='median';
info{1,5}='mean';
info{1,6}='q3';
info{1,7}='max';
info{1,8}='NA';
% 
%给出最大、最小、均值、中位数、四分位数及缺失值的个数。
for attr=1:7
    current_attr=numeric(:,attr);
    s= find(strcmp(current_attr,'?'));
    miss=length(s);
    value=str2double(current_attr);
    value=value(~isnan(value));
    % 统计最大值、最小值、均值、中位数、四分位数
    maxvalue=max(value);
    minvalue=min(value);
    meanvalue = mean(value);
    medianvalue=median(value);
    q1value=prctile(value,25);
    q3value=prctile(value,75);
    info{attr+1,2}=minvalue;
    info{attr+1,3}=q1value;
    info{attr+1,4}=medianvalue;
    info{attr+1,5}=meanvalue;
    info{attr+1,6}=q3value;
    info{attr+1,7}=maxvalue;
    info{attr+1,8}=miss;
    % 绘制直方图
    fig=figure();
    hist(value);   
    xlabel(info{attr+1,1});
    ylabel('Value');
    saveas(fig,['./figure/hist_',info{attr+1,1},'.jpg']);
    % 绘制qq图
    fig= figure();
    qqplot(value);
    xlabel(info{attr+1,1});
    ylabel('Value');
    saveas(fig,['./figure/qq_',info{attr+1,1},'.jpg']);
    % 绘制盒图
    fig= figure();
    boxplot(value); 
    % hold;
    yyy=line([-1000,1000],[meanvalue,meanvalue]);
    set(yyy,'linestyle',':')
    ylabel(info{attr+1,1});
    saveas(fig,['./figure/box_',info{attr+1,1},'.jpg']);
end


% %    将缺失部分剔除
sho = zeros(1,28);
[i,j]= find(strcmp(all, '?'));
A=[i,j];
d=[i];
tab = tabulate(A(:,2));
n=length(tab);
tab= int8(tab(:,1:2));
for i = 1:n
    sho(1,tab(i,1))= tab(i,2);
end
% 将缺失部分剔除
all_miss =all;  %原始数据集
data_miss=all(d,:);  %存在缺失数据的数据集
all_miss(d,:)=[];   %已删除缺失数据后的数据集

%    用最高频率值来填补缺失值
% [ii,j]= find(strcmp(all, '?'));
% dim=numel(all)/length(all);
% freout=cell(dim,1);
% for ic = 1:dim%列数
%     for ir = 1:length(all)%行数
%         temp(ir) = length(find(strcmp(all(:,ic),all(ir,ic))));
%     end
%     [~, id] = max(temp,[],1);
%     freout(ic) = all(id(1,1),ic);
% end
% all2 = all;

% 用最高频数值来填补缺失值
all_fre=all;
dim=numel(all)/length(all);
for ic = 1:28
    col=all(:,ic);
    [xx,yy]=find(strcmp(col,'?'));
    col_value=[xx];
    %col_value=col_value(~isnan(col_value));
    col(col_value,:)=[];
    col_table=tabulate(col);
    col_table_double=str2double(col_table(:,2));
    [maxCount,idx] = max(col_table_double);
    for ir=1:length(all_fre)
        if (strcmp(all(ir,ic),'?'))
            all_fre(ir,ic)=col_table(idx);
        end
    end
end
% for ir = 1:length(A)
%     position =A(ir,:);
%     all2{position(1),position(2)}=freout(position(2),1);    %用最高频率值填补缺失值后的数据集
% end


%    通过属性的相关关系来填补缺失值
% for ir=1:length(all1)
%     for ic=1:15
%         shu1(ir,ic)=str2num(all1{ir,ic+3});
%     end
% end
shu1=str2double(all_miss(:,[4 5 6 16 19 20 22]));
relationship=corrcoef(shu1);
[~,index]=sort(relationship,2);
index2= index;

for ir = 1:7
    for ic=1:7
        c1=shu1(:,ir);
        c2=shu1(:,index2(ir,ic));
        c2=[ones(length(c2),1),c2];
        [b,~,~,~,~]=regress(c1,c2);
        pra{ir,ic}=b;
    end
end

all_3=all;
dim=numel(all)/length(all);
for ic = 22:28
    col=all(:,ic);
    [xx,yy]=find(strcmp(col,'?'));
    col_value=[xx];
    col(col_value,:)=[];
    for ir=1:length(all_3)
        if (strcmp(all(ir,ic),'?'))
            for iii = 6:-1:1
                if ~((strcmp(all_3{ir,21+index2(ic-21,iii)},'?'))|(isnan(all_3{ir,21+index2(ic-21,iii)})))
                    aaaa = pra{ic-21,index2(ic-21,iii)}(1,1);
                    bbbb = pra{ic-21,index2(ic-21,iii)}(2,1);                   
                    cccc = all_3{ir,21+index2(ic-21,iii)};
                    if ischar(cccc)
                        cccc = str2double(cccc);
                    end
                   all_3(ir,ic) = num2cell( aaaa + bbbb*cccc);
                    break;
                
                end
            end
            
                
        end
    end
end
all_linear=all_3;

 [p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22,p23,p24,p25,p26,p27,p28] = textread('./1.txt','%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s');
 all_object=[p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22,p23,p24,p25,p26,p27,p28];
 save('./OmitedData.mat','all_miss');
 save('./FreData.mat','all_fre');
 save('./LinearData.mat','all_linear');
 save('./ObjectData.mat','all_object');
% 
% 
  dealD(all_miss,'将缺失部分剔除');
  dealD(all_fre,'用最高频率值来填补缺失值');
  dealD(all_linear,'通过属性的相关关系来填补缺失值');
  dealD(all_object,'通过数据对象之间的相似性来填补缺失值');

