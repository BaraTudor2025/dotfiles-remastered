local ab = function(str) vim.cmd("Abolish " .. str) end
vim.cmd.abbrev "edn end"
vim.cmd.iabbrev "adn and"
vim.cmd.iabbrev "cdm cmd"
ab "comand command"
ab "{fi} {if}"
ab "w{hi,ih}{el,le} while"
ab "t{eh,h}{n,ne} then"
ab "lc{oa,ao}l{,s} l{oca}l{,s}"
ab "loacl{,s} l{oca}l{,s}"
ab "l{o,c,a}{c,a,o}{a,c,o}l{,s} l{oca}l{,s}"
ab "c{aer,rae,era}{te,et} create"
ab "heigth height"
ab "d{on,no}t don't"
ab "d{oe,eo}s{,nt} d{oe}s{,n't}"
ab "r{que,euq}ire require"
ab "f{unc,nuc,ncu}{ti,it}o{an,na,n}{,s} f{unc}{ti}o{n}{,s}"
ab "re{tu,ut}{rn,nr} re{tu}{rn}"
