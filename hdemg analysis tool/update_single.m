function y = update_single(Data,channel)

columntotal=size(Data,2);
if columntotal==65
   Data=Data(:,2:65);
end

plot(Data(:,channel))
title(['raw EMG from channel ' num2str(channel) ' [mV]'])
xlabel('sample')
ylabel('EMG [mV]')
y=Data;

end



