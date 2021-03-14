# Defined in - @ line 1
function objd --wraps='objdump' --description 'options: -S -l'
  objdump -M intel $argv[1] -j .text --disassemble=$argv[2] $argv[3..-1];
end
