%% Topological Contour Map and Defect Overlay Visualization
% This script loads 2D topological data from a file, generates contour maps,
% extracts minutiae from a fingerprint image, and overlays topological defects.

clear; clc;

%% Step 1: Load Data and Generate Contour Plot
% Load the topological data from the provided file
Z = load("Sample 3.SIG_TOPO_FRW.txt");

% Create grid coordinates for contour plotting
[X, Y] = meshgrid(1:256, 1:256);

% Generate and display the contour plot
figure;
contourf(Y .* 0.359, X .* 0.359, Z .* 1e6, 'EdgeAlpha', 0.6);
colormap('summer');
colorbar;
alpha(0.3); % Adjust transparency of the contour
view(90, 90); % Ensure correct visualization orientation
axis image; axis off; % Maintain aspect ratio and remove axis
set(gca, 'FontName', 'Times', 'FontSize', 18);
saveas(gca, "contourmap.svg");

%% Step 2: Fingerprint Minutiae Extraction and Overlay
% Load fingerprint image and convert to binary
binary_image = imbinarize(imread('C:\Users\hlama\Desktop\Zain_Analysis\Sample 3.SIG_TOPO_FRW.tiff'));

% Extract minutiae from the binary fingerprint image
[thin_image, outImg] = extract_minutiae(binary_image);

% Resize extracted minutiae image to match topological data dimensions
outImg_resized = imresize(outImg, [size(Z, 1), size(Z, 2)]);

% Capture the contour plot as an image for overlay
frame = getframe(gca);
overlay_image = frame2im(frame);
overlay_image = imresize(overlay_image, [size(Z, 1), size(Z, 2)]);

% Overlay minutiae data onto the contour plot
fused_image = imfuse(overlay_image, outImg_resized, 'blend');

% Display overlay image with transparency
figure;
imshow(overlay_image);
hold on;
h = imshow(outImg_resized);
set(h, 'AlphaData', 0.3); % Set transparency for the minutiae overlay
hold off;
axis image; axis off; % Maintain aspect ratio and remove axis

% Add a colorbar matching the original contour limits
colorbar;
colormap("summer");
c = colorbar;
caxis(caxis); % Ensure color limits match the contour plot
set(gca, 'FontName', 'Times', 'FontSize', 8);
saveas(gcf, "Contour_overlayed_minutiae.svg");

%% Step 3: Defect Overlay on Contour Map
% Load the defect data
load("C:\Users\hlama\Desktop\Zain_Analysis\Defector-master\Defects.mat");

% Extract the defect information (positions and orientations)
pos_defect_cent = posDefCents{1,1};
neg_defect_cent = negDefCents{1,1};
pos_defect_ori = posDefOris{1,1};
neg_defect_ori = negDefOris{1,1};

% Define scale factors for the coordinates and orientation vectors
scale_x = 1 / 0.390;
scale_y = 1 / 0.390;
vector_scale = 1; % Adjust this for better vector visualization

% Create a new contour plot for defect overlay
figure;
contourf(Y, X, Z .* 1e6, 'EdgeAlpha', 0.6);
colormap('summer');
colorbar;
view(90, 90); % Correct visualization orientation
axis image; axis off;
hold on;

% Plot positive defect centers with orientation vectors
for i = 1:size(pos_defect_cent, 1)
    % Compute start and end points for the orientation vector
    x_start = pos_defect_cent(i, 1) * scale_x;
    y_start = pos_defect_cent(i, 2) * scale_y;
    x_end = x_start + vector_scale * cosd(pos_defect_ori(i));
    y_end = y_start + vector_scale * sind(pos_defect_ori(i));
    
    % Plot orientation vector and defect center
    plot([y_start, y_end], [x_start, x_end], 'r', 'LineWidth', 1.5);
    plot(y_start, x_start, '^', 'MarkerFaceColor', 'r', 'MarkerSize', 8, "MarkerEdgeColor", "none");
end

% Plot negative defect centers with orientation vectors
for i = 1:size(neg_defect_cent, 1)
    % Compute start and end points for the orientation vector
    x_start = neg_defect_cent(i, 1) * scale_x;
    y_start = neg_defect_cent(i, 2) * scale_y;
    x_end = x_start + vector_scale * cosd(neg_defect_ori(i));
    y_end = y_start + vector_scale * sind(neg_defect_ori(i));
    
    % Plot orientation vector and defect center
    plot([y_start, y_end], [x_start, x_end], 'b', 'LineWidth', 1.5);
    plot(y_start, x_start, 'o', 'MarkerFaceColor', 'b', 'MarkerSize', 8, "MarkerEdgeColor", "none");
end

hold off;
set(gca, 'FontName', 'Times', 'FontSize', 18);
saveas(gcf, "Contour_overlayed_topologicaldefect.svg");

%% Summary of Code Sections
% 1. **Contour Plot**: Generates a topological map based on the data file.
% 2. **Fingerprint Minutiae Extraction**: Extracts minutiae from a binary fingerprint image
%    and overlays the results onto the contour plot.
% 3. **Topological Defect Overlay**: Visualizes topological defects (positive and negative centers)
%    with orientation vectors, overlaid on the contour plot.
