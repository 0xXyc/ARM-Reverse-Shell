# ARM-Reverse-Shell
ARM AARCH64 Reverse Shell.

<img width="721" alt="image" src="https://github.com/0xXyc/ARM-Shellcode/assets/42036798/87b9284d-7dc3-4ada-9338-7155a85c6162">

# Compiling
## Linux/AARCH64 as a guest OS on a MAC or other ARM-based device
`as arm-revshell.s -o arm-revshell.o && ld arm-revshell.o -o arm-revshell`

### Begin a Netcat Listener
`nc -lnvp 1337`

### Execute

Then, run `./arm-revshell` to execute.

## x86-64 host OS, but you want to run/compile for AARCH64
`aarch-linux-gnu-as arm-revshell.s -o arm-revshell.o && aarch-linux-gnu-ld arm-revshell.o -o arm-revshell`

### Begin a Netcat Listener
`nc -lnvp 1337`

### Execute

Then, run `qemu-aarch64 ./arm-revshell` to execute.
