# autorun-openMVS-on-Windows
PowerShell script to run openMVS on Windows in the correct order without user interaction, since this guy can run days.
An ready to use openMVS for windows sample: https://github.com/cdcseacave/openMVS_sample
If you decided to use Regard3d point cloud program https://www.regard3d.org/, choose the export to folder otion.

All stages of openMVS in one shot (script runs the good default settings):

1.) select the <scene>.mvs - the objcts point cloud
2.) open the folder with the openMVS binaries (.exe) files

Hint:
Use Regard3d with highest resolution .jpg pics, and both 'ultra' settings at the first run.
You will get much more points in the object cloud. Much better than the Meshroom program. 
openMVS is all non cuda this time. Means you can run without intel nvidia grafics cards.
For me it runs ok on 96 GB RAM and 16 cores. Highest usage was only 60 GB RAM.

You have the option to use the free Meshlab program to export the created .obj files. 
Then, to easy clean up the mesh, use the also free meshmixer from autodesk. 
Be warned. The processing time rises exponential with pic count and pic resoution. 
Test 10 images at first to see what you will get.

Please see also post from https://peterfalkingham.com/2018/05/22/photogrammetry-testing-12-revisiting-openmvg-with-openmvs/
to learn from the best.
