section .data
msg_prime db ' is prime', 0x00
msg_prime_len equ $ - msg_prime
msg_not_prime db ' is not prime', 0x00
msg_not_prime_len equ $ - msg_not_prime
newline db 0x0a, 0x00
nl_len equ $ - newline
nums db '123456789101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899'

num dq 0
offset dq 0

section .text
global _start

_start:
		xor rax, rax
		mov [num], rax
		mov [offset], rax

	loop_head:
	
	
	  mov rax, [num]
	  add rax, 1
	  mov [num], rax
	  
		cmp rax, 100
		jge loop_exit
		
		mov rbx, [offset]
		
		mov rcx, nums
		add rcx, rbx
		
		mov rdx, 1
		cmp rax, 9
		jle small
		add rdx, 1
		
		small:
		
		mov rbx, 1
		mov rax, 4
		int 0x80
		
		mov rbx, [offset]
		add rbx, rdx
		mov [offset], rbx
		
		mov rax, [num]
		
		cmp rax, 1
		jle p_n_prime
		mov rcx, rax
		mov rbx, 2
		
	prime_loop:
	  cmp rbx, rcx
	  jge prime
	  mov rax, rcx
	  xor rdx, rdx
	  div rbx
	  
	  cmp rdx, 0
	  je p_n_prime
	  
	  inc rbx
	  jmp prime_loop
	  
  prime:
    mov rdx, msg_prime_len 
    mov rcx, msg_prime
    mov rbx, 1
    mov rax, 4
    int 0x80
    jmp p_newline
    
    p_n_prime:
     mov rdx, msg_not_prime_len 
    mov rcx, msg_not_prime
    mov rbx, 1
    mov rax, 4
    int 0x80
    
  p_newline:
    mov rdx, nl_len
    mov rcx, newline
    mov rbx, 1
    mov rax, 4
    int 0x80
		
		jmp loop_head
		
	loop_exit:
		mov rax, 1
		xor rbx, rbx
		int 0x80
	
	
	