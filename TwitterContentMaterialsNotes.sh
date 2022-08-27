#!/bin/bash

<<Block_comment
ttf-mscorefonts-installer -> Arial

 Pearly White (SW 7009) Sherwin Williams - Paint Color

Color Name: 	Pearly White (SW 7009)
Hex Color Code: 	#E8E3D9
RGB Color Code: 	RGB(232, 227, 217)
CMYK Values *: 	0.00%, 2.16%, 6.47%, 9.02% 
Block_comment


watermarkResizeMobile() {
    ## Watermark and resize all for mobile
    for i in *.jpg
    do
        read w h < <(identify -format "%w %h" "$i")
        if [ $w -ge $h  ]; then
            convert "$i" -geometry 1200 tmp_img.png
            read h < <(identify -format "%h" tmp_img.png)
            convert TKAF-Watermark.png -geometry x"$h" tmp_wm.png
        else
            convert "$i" -geometry x1200 tmp_img.png     
            read w < <(identify -format "%w" tmp_img.png)
            convert TKAF-Watermark.png -geometry "$w" tmp_wm.png
        fi
        composite -gravity center tmp_wm.png tmp_img.png "web_$i"
        rm tmp_img.png tmp_wm.png
    done

}

twirret() {
    ## Watermark, resize, cut, archive all for Twitter feed
    for i in *.jpg *.png
    do

        if i == *.jpg; then
        if i == *.png; then

        read w h < <(identify -format "%w %h" "$i")
        if [ $w -ge $h  ]; then
            convert "$i" -geometry 1200 tmp_img.png
            read h < <(identify -format "%h" tmp_img.png)
            convert TKAF-Watermark.png -geometry x"$h" tmp_wm.png
        else
            convert "$i" -geometry x1200 tmp_img.png     
            read w < <(identify -format "%w" tmp_img.png)
            convert TKAF-Watermark.png -geometry "$w" tmp_wm.png
        fi
        composite -gravity center tmp_wm.png tmp_img.png "web_$i"
        rm tmp_img.png tmp_wm.png
    done
}



runFunction() {
    ## Run operation for above functions

    ## Limited quality statements are included from Bash
    . /qualityStatements.txt

    case $1 ==  twirret ; then
        twirret

}
