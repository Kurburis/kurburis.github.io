HUGO := $(if $(wildcard .tools/hugo/hugo),.tools/hugo/hugo,hugo)
.PHONY: setup export build serve
setup:
	bash scripts/setup.sh
export:
	emacs --batch -Q --load scripts/export.el
build:
	$(HUGO) --minify
serve:
	$(HUGO) server --bind 127.0.0.1
