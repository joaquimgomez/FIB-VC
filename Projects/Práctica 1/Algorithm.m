function res = algorithm()
    % ---------- FUNCTIONS AREA ----------

    function result = compareChiDistance(hist1, hist2)
        hist1 = imgaussfilt(hist1,2);
        hist2 = imgaussfilt(hist2,2);
        [n m] = size(hist1);
        dist = 0;
        for i=1:n
            for j=1:m
                aux = hist1(i, j) - hist2(i, j);
                if (hist1(i, j) + hist2(i, j) > 0)
                    dist = dist + (aux*aux)/(hist1(i, j) + hist2(i, j));
                end
            end
        end
        result = dist / 2;
    end

    function img = imagePreProcessingHSV(im)
        img = uint16(rgb2hsv(im) * 255);
    end

    function dist = calculateDistance(models, hist, distF)
        dist = 0.0;
        sumPond = 0.0;
        [n m] = size(models);

        for i = 1:n
            dist = dist + models{2}{i} * distF(hist, models{1}{i});
            sumPond = sumPond + models{2}{i};
        end

        dist = dist/sumPond;
    end

    function [is dist] = isTeam(models, hist, distF, threshold)
        dist = calculateDistance(models, hist, distF);
        is = dist < threshold;
    end

    function hist = histogramHSV(im, bins)
        H = im(:,:,1);
        S = im(:,:,2);
        %V = im(:,:,3);

        hist = zeros(bins, bins);
        [n m] = size(H);
        for i = 1:n
            for j = 1:m
                h = floor(H(i, j) / (256/bins)) + 1;
                s = floor(S(i, j) / (256/bins)) + 1;
                if (h > bins) 
                    h = h - 1;
                end
                if (s > bins)
                    s = s - 1;
                end
                hist(h, s) = hist(h, s) + 1;
            end
        end

        % histogram normalization
        hist = hist ./ (n*m);
    end

    % ---------- END FUNCTIONS AREA ----------
    
    
    % ---------- MAIN PROGRAM ----------

    % Model definition and parametrization
    bins = 128;

    bcnImageModelHSV1 = imagePreProcessingHSV(imread('./soccer/models/39.jpg'));
    bcnImageModelHSV2 = imagePreProcessingHSV(imread('./soccer/models/42.jpg'));
    bcnImageModelHSV3 = imagePreProcessingHSV(imread('./soccer/models/43.jpg'));

    histModelHSV1 = histogramHSV(bcnImageModelHSV1, bins);
    histModelHSV2 = histogramHSV(bcnImageModelHSV2, bins);
    histModelHSV3 = histogramHSV(bcnImageModelHSV3, bins);

    bcnModelHSV = {{histModelHSV1, histModelHSV2, histModelHSV3}, {0.2, 0.4, 0.6}};

    threshold = 0.5691;

    distF = @compareChiDistance;

    % Obtaining image to be decided
    [baseName, folder] = uigetfile('*.jpg');
    fullFileName = fullfile(folder, baseName);
    
    im = imread(fullFileName);
    prePro_im = imagePreProcessingHSV(im);
    prePro_im_h = histogramHSV(prePro_im, bins);

    % Core Algorithm Call
    [is dist] = isTeam(bcnModelHSV, prePro_im_h, distF, threshold);
    
    if (is)
        disp('This image contains Barça.');
    else
        disp('This image does not contain Barça.');
    end
    
    % ---------- END MAIN PROGRAM ----------
end

