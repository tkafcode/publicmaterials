#!/bin/bash

## Twirrets operation

for i in *.jpg *.png
    do
        case i in 
            *.jpg|*.png)
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
