# Defined in - @ line 1
function cwe_json --wraps='/opt/cwe_checker/target/release/cwe_checker --json --out' --description 'alias cwe_json /opt/cwe_checker/target/release/cwe_checker --json --out'
  /opt/cwe_checker/target/release/cwe_checker $argv --json --out $argv.json;
end
