function detFreqs = ThreshDetector(sig, freqVec, thresh)

    detInds = sig >= thresh;
    % detInds will look something like [0 0 0 1 1 1 1 0 0 0 0 0 1 1 1 1 1 1 0 0...]
    % We want to find the maximum power of the signal where there were detections, and this will give
    % us the frequencies
    diffInds = [0 diff(detInds)];
    start = (find(diffInds == 1))';
    ends = (find(diffInds == -1))';
    bounds = [start, (ends-1)]; % The boundry indeces of each detection
    % bounds looks like [startInd, endInd; startInd, endInd; ...]
    
    detFreqs = zeros(1,size(bounds,1));
    for det = 1:size(bounds,1) % each row is a new detection
        [~,maxInd] = max(sig(bounds(det,1):bounds(det,2)));
        detFreqs(det) = freqVec(bounds(det,1) + maxInd - 1);
    end

end