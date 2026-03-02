%% Traffic sign detection via YOLOv3
% regression based YOLO anchor box generation using Fuzzy model to
% generate anchor boxes from different size of TS classes
% % % load gtbbs;
% % % load gtbbsSTS;
gtbbs = gtbbsSTS;
stride=1;

% for x-axis
% x = gtbbs(:,1);

kk=1;
% G1 = (gtbbs(:,1) <= 32); % group small => Anchors=3
% G1 = (gtbbs(:,1) >= 33 & gtbbs(:,1) <= 96); % group medium => Anchors=5
% G1 = (gtbbs(:,1) >= 97); % group large => Anchors=1

% for both bb dimension x and y
x = [gtbbs(G1,1) gtbbs(G1,2)];

for i1 = min(x(:,1)):stride:max(x(:,1))
    key = (x(:,1)>=i1) & (x(:,1)<=i1+stride);
    bbs = x(key,:);
    if isempty(bbs) == 0
        data(kk,:) = median(bbs,1);             % mean, median, mode
        kk=kk+1;
    end    
end


% regression model for x-axis
mm1 = data(:,1);
mm2 = data(:,2);
 

linearCoefX = polyfit(mm1,mm2,1);
linearFit = polyval(linearCoefX,mm1);
figure, plot(mm1,mm2,'s', mm1,linearFit,'r-')
xlabel('mm1'); ylabel('mm2');

axis([0 140 0 140])

% regression test
input = min(x):1:max(x)
dimXY = linearCoefX(1)*input+linearCoefX(2)

nn=1
anchors = dimXY(randi(length(data),1,nn))'













