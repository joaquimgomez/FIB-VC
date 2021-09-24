%% primera sessió

% Ferran Velasco Olivera
% Joaquin Gomez Sanchez

%-- 12/02/2020 15:01 --%
diary C:\Users\joaquin.gomez\Documents\MATLAB
diary C:\Users\joaquin.gomez\Documents\MATLAB\diary.txt
clc
im = imread('Gull.tif');
clc
im = imread('Gull.tif');
pwd
im = imread('Gull.tif');
[files cols] = size(im)
im(47,123)
im(20:25,53:56)
imshow(im)
impixelinfo
imshow(im)
impixelinfo
imshow(im)
impixelinfo
help colormap
colormap hot
colormapjet
colormap jet
colormap colorcube

%% imatge Floppy

im2 = imread('Floppy.bmp');
imshow(im2)
figure, imshow(im2)
colormap colorcube
improfile
figure, imshow(im2)
improfile
figure, improfile
figure, imshow(im2)
figure, improfile
improfile
subplot(1,2,1);imshow(im)
subplot(1,2,2);imshow(im2)
title('prova de subplot')
improfile
im2 = rand(256)*1000;
figure, imshow(im2)
im3 = rand(256);
figure, imshow(im3)
imshow(im2, [0 1000]
imshow(im2, [0 1000])
workspace
figure, imshow(im2, [])
imwrite(im2,'resultat.png');
imwrite(im2,'C:\resultat.png');
imwrite(im2,'C:\Users\joaquin.gomez\resultat.png');
commandhistory