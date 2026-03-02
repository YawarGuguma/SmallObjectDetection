%% sort and scale
% anchor box number determination in sort and scale in each TS group

% % % load gtbbs;       % for loading GTSD annotations
% % % load gtbbsSTS;    % for loading STS annotations

gtbbs = gtbbsSTS;

% G1 = (gtbbs(:,1) <= 32); % group small => Anchors=3
% G1 = (gtbbs(:,1) >= 33 & gtbbs(:,1) <= 96); % group medium => Anchors=5
% G1 = (gtbbs(:,1) >= 97); % group large => Anchors=1

% this part of the code will analyse the size variations of the traffic
% signs in each class by calculating the variance of gt in X and Y
% direction
G1xy = [gtbbs(G1,1) gtbbs(G1,2)];
% converting all classes into a constant class size, we are doing this to
% compensate the size variance noise caused by differences in pixel size
% within each class
mm = 25 / mean(G1xy(:));
G1xy = round([gtbbs(G1,1) gtbbs(G1,2)]*mm);
% total nos of bbs
nobbs = size(G1xy,1);
% std in Y-axis of gtbbs
stdY = std(G1xy,0,1)
% harmonic mean of std in Y-axis of gtbbs
hMeanY = (2*stdY(1)*stdY(2)) / sum(stdY)


% std values for the Fuzzy System (GTSD dataset)
% ===========================================
% group small actual values ; no of gtbbs = 262
stdY = 4.3060; gtbbs = 262;

% group medium actual values ; no of gtbbs = 383
stdY = 7.5915; gtbbs = 383;

% group large actual values ; no of gtbbs = 21
stdY = 2.0601; gtbbs = 21;
% ===========================================

% std values for the Fuzzy System (STS dataset)
% ===========================================
% group small actual values ; no of gtbbs = 336
stdY = 4.5621; gtbbs = 336; % ==> 3 anchors

% group medium actual values ; no of gtbbs = 587
stdY = 7.6194; gtbbs = 587; % ==> 5 anchors

% group large actual values ; no of gtbbs = 52
stdY = 5.6180; gtbbs = 52; % ==> 1 anchors
% ===========================================

% % % load fuzzyAnchors03GTSD.mat;
% % % load fuzzyAnchors03STS.mat;

% anchors = evalfis([bbs stdY],fs);
anchors = ceil(evalfis([336 4.5621],fuzzyAnchors03))







% % % % =============================================================
% % % % anchor box number determination in sort and scale in each TS group
% % % 
% % % load gtbbs;
% % % 
% % % % G1 = (gtbbs(:,1) <= 32); % group small
% % % % G1 = (gtbbs(:,1) >= 33 & gtbbs(:,1) <= 96); % group medium
% % % G1 = (gtbbs(:,1) >= 97); % group large
% % % 
% % % % this part of the code will analyse the size variations of the traffic
% % % % signs in each class by calculating the variance of gt in X and Y
% % % % direction
% % % G1xy = [gtbbs(G1,1) gtbbs(G1,2)];
% % % nobbs = size(G1xy,1);
% % % % std in Y-axis of gtbbs
% % % stdY = std(G1xy,0,1)
% % % % harmonic mean of std in Y-axis of gtbbs
% % % hMeanY = (2*stdY(1)*stdY(2)) / sum(stdY)
% % % % std in X-axis of gtbbs
% % % stdX = mean(std(G1xy,0,2))
% % % 
% % % % std normalized values for the Fuzzy System
% % % % ===========================================
% % % % group small actual values ; no of gtbbs = 262; normalized=0.6841
% % % stdY = 4.3060; stdX = 0.6234;
% % % % group small NORMALIZED values
% % % stdY = 0.2851; stdX = 0.1371;
% % % % harmonic mean 2ab/a+b of stdX and stdY
% % % 0.1852;
% % % 
% % % % group medium actual values ; no of gtbbs = 383; normalized=1
% % % stdY = 15.1061; stdX = 1.6358;
% % % % group medium NORMALIZED values
% % % stdY = 1; stdX = 0.3599;
% % % % harmonic mean 2ab/a+b of stdX and stdY
% % % 0.5293;
% % % 
% % % % group large actual values ; no of gtbbs = 21; normalized=0.0548
% % % stdY = 8.5497; stdX = 4.5457;
% % % % group large NORMALIZED values
% % % stdY = 0.5660; stdX = 1;
% % % % harmonic mean 2ab/a+b of stdX and stdY
% % % 0.7229;
% % % % ===========================================
% % % 
% % % % anchors = evalfis([bbs stdX stdY],fs)
% % % % may be combine stdX and stdY using harmonic mean in the fuzzy system
% % % anchors = evalfis([0.0548 1 0.5660],fuzzyAnchors01)
% % % 
% % % 
% % % 
% % % 
% % % 
% % % 
% % % 
% % % % =============================================================







% % % Fuzzy Inference System
% % % 
% % % fs = mamfis;
% % % 
% % % adding inputs
% % % fs = addInput(fs,[0 1],'Name','bbs');
% % % fs = addInput(fs,[0 1],'Name','stdX');
% % % fs = addInput(fs,[0 1],'Name','stdY');
% % % 
% % % 
% % % adding output
% % % fs = addOutput(fs,[0 9],'Name','anchors');           %[100 200]
% % % 
% % % adding membership functions to INPUT "score"
% % % fs = addMF(fs,"score",@trimf,[-0.25 0 0.25], ...
% % %     "Name","veryLow","VariableType","input");
% % % fs = addMF(fs,"score",@trimf,[0 0.25 0.5], ...
% % %     "Name","low","VariableType","input");
% % % fs = addMF(fs,"score",@trimf,[0.25 0.5 0.75], ...
% % %     "Name","medium","VariableType","input");
% % % fs = addMF(fs,"score",@trimf,[0.5 0.75 1], ...
% % %     "Name","high","VariableType","input");
% % % fs = addMF(fs,"score",@trimf,[0.75 1 1.25], ...
% % %     "Name","veryHigh","VariableType","input");
% % % 
% % % adding membership functions to INPUT "weightFunction"
% % % fs = addMF(fs,"weightFunction",@trimf,[-0.25 0 0.25], ...
% % %     "Name","veryLow","VariableType","input");
% % % fs = addMF(fs,"weightFunction",@trimf,[0 0.25 0.5], ...
% % %     "Name","low","VariableType","input");
% % % fs = addMF(fs,"weightFunction",@trimf,[0.25 0.5 0.75], ...
% % %     "Name","medium","VariableType","input");
% % % fs = addMF(fs,"weightFunction",@trimf,[0.5 0.75 1], ...
% % %     "Name","high","VariableType","input");
% % % fs = addMF(fs,"weightFunction",@trimf,[0.75 1 1.25], ...
% % %     "Name","veryHigh","VariableType","input");
% % %  
% % % adding membership functions to OUTPUT "stride"
% % % fs = addMF(fs,"stride",@trimf,[60 70 80], ...             %[80 100 120]
% % %     "Name","verySlow","VariableType","output");
% % % fs = addMF(fs,"stride",@trimf,[70 80 90], ...            %[100 120 140]
% % %     "Name","slow","VariableType","output");
% % % fs = addMF(fs,"stride",@trimf,[80 90 100], ...            %[120 140 160]
% % %     "Name","medium","VariableType","output");
% % % fs = addMF(fs,"stride",@trimf,[90 100 110], ...            %[140 160 180]
% % %     "Name","fast","VariableType","output");
% % % fs = addMF(fs,"stride",@trimf,[100 110 120], ...            %[160 180 200]
% % %     "Name","veryFast","VariableType","output");
% % % fs = addMF(fs,"stride",@trimf,[110 120 130], ...            %[180 200 220]
% % %     "Name","fastest","VariableType","output");
% % % 
% % % adding rules
% % % fs = addRule(fs,...
% % %     ["if score is veryLow and weightFunction is veryLow then stride is fastest (1)" ...
% % %     "if score is veryLow and weightFunction is low then stride is veryFast (1)" ...
% % %     "if score is veryLow and weightFunction is medium then stride is slow (1)" ...
% % %     "if score is veryLow and weightFunction is high then stride is verySlow (1)" ...
% % %     "if score is veryLow and weightFunction is veryHigh then stride is verySlow (1)" ...
% % %     
% % %     "if score is low and weightFunction is veryLow then stride is fast (1)" ...
% % %     "if score is low and weightFunction is low then stride is medium (1)" ...
% % %     "if score is low and weightFunction is medium then stride is slow (1)" ...
% % %     "if score is low and weightFunction is high then stride is verySlow (1)" ...
% % %     "if score is low and weightFunction is veryHigh then stride is verySlow (1)" ...
% % %     
% % %     "if score is medium and weightFunction is veryLow then stride is medium (1)" ...
% % %     "if score is medium and weightFunction is low then stride is medium (1)" ...
% % %     "if score is medium and weightFunction is medium then stride is verySlow (1)" ...
% % %     "if score is medium and weightFunction is high then stride is verySlow (1)" ...
% % %     "if score is medium and weightFunction is veryHigh then stride is verySlow (1)" ...
% % %     
% % %     "if score is high and weightFunction is veryLow then stride is fast (1)" ...
% % %     "if score is high and weightFunction is low then stride is fast (1)" ...
% % %     "if score is high and weightFunction is medium then stride is verySlow (1)" ...
% % %     "if score is high and weightFunction is high then stride is verySlow (1)" ...
% % %     "if score is high and weightFunction is veryHigh then stride is verySlow (1)" ...
% % %     
% % %     
% % %     "if score is veryHigh and weightFunction is veryLow then stride is fast (1)" ...
% % %     "if score is veryHigh and weightFunction is low then stride is fast (1)" ...
% % %     "if score is veryHigh and weightFunction is medium then stride is verySlow (1)" ...
% % %     "if score is veryHigh and weightFunction is high then stride is verySlow (1)" ...
% % %     "if score is veryHigh and weightFunction is veryHigh then stride is verySlow (1)" ...
% % %     ]);
% % % 
% % % checking fuzzy system
% % % load fs3;
% % % stride = evalfis([0.1 0.001],fs)
% % % 





















