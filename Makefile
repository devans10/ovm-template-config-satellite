DESTDIR=
PACKAGE=ovm-template-config-satellite
VERSION=0.1

help:
	@echo 'Commonly used make targets:'
	@echo '  install    - install program'
	@echo '  dist       - create a source tarball'
	@echo '  rpm        - build RPM packages'
	@echo '  clean      - remove files created by other targets'

dist: clean
	mkdir $(PACKAGE)-$(VERSION)
	tar -cSp --to-stdout --exclude .svn --exclude .hg --exclude .hgignore \
	    --exclude $(PACKAGE)-$(VERSION) * | tar -x -C $(PACKAGE)-$(VERSION)
	tar -czSpf $(PACKAGE)-$(VERSION).tar.gz $(PACKAGE)-$(VERSION)
	rm -rf $(PACKAGE)-$(VERSION)

install:
	install -D satellite $(DESTDIR)/etc/template.d/scripts/satellite
        install -D bootstrap_wrapper.sh $(DESTDIR)/usr/local/sbin/bootsrtap_wrapper.sh
rpm: dist
	rpmbuild -ta $(PACKAGE)-$(VERSION).tar.gz

clean:
	rm -fr $(PACKAGE)-$(VERSION)
	find . -name '*.py[cdo]' -exec rm -f '{}' ';'
	rm -f *.tar.gz

.PHONY: dist install rpm clean
