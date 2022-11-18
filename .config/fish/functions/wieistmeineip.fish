# Defined in - @ line 1
function wieistmeineip --wraps=wget\ http://checkip.dyndns.org/\ -O\ -\ -o\ /dev/null\ \|\ cut\ -d:\ -f\ 2\ \|\ cut\ -d\\\<\ -f\ 1 --description alias\ wieistmeineip\ wget\ http://checkip.dyndns.org/\ -O\ -\ -o\ /dev/null\ \|\ cut\ -d:\ -f\ 2\ \|\ cut\ -d\\\<\ -f\ 1
  curl ifconfig.me;
end
