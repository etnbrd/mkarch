# mkarch

mkarch is a set of scripts I use to automate the setup of my archs.

the one-liner :  
`zsh <(wget https://raw.github.com/gravitezero/mkarch/master/main.sh -qO -)`

About zsh :  
zsh is the default shell in arch, that's why I used it.
However, the scripts should be fully compatible with bash if one replace the variable indiraction syntax in utils.sh from `${(P)2}` (zsh syntax) to `${!2}` (bash syntax)