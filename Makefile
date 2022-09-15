install:
	apt install zola

serve:
	zola build
	zola serve
	
.PHONY: install serve