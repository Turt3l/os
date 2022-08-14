x86_64_asm_source_files := $(shell find src/impl/x86-64 -name *.asm)
x86_64_asm_object_files := $(patsubst src/impl/x86-64/%.asm, build/x86_64/%.o, $(x86_64_asm_source_files))

$(x86_64_asm_object_files): build/x86_64/%.o : src/impl/x86-64/%.asm
	mkdir -p $(dir $@) && \
	nasm -f elf64 $(patsubst build/x86_64/%.o, src/impl/x86-64/%.asm, $@) -o $@

.PHONY: build-x86_64
build-x86_64: $(x86_64_asm_object_files)
	mkdir -p dist/x86_64 && \
	x86_64-elf-ld -n -o dist/x86_64/kernel.bin -T targets/x86-64/linker.ld $(x86_64_asm_object_files) && \
	cp dist/x86_64/kernel.bin targets/x86-64/iso/boot/kernel.bin && \
	grub-mkrescue /usr/lib/grub/i386-pc -o dist/x86_64/kernel.iso targets/x86-64/iso