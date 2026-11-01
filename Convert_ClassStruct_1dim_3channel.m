% convert saved class structured data into 4D_

function [classdata_1D_3channel,Classlabal]=Convert_ClassStruct_1dim_3channel(structdata,class,learntimesec,segment)
         speeddata4D=[];
         for Speed=1:4
             speeddata=structdata.([sprintf('Speed%d',Speed)]);
             loaddata4D=[];
             for MLoad=0:4
                 loaddata=speeddata.([sprintf('Load%d',MLoad)]);
                 t4D3dim=[];
                 for t=1:length(learntimesec)
                     timesec=learntimesec(t);
                     timesecdata=loaddata.([sprintf('TimeSection%d',timesec)]);
                     mainsensor=timesecdata.Mainsensor;
                     oppsensor=timesecdata.Oppsensor;
                     basesensor=timesecdata.Basesensor;
                     L=length(mainsensor);
                     RemL=rem(L,segment);
                     set=(L-RemL)/segment;
                     Mdata4D_1dim=reshape(mainsensor(1:end-RemL),[1,segment,1,set]);
                     Odata4D_1dim=reshape(oppsensor(1:end-RemL),[1,segment,1,set]);
                     Bdata4D_1dim=reshape(basesensor(1:end-RemL),[1,segment,1,set]);
                     t4D3dim=cat(4,t4D3dim,convert4D_3dim(Mdata4D_1dim,Odata4D_1dim,Bdata4D_1dim));
                     clear timesecdata mainsensor oppsensor basesensor L RemL set
                     clear Mdata4D_1dim Odata4D_1dim Bdata4D_1dim
                 end
                 loaddata4D=cat(4,loaddata4D,t4D3dim);
                 clear t4D3dim loaddata
             end
             speeddata4D=cat(4,speeddata4D,loaddata4D);
             clear loaddata4D speeddata
         end
         classdata_1D_3channel=speeddata4D;
         clear speeddata4D
         Tset=size( classdata_1D_3channel,4);
         Classlabal=categorical(class*ones(Tset,1));
         clear Tset 
end
