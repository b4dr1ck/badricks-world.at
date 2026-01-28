# badricks-world.at

## Requirements

* webserver
* npm / node
* git

## Installation

```bash
# installation on linux-systems
git clone git@github.com:b4dr1ck/badricks-world.at.git
cd badricks-world.at
npm install
npm run build
cd dist
cp -rf * /var/www/html # path to the website
```

```bash
# path to the images (relative to the base-path of the website)
"./img/original/" # original images 
"./img/small/" # small images fot the thumbnails
"./img/icons/" # icons for the social-media links
"./banner.jpg " # for the background banner of the homepage
```
