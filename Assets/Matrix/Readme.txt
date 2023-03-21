PACK SETUP
Firstly, import the relevant package based on your render pipeline.
You can use two versions of the basic matrix effect lit shader: specular and metallic in URP, HDRP and Built-in. 
It adds the effect on top of the custom shaders that work like standard shaders in each pipeline.

The asset supports Amplify Shader Editor as well as Unity's Shader Graph. You can create with them custom effects, such as transparent matrix effect and other.

Note: Built-in pipeline 2020 doesn't support shader graph and therefore the capabilities of the asset are limited.

Basic Matrix Effect LIT Properties
Use Triplanar: If checked, the material uses effect independent of the mesh UVs.
Width (0 - 0.6): Width of the characters used in effect
Letters Time Scale (0 - 0.005): How often characters randomly change.
Drop Exponent (1 -20): Exponent of each "drop" of the letters. 
Drop Speed (0 - 5): The speed of characters drops.
Drop Length (0 - 30): Length of each line.
Drop Head Shrink ( 0.1 - 1): How to smooth the bottom of the dropping character line.
UV Tilling: Controls tilling of the mesh uvs or triplanar uvs when in use. 
Textures
Use these textures for the shader properties.
Mask: Matrix\Textures\Matrix_Mask.png
Noise: Matrix\Textures\Matrix_WhiteNoise.png
Font: Matrix\Textures\Matrix_Font.png

Custom shader creation
You can find example shader graphs in Matrix\Your Pipeline\Shaders\ folder.
Please refer to Basic "Matrix Effect LIT Properties" of the shader to create suitable shader graph properties. You shold copy shader properties to maintain their references, 
so you could use differenc shader versions withiut the need to tweak properties each time you change material.

For further information check the documentation:
https://inabstudios.gitbook.io/matrix-effect/

Enjoy!

Support: izzynab.publisher@gmail.com