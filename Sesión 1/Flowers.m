%-- 12/02/2020 15:01 --%

%% Visión por Computador - Sesión 1

% Ferran Velasco Olivera
% Joaquín Gómez Sánchez

%% Flowers

im = imread('flowers.tif');
imshow(im)
impixelinfo
r = im(:,:,1);
g = im(:,:,2);
b = im(:,:,3);
figure
subplot(2,2,1);imshow(im)
subplot(2,2,1);imshow(r)
subplot(2,2,1);imshow(im)

%% Componentes RGB

subplot(2,2,2);imshow(r);title('component R')
subplot(2,2,3);imshow(g);title('component G')
subplot(2,2,4);imshow(b);title('component B')
gris = rgb2gray(im);
figure, imshow(gris)

%% Normalización de la iluminación

I = double(r) + double(g) + double(b);
Rn = double(r) / I;
Gn = double(g) / I;
Bn = double(b) / I;
RGBn = cat(3, Rn, Gn, Bn);
figure, imshow(RGBn)
Rn = double(r) ./ I;
Gn = double(g) ./ I;
Bn = double(b) ./ I;
RGBn = cat(3, Rn, Gn, Bn);
figure, imshow(RGBn)

%% HSV

HSV = rgb2hsv(im);
h = HSV(:,:,1);
s = HSV(:,:,2);
v = HSV(:,:,3);
figure, imshow(h); title('hue')
figure, imshow(s); title('saturation')