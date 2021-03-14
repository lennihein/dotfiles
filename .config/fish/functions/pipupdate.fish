# Defined in - @ line 1
function pipupdate --wraps=sudo\ pip\ list\ --outdated\ --format=freeze\ \|\ grep\ -v\ \'\^\\-e\'\ \|\ cut\ -d\ =\ -f\ 1\ \ \|\ xargs\ -n1\ sudo\ pip\ install\ -U --description alias\ pipupdate\ sudo\ pip\ list\ --outdated\ --format=freeze\ \|\ grep\ -v\ \'\^\\-e\'\ \|\ cut\ -d\ =\ -f\ 1\ \ \|\ xargs\ -n1\ sudo\ pip\ install\ -U
  sudo pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo pip install -U $argv;
end
