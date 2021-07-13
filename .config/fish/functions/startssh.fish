# Defined in - @ line 1
function startssh --description 'alias startssh sudo /usr/sbin/sshd'
	doas /usr/sbin/sshd;
end
