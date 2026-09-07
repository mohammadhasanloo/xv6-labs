# Lay a lab over xv6 and build it.
#
#   make LAB=2-system-calls        apply and build
#   make apply LAB=3-scheduling    apply only
#   make labs                      list them
#
# Needs an i386-capable cross toolchain. On macOS:
#   brew install x86_64-elf-gcc x86_64-elf-binutils qemu

LAB        ?= 2-system-calls
TOOLPREFIX ?= x86_64-elf-
CPUS       ?= 1

# xv6 builds with -Werror against warnings a compiler of its era did not emit.
EXTRA_CFLAGS ?= -Wno-error -fcf-protection=none

BUILD := build/$(LAB)

all: build

apply:
	@./scripts/apply.sh $(LAB)

build: apply
	$(MAKE) -C $(BUILD) TOOLPREFIX=$(TOOLPREFIX) CPUS=$(CPUS) \
	    EXTRA_CFLAGS="$(EXTRA_CFLAGS)" xv6.img fs.img

labs:
	@ls labs

clean:
	rm -rf build

.PHONY: all apply build labs clean
