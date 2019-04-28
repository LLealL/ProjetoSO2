rm boot.o kernel.o myos.bin myos.iso

./i686-elf/bin/i686-elf-as boot.s -o boot.o

./i686-elf/bin/i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

./i686-elf/bin/i686-elf-gcc -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

if grub-file --is-x86-multiboot myos.bin; then
    echo multiboot confirmed
else
    echo the file is not multiboot
fi

rm isodir/boot/grub/grub.cfg
rm isodir/boot/myos.bin
rmdir -p isodir/boot/grub


mkdir -p isodir/boot/grub
cp myos.bin isodir/boot/myos.bin
cp grub.cfg isodir/boot/grub/grub.cfg
grub-mkrescue -o myos.iso isodir

