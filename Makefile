.PHONY: build install clean pkg

build:
	makepkg -f

install:
	sudo cp hook /usr/lib/initcpio/hooks/neoshy
	sudo cp install /usr/lib/initcpio/install/neoshy
	@echo "Don't forget to add 'neoshy' to HOOKS in /etc/mkinitcpio.conf and run mkinitcpio -P"

pkg:
	makepkg -f --source

clean:
	rm -f *.tar.zst *.tar.gz *.pkg.tar.* *.log
	rm -rf pkg src
