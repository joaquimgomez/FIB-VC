function digit = predictDigit(img)
    % ---------- FUNCTIONS AREA ----------
    
    function features = featuresVector(img)
        img = imresize(img, [40, 40]);      %????
        img = im2bw(img, graythresh(img));

        features = [];

        % Concavities
        cf = concavitiesFeatures(img);
        features = [features cf];

        % Holes
        hf = holesFeatures(img);
        features = [features hf];

        % Convex Hull
        chf = convexHullFeatures(img);
        features = [features chf];
    end

    function cf = concavitiesFeatures(img)
        imgWithoutHoles = imfill(img, 'holes');

        ch = bwconvhull(imgWithoutHoles, 'objects');

        concavities = ch-imgWithoutHoles;

        [eti num] = bwlabel(concavities,4);

        Dades = regionprops(eti,'all');

        N = 5;
        if size(Dades, 1) > 1
            T = struct2table(Dades);
            sortedT = sortrows(T, 'Area', "descend");
            Dades = table2struct(sortedT);
            Dades = Dades(1:min(size(Dades, 1), N));
        end

        centroidsX = zeros(1, N);
        centroidsY = zeros(1, N);
        area = zeros(1, N);
        majorAxisLength = zeros(1, N);
        minorAxisLength = zeros(1, N);

        for i=1:size(Dades, 1)
            dada = Dades(i);
            centroidsX(1, i) = dada.Centroid(1);
            centroidsY(1, i) = dada.Centroid(2);
            area(1, i) = dada.Area;
            majorAxisLength(1, i) = dada.MajorAxisLength;
            minorAxisLength(1, i) = dada.MinorAxisLength;
        end

        cf = [centroidsX centroidsY area majorAxisLength minorAxisLength];
    end

    function hf = holesFeatures(img)
        imgWithoutHoles = imfill(img, 'holes');

        holes = imgWithoutHoles-img;

        [eti, num] = bwlabel(holes,4);

        Dades = regionprops(eti,'all');

        N = 2;
        if size(Dades, 1) > 1
            T = struct2table(Dades);
            sortedT = sortrows(T, 'Area', "descend");
            Dades = table2struct(sortedT);
            Dades = Dades(1:min(size(Dades, 1), N));
        end

        centroidsX = zeros(1, N);
        centroidsY = zeros(1, N);
        area = zeros(1, N);
        majorAxisLength = zeros(1, N);
        minorAxisLength = zeros(1, N);

        for i=1:size(Dades, 1)
            dada = Dades(i);
            centroidsX(1, i) = dada.Centroid(1);
            centroidsY(1, i) = dada.Centroid(2);
            area(1, i) = dada.Area;
            majorAxisLength(1, i) = dada.MajorAxisLength;
            minorAxisLength(1, i) = dada.MinorAxisLength;
        end

        hf = [centroidsX centroidsY area majorAxisLength minorAxisLength];
    end

    function chf = convexHullFeatures(img)
        ch = bwconvhull(img, 'objects');

        [eti num] = bwlabel(ch,4);

        dada = regionprops(eti,'all');

        % si s'extrau més d'un objecte que agafi el més gran
        % ja que serà aquell que representi la convex hull
        if size(dada, 1) > 1
            T = struct2table(dada);
            sortedT = sortrows(T, 'Area', "descend");
            dada = table2struct(sortedT);
            dada = dada(1);
        end

        centroidsX = dada.Centroid(1);
        centroidsY = dada.Centroid(2);
        area = dada.Area;
        majorAxisLength = dada.MajorAxisLength;
        minorAxisLength = dada.MinorAxisLength;

        chf = [centroidsX centroidsY area majorAxisLength minorAxisLength];
    end
    
    % ---------- END FUNCTIONS AREA ----------
    
    
    % ---------- MAIN PROGRAM ----------
    l = load("quadraticSVM.mat");
    
    % Compute features vector
    fv = featuresVector(img);
    
    % Prediction
    digit = l.quadraticSVM.predictFcn(array2table(fv));
    
    % ---------- END MAIN PROGRAM ----------
end