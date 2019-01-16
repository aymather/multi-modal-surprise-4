function trialseq = MMS4_sequence(settings)

% columns
id = MMS4_columns;

% make first sequence
trialseq = MMS4_makesequence(settings);

% generate criteria
novtrials = sum(trialseq(:,[id.odd_v id.odd_a id.odd_h]),2); % any novel
check3trials = sum(novtrials(1:3)); % no novels in first 3
checkconsecutive = sum(diff(find(novtrials))==1); % no consecutive novels of any type

% check criteria
while check3trials > 0 || checkconsecutive > 0
    
    % remake first sequence
    trialseq = MMS4_makesequence(settings);

    % regenerate criteria
    novtrials = sum(trialseq(:,[id.odd_v id.odd_a id.odd_h]),2); % any novel
    check3trials = sum(novtrials(1:3)); % no novels in first 3
    checkconsecutive = sum(diff(find(novtrials))==1); % no consecutive novels of any type

end


function trialseq = MMS4_makesequence(settings)

% preassign
trialseq = [];
id = MMS4_columns;

% make blocks
for ib = 1:settings.general.blocks
    
    % odd: video
    vtrials = zeros(settings.general.odd_v,id.iti);
    vtrials(1:size(vtrials,1)/2,id.dir) = 1;
    vtrials(size(vtrials,1)/2+1:end,id.dir) = 2;
    vtrials(:,id.odd_v) = 1;
    
    % odd: audio
    atrials = zeros(settings.general.odd_a,id.iti);
    atrials(1:size(atrials,1)/2,id.dir) = 1;
    atrials(size(atrials,1)/2+1:end,id.dir) = 2;
    atrials(:,id.odd_a) = 1;
    
    % odd: haptic
    htrials = zeros(settings.general.odd_h,id.iti);
    htrials(1:size(htrials,1)/2,id.dir) = 1;
    htrials(size(htrials,1)/2+1:end,id.dir) = 2;
    htrials(:,id.odd_h) = 1;
    
    % standard
    strials = zeros(settings.general.sta,id.iti);
    strials(1:size(strials,1)/2,id.dir) = 1;
    strials(size(strials,1)/2+1:end,id.dir) = 2;
    
    % merge
    btrials = [vtrials; atrials; htrials; strials];
    
    % good randomization pattern (no consecutive novels)
    novtrials = randperm(size(btrials,1));
    criter = sum(diff(sort(novtrials(1:settings.general.odd_v + settings.general.odd_a + settings.general.odd_h)))==1);
    while criter > 0
        novtrials = randperm(size(btrials,1));
        criter = sum(diff(sort(novtrials(1:settings.general.odd_v + settings.general.odd_a + settings.general.odd_h)))==1);
    end
    randnov = novtrials(1:settings.general.odd_v + settings.general.odd_a + settings.general.odd_h);
    randsta = novtrials(settings.general.odd_v + settings.general.odd_a + settings.general.odd_h+1:end);
    % put in trials
    ntrials = [vtrials; atrials; htrials]; % novel trials only
    ntrials = ntrials(randperm(size(ntrials,1)),:); % shuffle novel trial types
    btrials(randnov,:) = ntrials;
    strials = strials(randperm(size(strials,1)),:); % shuffle standard trials
    btrials(randsta,:) = strials;
    
    % add iti
    itis = repmat(settings.duration.ITIjitter',size(btrials,1)/length(settings.duration.ITIjitter),1);
    btrials(:,id.iti) = itis(randperm(length(itis)));
    
    % block info
    btrials(:,id.blo) = ib;
    
    % merge
    trialseq = [trialseq; btrials];
    
end

% trialnumbers
trialseq(:,id.num) = 1:size(trialseq,1);