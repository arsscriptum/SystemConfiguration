# Jekyll

## WHAT ?
Jekyll is a static site generator. It takes text written in your favorite markup language and uses layouts to create a static website. You can tweak the site’s look and feel, URLs, the data displayed on the page, and more.
https://jekyllrb.com/docs/installation/windows/

## WHY ? 

GITHUB PAGES! - THEMES

https://github.com/pages-themes/

There are cool themes that can be setup for GITHUB pages. They require Jekyll *ONLY* if you want to see them locally. This is very usefull.
So I installed Jekyll on Windows.

## REQUIREMENTS

+ Windows Subsystem Linux
+ Ubuntu (Msft Store)

## Notes

Make sure you setup you _/etc/resolv.conf_ file properly. Example:
domain           enigma
nameserver       1.1.1.1
nameserver       1.0.0.1
nameserver       8.8.8.8


### If always overwritten:

gplante@enigma:/mnt/c/Users/gplante$ **cat /etc/wsl.conf**
[network]
generateResolvConf = false