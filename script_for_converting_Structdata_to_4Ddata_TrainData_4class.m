%% script for converting 1-dim data into 4D Data:
% this script  creates training input and its labels
% Author: Tanju Gofran
% Date: 06.08.2020
%% load reaquired data:
 clear all
 load('FEBearing_TrainData_4Class.mat')
 load('DEBearing_TrainData_4Class.mat')
TrainClasses=4;
learntimesec=[1 2 3];% learning all time sections of the data
segment=1000;% decided length of input 

%% 4D  traindata 4 class
traindata=[];
classlabel=[];
%Sen=[1 3];
for Fclass=0:(TrainClasses-1) 
    class=Fclass;
    SizeData4D=[];
    Label4D=[];
    for Sz=1:2 % there are 2 fault siyes
        if isfield(FEBearing_TrainData_4Class.([sprintf('Class%d',Fclass)]),([sprintf('Size%d',Sz)]))==0
        else
            B4Ddata=[];
            BLabel4D=[];

            for B=1:2 
                if B==1
                   structdata=FEBearing_TrainData_4Class.([sprintf('Class%d',Fclass)]).([sprintf('Size%d',Sz)]);
                   FEBearing_TrainData_4Class.([sprintf('Class%d',Fclass)]).([sprintf('Size%d',Sz)])=[];
                else
                   structdata=DEBearing_TrainData_4Class.([sprintf('Class%d',Fclass)]).([sprintf('Size%d',Sz)]);
                   DEBearing_TrainData_4Class.([sprintf('Class%d',Fclass)]).([sprintf('Size%d',Sz)])=[];
                end 
                [Data4D,label]=Convert_ClassStruct_1dim_3channel(structdata,class,learntimesec,segment);
                clear structdata
                sensor=1;
                [sensor4D,senlabal]=Convert_3sensor_3channel_to_one(Data4D,sensor,class);
                B4Ddata  =cat(4,B4Ddata,Data4D,sensor4D);
                BLabel4D =[BLabel4D;label;senlabal];                
                clear Data4D label %sensor4Ddata sensorLabel
                clear sensor4D senlabal
            end
         SizeData4D=cat(4,SizeData4D,B4Ddata);
         Label4D=[Label4D;BLabel4D];
         clear B4Ddata BLabel4D
        end
    end
        
    traindata=cat(4,traindata,SizeData4D);
    classlabel=[classlabel;Label4D];        
    clear class SizeData4D Label4D
end
clear FEBearing_TrainData_4Class DEBearing_TrainData_4Class
clear Fclass B learntimesec segment Sen sensor
%% Plot some inputs randomly: (Optional)
%plotRandomtraindata(traindata,classlabel,20)
