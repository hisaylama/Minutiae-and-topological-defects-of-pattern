function [thin_image, outImg] = extract_minutiae(binary_image)
    % Function to thin a binary image and extract minutiae points (ridge endings and bifurcations)
    % Usage:
    % binary_image = imread('path_to_your_binary_image.png'); % Load a binary image
    % binary_image = imbinarize(rgb2gray(binary_image)); % Ensure it's a binary image
    % 
    % [thin_image, outImg] = extract_minutiae(binary_image);
    % 
    % % Display the results
    % figure;
    % imshow(binary_image);
    % title('Input Image');
    % 
    % figure;
    % imshow(thin_image);
    % title('Thinned Image');
    % 
    % figure;
    % imshow(outImg);
    % title('Minutiae Points');
    
    % Thinning the binary image
    thin_image = ~bwmorph(binary_image, 'thin', Inf);
    [num_row, num_col] = size(thin_image);
    N = 3; % Window size
    n = (N-1)/2; % Offset added in rows and columns
    new_row_num = num_row + 2*n;
    new_col_num = num_col + 2*n;
    
    % Padding the thinned image
    temp = zeros(new_row_num, new_col_num);
    temp((n+1):(end-n), (n+1):(end-n)) = thin_image;
    
    % Initialize the output image and matrices
    outImg = zeros(new_row_num, new_col_num, 3);
    outImg(:,:,1) = temp * 255;
    outImg(:,:,2) = temp * 255;
    outImg(:,:,3) = temp * 255;
    
    % Define neighborhood matrix
    mat = zeros(N, N);
    ridge = zeros(new_row_num, new_col_num);
    bifurcation = zeros(new_row_num, new_col_num);
    
    % Finding ridge and bifurcation
    for x = (n+11):(new_row_num - n - 10)
        for y = (n+11):(new_col_num - n - 10)
            mat = temp(x-n:x+n, y-n:y+n);
    
            if mat(2,2) == 0
                transitions = sum(sum(~mat)) - mat(2,2);
    
                if transitions == 2
                    ridge(x, y) = 1;
                elseif transitions == 4
                    bifurcation(x, y) = 1;
                end
            end
        end
    end

    outImg(:,:,1) = 0;
    outImg(:,:,2) = 0;
    outImg(:,:,3) = 0;


    % Detect the ridge end
    [ridge_x, ridge_y] = find(ridge == 1);
    % Iterate through each coordinate to draw the box
    for i = 1:length(ridge_x)
        outImg((ridge_x(i)-3):(ridge_x(i)+3), (ridge_y(i)-3):(ridge_y(i)+3), 2:3) = 0; % Red channel
        outImg((ridge_x(i)-3):(ridge_x(i)+3), (ridge_y(i)-3):(ridge_y(i)+3), 1) = 255; % Green and Blue channels
    end
    
    % Detect the bifurcation
    [bifurcation_x, bifurcation_y] = find(bifurcation == 1);
    
    for i = 1:length(bifurcation_x)
        outImg((bifurcation_x(i)-3):(bifurcation_x(i)+3), (bifurcation_y(i)-3):(bifurcation_y(i)+3), 1:2) = 0;
        outImg((bifurcation_x(i)-3):(bifurcation_x(i)+3), (bifurcation_y(i)-3):(bifurcation_y(i)+3), 3) = 255;
    end
    
    % Crop the image to remove the padding (if any)
    outImg = outImg(2:end-1, 2:end-1, :);
end
