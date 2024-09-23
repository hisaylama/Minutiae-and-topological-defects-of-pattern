## Required software 
1. https://github.com/Pseudomoaner/Defector, developed by Oliver J. Meacock and Amin Doostmohammadi. A part of it is used here, and listed in the folder `Defector-master`.
   Run the file `DefectorExample.m` after properly adding the image of interest under the variable `Root`.
2. Save the workspace after running the  `DefectorExample.m` and save it with name `Defects. mat`. The `Defects. mat` contains the variables with information on coordinates of +1/2 defect and -1/2 defects respectively.
   These variables are later called in the code `Topological_map_defetc_visullaization.m` in a line as mentioned below.
   ```
   Step 3: Defect Overlay on Contour Map
   %Load the defect data
   load("C:\Users\hlama\Desktop\Zain_Analysis\Defector-master\Defects.mat");
   ```

## Output from this code
1. Detecting the  ridge bifurcation and the end in a pattern. 
The left image shows the fingerprint, with the marked edge and the bifurcation. The right image is the output image, showing the minutiae. 
![Image_1](https://github.com/user-attachments/assets/8430d6a5-646b-4ae3-a658-132fba0be03a)

2. Images showing the ridge and valley with minutiae and topological defects (+1/2 and -1/2). 
![Image_2](https://github.com/user-attachments/assets/f4c3cfa4-a883-4326-b0bb-d7a7ddfa9713)
