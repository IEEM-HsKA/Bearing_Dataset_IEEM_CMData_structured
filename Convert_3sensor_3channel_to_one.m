% convert saved class structured data into 4D_

function [classdata_1D_1sensor,sclasslabal]=Convert_3sensor_3channel_to_one(classdata_1D_3sensor,sensor,class)
        LofData=size(classdata_1D_3sensor,2);
        NumofSet=size(classdata_1D_3sensor,4);
        zero4D_3dim=zeros(1,LofData,3,NumofSet);
        sensor4D=classdata_1D_3sensor(1,:,sensor,:);
        zero4D_3dim(1,:,sensor,:)=sensor4D;
        classdata_1D_1sensor=zero4D_3dim;
        clear zero4D_3dim LofData NumofSet
        NumofSet=size(classdata_1D_1sensor,4);
        sclasslabal=categorical(class*ones(NumofSet,1));
end
