# autorun-openMVS-on-Windows
PowerShell script to run openMVS on Windows in correct order without interaction, since it can run days

Windows PowerShell script for auto process all stages of openMVS in one shot

1.) select the <scene>.mvs (the output of the point cloud program)
2.) open thh folder with the openMVS binaries (.exe) files

works good with Regard3d, use -> export to folder 
open openMVS for windows binaries are found in the windows sample on github
can run the default settings of mvs. 
Regard3d with highest resolution .jpg pics, and both 'ultra' settings on first run 
get sooooo much points in cloud. Much better than Meshroom program. openMVS is all non cuda this time. 
use free Meshlab program to export obj files. Then, for easy clean up the mesh, use free autodesk meshmixer. 
It is also free.be aware processing time rises exponential with pic count and resoution. Test 10 images to see what you will get.
see also post from https://peterfalkingham.com/2018/05/22/photogrammetry-testing-12-revisiting-openmvg-with-openmvs/
