for i in *.wav 
do
	ffmpeg -i "$i" -acodec libvorbis "$(echo "$i" | sed s/\.wav/.ogg/)"
	rm "$i"
done
