echo off
SETLOCAL ENABLEDELAYEDEXPANSION

FOR %%I in (*.hdr) DO (
 	set CurDir=%%~nI/
 	echo !CurDir!
	if not exist !CurDir! mkdir "!CurDir!"
	
	cd !CurDir!
	if not exist lambertian mkdir lambertian
	if not exist ggx mkdir ggx
	if not exist charlie mkdir charlie
	cd ..
	
	set outputPathLambertian=!CurDir!/lambertian/diffuse.ktx2
	cli.exe -inputPath %%I -distribution Lambertian -outCubeMap !outputPathLambertian!

	set outputPathGgx=!CurDir!/ggx/specular.ktx2
	cli.exe -inputPath %%I -distribution GGX -outCubeMap !outputPathGgx! -mipLevelCount 11 -lodBias 0

	set outputPathCharlie=!CurDir!/charlie/sheen.ktx2
	cli.exe -inputPath %%I -distribution Charlie -outCubeMap !outputPathCharlie! -mipLevelCount 11 -lodBias 0
)
