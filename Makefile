OK_COLOR=\033[32;01m
NO_COLOR=\033[0m
ERROR_COLOR=\033[31;01m
WARN_COLOR=\033[33;01m

ROOT_DIR := $(realpath .)

.clone:
	@echo "$(OK_COLOR)==> Downloading Yara source code...$(NO_COLOR)"
	git clone https://github.com/VirusTotal/yara.git $ROOT_DIR/libyara/source

tip: .clone
	@echo "$(OK_COLOR)==> Using Yara source at master branch $(NO_COLOR)"
	git checkout master

stable: .clone
	@echo "$(OK_COLOR)==> Using Yara 3.5.0 $(NO_COLOR)"
	git checkout tags/v3.5.0

libyara: libyara32 libyara64

libyara32:
	@echo "$(OK_COLOR)==> Generating libyara for Windows 32-Bit using MingW...$(NO_COLOR)"
	cd $ROOT_DIR/libyara/source
	make clean
	./configure --host=i686-w64-mingw32
	make
	make install prefix=$ROOT_DIR/libyara/i686-w64-mingw32

libyara64:
	@echo "$(OK_COLOR)==> Generating libyara for Windows 32-Bit using MingW...$(NO_COLOR)"
	cd $ROOT_DIR/libyara/source
	make clean
	./configure --host=x86_64-w64-mingw32
	make
	make install prefix=$ROOT_DIR/libyara/x86_64-w64-mingw32

clean:
	@echo "$(OK_COLOR)==> Cleaning...$(NO_COLOR)"
	rm -rf $ROOT_DIR/libyara
