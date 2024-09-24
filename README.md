## Instruction to run the code
1. Detail of the external open-source code that's used here. 
   https://github.com/Pseudomoaner/Defector, developed by Oliver J. Meacock and Amin Doostmohammadi. A part of it is used here, and listed in the folder `Defector-master`.
2. Run the file `DefectorExample.m` after properly adding the image of interest under the variable `Root`.
3. Save the workspace after running the  `DefectorExample.m` and save it with the name `Defects. mat`. The `Defects. mat` contains the variables with information on coordinates of +1/2 defect and -1/2 defects respectively.
   These variables are later called in the code `Topological_map_defetc_visullaization.m` in a line as mentioned below.
   
   ```
   Step 3: Defect Overlay on Contour Map
   %Load the defect data
   load("C:\Users\hlama\Desktop\Zain_Analysis\Defector-master\Defects.mat");
   ```
4. Run the `Topological_map_defetc_visullaization.m`. The outputs similar to that shown below will be obtained, they will be an image in `.svg` format.
   
## Output from this code
1. Detecting the  ridge bifurcation and the end in a pattern. 
The left image shows the fingerprint, with the marked edge and the bifurcation. The right image is the output image, showing the minutiae. 
![Image_1](https://github.com/user-attachments/assets/f78ca23e-53c9-41fb-9dc0-4aafec302cdb)

2. Images showing the ridge and valley with minutiae and topological defects (+1/2 and -1/2). 
![Image_2](https://github.com/user-attachments/assets/6e3392d6-d824-45db-b6c8-cd6a3291ac98)
