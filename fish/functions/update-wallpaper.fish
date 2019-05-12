function update-wallpaper --description "Downloads a new wallpaper from unsplash"
    wget -O ~/.background.jpg "https://source.unsplash.com/2560x1440/?forest"
    feh --bg-scale ~/.background.jpg
end
