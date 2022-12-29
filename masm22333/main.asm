
includelib kernel32.lib
includelib msvcrt.lib
GetStdHandle proto
WriteFile proto	
ExitProcess  proto	
.data

hStdIn qword	? 
hStdOut qword	?
msg db "hello world!", 0

.code
main proc
	;mov [destination]

	sub rsp, 28h        ; space for 4 arguments + 16byte aligned stack
	;-------getting handles ---
	;----stdin
	mov rcx, -11
	call GetStdHandle
	mov [hStdOut], rax; DWORD hStdIn = GetStdHandle(-11);
	;-----stdout
	mov rcx, -10
	call GetStdHandle
	mov [hStdIn], rax;DWORD hStdOut = GetStdHandle(-10);

	;-------end getting handles 

	mov rcx, hStdOut
	mov rdx, offset msg
	mov r8, 12
	call WriteFile
	add rsp, 28h
	call ExitProcess

main endp

end