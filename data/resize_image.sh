#!usr/bin/env sh

for name in ImagesTestCropAll//*.jpg; do
	convert -resize 224x224\! $name $name
done
