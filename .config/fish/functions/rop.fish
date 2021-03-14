# Defined in - @ line 1
function rop --wraps='nu -c "ROPgadget --binary /usr/lib/libc-2.33.so | grep ": pop rax" | lines | parse "{Address} : {Gadget} ; ret""' --wraps=nu\ -c\ \"ROPgadget\ --binary\ /usr/lib/libc-2.33.so\ \|\ grep\ \':\ pop\ rax\'\ \|\ lines\ \|\ parse\ \'\{Address\}\ :\ \{Gadget\}\ \;\ ret\'\" --description alias\ rop\ nu\ -c\ \"ROPgadget\ --binary\ /usr/lib/libc-2.33.so\ \|\ grep\ \':\ pop\ rax\'\ \|\ lines\ \|\ parse\ \'\{Address\}\ :\ \{Gadget\}\ \;\ ret\'\"
  nu -c "ROPgadget --binary /usr/lib/libc-2.33.so | grep '$argv' | lines | parse '{Address} : {Gadget} ; ret'";
end
