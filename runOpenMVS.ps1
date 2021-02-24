##################################################################################
#   MIT License
#
#   Copyright (c) [2021] [René Horn]
#
#   Permission is hereby granted, free of charge, to any person obtaining a copy
#   of this software and associated documentation files (the "Software"), to deal
#   in the Software without restriction, including without limitation the rights
#   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#   copies of the Software, and to permit persons to whom the Software is
#   furnished to do so, subject to the following conditions:
#
#   The above copyright notice and this permission notice shall be included in all
#   copies or substantial portions of the Software.
#
#   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#   SOFTWARE.
###################################################################################
# Windows PowerShell script for auto process all stages of openMVS in one shot
#
# 1.) select the <scene>.mvs (the output of the point cloud program)
# 2.) open thh folder with the openMVS binaries (.exe) files
#
# works good with Regard3d, use -> export to folder, open openMVS for windows binaries found in the windows sample on github
# can run the default settings of mvs. Regard3d with highest resolution .jpg pics, and both 'ultra' settings on first run 
# get sooooo much points in cloud. Much better than Meshroom program. openMVS is all non cuda this time. 
# use free Meshlab program to export obj files. Then, for easy clean up the mesh, use free autodesk meshmixer. It is also free.
# be aware processing time rises exponential with pic count and resoution. Test 10 images to see what you will get.
# see also post from https://peterfalkingham.com/2018/05/22/photogrammetry-testing-12-revisiting-openmvg-with-openmvs/

[Console]::OutputEncoding = [Text.UTF8Encoding]::UTF8
$OutputEncoding =[Console]::OutputEncoding # how Powershell talks to external programs
$OutputEncoding.EncodingName # write name(version) to screen


	Add-Type -AssemblyName System.Windows.Forms
		
	$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ 
		InitialDirectory = [Environment]::GetFolderPath('Desktop') 
	}
	#$FileBrowser.filter = "MVS (*.mvs) and (*.exe)| *.exe; *.mvs"
	$FileBrowser.filter = "MVS (*.mvs)| *.mvs"
	$null = $FileBrowser.ShowDialog() # ShowDialog() brings garbage, init the dialog visible
	
	write-host "	! open MVS scene file !"
		$fileNameMVSscene = $FileBrowser.FileName
		$folderNameMVSscene = Split-Path $fileNameMVSscene -Resolve
	$FileBrowser # show object
	
	$FileBrowser.filter = "EXE (*.exe)| *.exe"
	$null = $FileBrowser.ShowDialog() 
		
	write-host "	! open MVS exe file !"
		$fileaNameMVSbinaries = $FileBrowser.FileName
		$fileaNameMVSbinaries = Split-Path $fileaNameMVSbinaries -Resolve
	
	$argListDense =   " -w `"$folderNameMVSscene`"" + " -i `"$fileNameMVSscene`"" + " -o `"$folderNameMVSscene" 			+ "\scene_dense.mvs`"" #| out-file .\args.txt -append
	$argListRecon =   " -w `"$folderNameMVSscene`"" + " -i `"$folderNameMVSscene" + "\scene_dense.mvs`"" + " -o `"$folderNameMVSscene" + "\scene_dense_recon.mvs`"" #| out-file .\args.txt -append
	$argListRfine =   " -w `"$folderNameMVSscene`"" + " -i `"$folderNameMVSscene" + "\scene_dense_recon.mvs`"" + 	" -o `"$folderNameMVSscene" + "\scene_dense_recon_rfine.mvs`"" #| out-file .\args.txt -append
	$argListTextu =   " -w `"$folderNameMVSscene`"" + " -i `"$folderNameMVSscene" + "\scene_dense_recon_rfine.mvs`"" + " -o `"$folderNameMVSscene" + "\scene_dense_recon_rfine_textu.mvs`"" #| out-file .\args.txt -append
	
	$dense   = $fileaNameMVSbinaries + "\" + "DensifyPointCloud"
	$recon   = $fileaNameMVSbinaries + "\" + "ReconstructMesh" 
	$refine  = $fileaNameMVSbinaries + "\" + "RefineMesh" 
	$texture = $fileaNameMVSbinaries + "\" + "TextureMesh"
	
	$arrayExeFile = @( $dense, $recon, $refine, $texture )	
	$arrayArgList = @( $argListDense, $argListRecon, $argListRfine, $argListTextu )
	
	$i = 0 
	foreach ( $exe in $arrayExeFile ){
		
		Start-Process -filepath $exe -argumentlist $arrayArgList[$i]  -NoNewWindow -PassThru -wait 
		$i++
		#Read-Host -Prompt "Press Enter to proceed " 
	}
	
	#break


Read-Host -Prompt "Press Enter to exit " 
