%% Code generated : 11:22 AM, 6/18/2018
%% By: Kapil Duwadi, kapil.duwadi@jacks.sdstate.edu


%% Reads data
load input_data;
load LDAPC1042;

voltage_1042 = voltage;
power_1042 = power;

load LDAPC10458;
power_10458 = power;
voltage_10458 = voltage;

load LDAPC1050;
power_1050 = power;
voltage_1050 = voltage;

power_curtailed_1042 = PMPPT(1:end-1) - (loaddata(1:end-1,:)-power_1042(2:end,:));
House_wise_curtail_1042 = sum(power_curtailed_1042);
total_curtail_1042 = sum(House_wise_curtail_1042)/(60*1000);

power_curtailed_10458 = PMPPT(1:end-1) - (loaddata(1:end-1,:)-power_10458(2:end,:));
House_wise_curtail_10458 = sum(power_curtailed_10458);
total_curtail_10458 = sum(House_wise_curtail_10458)/(60*1000);

power_curtailed_1050 = PMPPT(1:end-1) - (loaddata(1:end-1,:)-power_1050(2:end,:));
House_wise_curtail_1050 = sum(power_curtailed_1050);
total_curtail_1050 = sum(House_wise_curtail_1050)/(60*1000);


%% Plots total energy curtailment 
TEC = [total_curtail_1042 total_curtail_10458 total_curtail_1050 111 78.2];
figure('color',[1,1,1]);
set(gcf,'Position',[680,558,900,420]);
 for i =1:5
    if i==1, hold on; end
    bar(i,TEC(i));
 end
text(1:length(TEC),TEC,num2str(TEC'),'vert','bottom','horiz','center');
ylim([0,160]);
xticks(1:5);
xticklabels({'LDAPC-1.042','LDAPC-1.0458','LDAPC-1.05','QDAPC','UPF'});
ylabel('Total energy curtailment (kWh)');
grid on;
box on;
xlim([0.5,5.5]);
print(gcf,'Images\sweeping_critical_voltage','-dpng','-r600');


%% Plots house wise curtailment
house_wise_curtail = [House_wise_curtail_1042;House_wise_curtail_10458;House_wise_curtail_1050];
house_wise_curtail(house_wise_curtail<0) = 0;
figure('color',[1,1,1]);
set(gcf,'Position',[680,558,600,420]);
bar(house_wise_curtail/(60*1000));
ylabel('Total energy curtailment (kWh)');
xticks(1:3);
xticklabels({'1.042','1.0458','1.05'});
ylim([0,35]);
grid on;
box on;
a = legend('H1','H2','H3','H4','H5','H6','H7','H8','H9','H10','H11','H12');
set(a,'NumColumns',3)
print(gcf,'Images\housewisecurtail_sweepedvcri','-dpng','-r600');

%% Plots power curtailment profile
figure('color',[1,1,1]);
set(gcf,'Position',[680,558,600,420]);
plot(1:1439,power_curtailed_1042);
hold
plot(1440:1439*2,power_curtailed_10458);
plot(2879:1439*3,power_curtailed_1050);
grid on;
box on;
xlim([0,4000]);
xticks([660, 2100, 3600]);
xticklabels({'1.042','1.0458','1.05'});
ylim([0,6000]);
ylabel('Power curtailment (kW)');
a = legend('H1','H2','H3','H4','H5','H6','H7','H8','H9','H10','H11','H12');
set(a,'NumColumns',3)
print(gcf,'Images\powercuratil_profile','-dpng','-r600');

%% Plots voltage profile

volt = [voltage_1042(:),voltage_10458(:) ,voltage_1050(:)]/240;
figure('color',[1,1,1]);
plot(voltage_1042/240)
x1 = 1.042*ones(1,1440);
x2 = 1.058*ones(1,1440);
hold
yticks([0.98:0.01:1.03, 1.042, 1.05, 1.058]);
plot(x1,'--r')
plot(x2,'--r')
xlim([0,1440]);
xlabel('Time (minute)');
ylabel('Voltage (p.u.)');
print(gcf,'Images\voltage1042','-dpng','-r600');
figure('color',[1,1,1]);
plot(voltage_10458/240)
x1 = 1.0458*ones(1,1440);
x2 = 1.058*ones(1,1440);
hold
yticks([0.98:0.01:1.03, 1.0458, 1.05, 1.058]);
plot(x1,'--r')
plot(x2,'--r')
xlim([0,1440]);
xlabel('Time (minute)');
ylabel('Voltage (p.u.)');
print(gcf,'Images\voltage10458','-dpng','-r600');
figure('color',[1,1,1]);
plot(voltage_1050/240)
x1 = 1.050*ones(1,1440);
x2 = 1.058*ones(1,1440);
hold
yticks([0.98:0.01:1.03, 1.04, 1.05, 1.058]);
plot(x1,'--r')
plot(x2,'--r')
xlim([0,1440]);
xlabel('Time (minute)');
ylabel('Voltage (p.u.)');
print(gcf,'Images\voltage1050','-dpng','-r600');