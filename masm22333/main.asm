
includelib kernel32.lib
includelib msvcrt.lib

GetStdHandle proto
WriteFile proto	
ReadFile proto	
ExitProcess  proto	
.data
	
hStdIn dq	? 
hStdOut dq	?
msg db "hello world!", 0
msgln db ?


in_buffer db 100 dup( ?); hundred bytes 
.code
main proc
	;mov [destination]

	sub rsp, 28h        ; space for 4 arguments + 16byte aligned stack
	;-------getting handles ---
	;----stdin
	mov rcx, -11
	call GetStdHandle
	mov [hStdOut], rax; DWORD hStdOut = GetStdHandle(-11);
	;-----stdout
	mov rcx, -10
	call GetStdHandle
	mov [hStdIn], rax;DWORD hStdIn = GetStdHandle(-10);

	add rsp, 28h
	;-------end getting handles 


	
	mov rcx, hStdOut
	mov rdx, offset msg
	mov r8, 12
	call WriteFile
	add rsp, 28h
	;-------end write to stdout 	
	
	;-------start read from stdin
	sub	rsp, 28h
	mov rcx, hStdIn
	mov rdx, offset in_buffer
	mov r8, 12
	call ReadFile 		
	add rsp, 28h	
	;------finish read 
	;-----print read 
	sub	rsp, 28h
	mov rcx, hStdOut
	mov rdx, offset in_buffer
	mov r8, 12
	call WriteFile
	add rsp, 28h

	call ExitProcess

main endp

end