# ARM-Shellcode
ARM AARCH64 Reverse Shell.

# Compiling
## Linux/AARCH64 as a guest OS on a MAC or other ARM-based device
`as arm-revshell.s -o arm-revshell.o && ld arm-revshell.o -o arm-revshell`

### Begin a Netcat Listener
`nc -lvp 1337`

### Execute

Then, run `./arm-revshell` to execute.

## x86-64 host OS, but you want to run/compile for AARCH64
`aarch-linux-gnu-as arm-revshell.s -o arm-revshell.o && aarch-linux-gnu-ld arm-revshell.o -o arm-revshell`

### Begin a Netcat Listener
`nc -lvp 1337`

### Execute

Then, run `qemu-aarch64 ./arm-revshell` to execute.`
