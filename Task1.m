script 
% base realization

% clear all
clc, clear;

% ¬и€вленн€ ColorChecker на зображен≥
% Load picture
picture = imread('picture.jpg');

% Show picture
% imshow(picture);
% image(picture);

% Size
% heigth - висота
% width - ширина
% chanels - к≥льк≥сть канал≥в (3 - RGB)
[height, width, chanels] = size(picture);

% coordinate of patches
% https://en.wikipedia.org/wiki/ColorChecker
% for identify coordinate, I used my own program - Difdisofil
% we have matrix 2x2 where we saved the coordinate of patcher edge
% coche - ColorChecker
%%%%%%
% Natural colors
%%%%%%
% 1 - Dark skin
coche(1, 1) = {'Dark skin'};
coche(1, 2) = {[height - 3223, 2275; height - 3075, 2423]};
% 2	- Light skin
coche(2, 1) = {'Light skin'};
coche(2, 2) = {[height - 3223, 2447; height - 3075, 2595]};
% 3 - Blue sky
coche(3, 1) = {'Blue sky'};
coche(3, 2) = {[height - 3223, 2620; height - 3075, 2769]};
% 4 - Foliage
coche(4, 1) = {'Foliage'};
coche(4, 2) = {[height - 3223, 2792; height - 3075, 2942]};
% 5 - Blue flower
coche(5, 1) = {'Blue flower'};
coche(5, 2) = {[height - 3223, 2965; height - 3075, 3115]};
% 6 - Bluish green
coche(6, 1) = {'Bluish green'};
coche(6, 2) = {[height - 3223, 3138; height - 3075, 3287]};
%%%%%%
% Miscellaneous colors
%%%%%%
% 7 - Orange
coche(7, 1) = {'Orange'};
coche(7, 2) = {[height - 3053, 2275; height - 2906, 2423]};
% 8	- Purplish blue
coche(8, 1) = {'Purplish blue'};
coche(8, 2) = {[height - 3053, 2447; height - 2905, 2597]};
% 9 - Moderate red
coche(9, 1) = {'Moderate red'};
coche(9, 2) = {[height - 3053, 2621; height - 2905, 2769]};
% 10 - Purple
coche(10, 1) = {'Purple'};
coche(10, 2) = {[height - 3053, 2793; height - 2905, 2943]};
% 11 - Yellow green
coche(11, 1) = {'Yellow green'};
coche(11, 2) = {[height - 3052, 2966; height - 2905, 3116]};
% 12 - Orange yellow
coche(12, 1) = {'Orange yellow'};
coche(12, 2) = {[height - 3052, 3139; height - 2905, 3287]};
%%%%%%
% Primary and secondary colors
%%%%%%
% 13 - Blue
coche(13, 1) = {'Blue'};
coche(13, 2) = {[height - 2883, 2275; height - 2735, 2423]};
% 14 - Green
coche(14, 1) = {'Green'};
coche(14, 2) = {[height - 2883, 2448; height - 2735, 2598]};
% 15 - Red
coche(15, 1) = {'Red'};
coche(15, 2) = {[height - 2883, 2621; height - 2735, 2769]};
% 16 - Yellow
coche(16, 1) = {'Yellow'};
coche(16, 2) = {[height - 2883, 2794; height - 2735, 2943]};
% 17 - Magenta
coche(17, 1) = {'Magenta'};
coche(17, 2) = {[height - 2882, 2968; height - 2735, 3116]};
% 18 - Cyan
coche(18, 1) = {'Cyan'};
coche(18, 2) = {[height - 2882, 3140; height - 2735, 3288]};
%%%%%%
% Primary and secondary colors
%%%%%%
% 19 - White
coche(19, 1) = {'White'};
coche(19, 2) = {[height - 2712, 2275; height - 2565, 2424]};
% 20 - Neutral 8
coche(20, 1) = {'Neutral 8'};
coche(20, 2) = {[height - 2712, 2448; height - 2565, 2598]};
% 21 - Neutral 6.5
coche(21, 1) = {'Neutral 6.5'};
coche(21, 2) = {[height - 2712, 2621; height - 2565, 2770]};
% 22 - Neutral 5
coche(22, 1) = {'Neutral 5'};
coche(22, 2) = {[height - 2712, 2794; height - 2565, 2943]};
% 23 - Neutral 3.5
coche(23, 1) = {'Neutral 3.5'};
coche(23, 2) = {[height - 2712, 2968; height - 2565, 3116]};
% 24 - Black
coche(24, 1) = {'Black'};
coche(24, 2) = {[height - 2712, 3140; height - 2565, 3288]};
%%%%%%

clear height width;

% show pacher
% i = 24;
% patcher0 = picture(coche{i, 2}(1, 1) : coche{i, 2}(2, 1),...
%     coche{i, 2}(1, 2) : coche{i, 2}(2, 2), :);
% image(patcher0);

% SNR for each of 24 patches of ColorChecker
% в даному випадку вим≥рюванн€ в≥дбуваЇтьс€ спочатку по стовбчиках а пот≥м
% по р€дку (результатам стовпчик≥в), можливо це може призвести до в≥дм≥нних
% результат≥в, тому варто з≥ставити коли матриц€ перетворюЇтьс€ у вектор
SNRm = zeros(chanels, size(coche, 1));
SNRv = zeros(chanels, size(coche, 1));
for i = 1 : size(SNRm, 2)
    patcher = picture(coche{i, 2}(1, 1) : coche{i, 2}(2, 1),...
        coche{i, 2}(1, 2) : coche{i, 2}(2, 2), :);
    for j = 1 : size(SNRm, 1)
        % matrix
        part = double(patcher(:, :, j));
        signal = mean(mean(part));
        noise = std(std(part, 1), 1);
        SNRm(j, i) = signal / noise;
        %  vector
        part = part(:);
        signal = mean(part);
        noise = std(part, 1);
        SNRv(j, i) = signal / noise;
    end
end

clear i j signal noise patcher part;

% Graphics - present result

% First
figure('Name','Calculate SNR using matrix','NumberTitle','off');
PresentInfo('SNR of patches for each RGB chanel using matrix', ...
    SNRm, coche, true);

% Second
figure('Name','Calculate SNR using vector','NumberTitle','off');
PresentInfo('SNR of patches for each RGB chanel using vector', ...
    SNRv, coche, false);
