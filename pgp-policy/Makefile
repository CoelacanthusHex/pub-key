# SPDX-License-Identifier: AGPL-3.0-or-later

MAKE = make
RM   = rm -rf

.PHONY: render-all render-all-html
render-all: render-all-html
render-all-html: pgp-policy.en.html pgp-policy.zh-CN.html pgp-policy.zh-TW.html

pgp-policy.en.html: pgp-policy.en.md pandoc.yaml style.css
	pandoc --from=markdown --to=html5 --standalone pgp-policy.en.md -o pgp-policy.en.html --metadata-file=pandoc.yaml

pgp-policy.zh-CN.html: pgp-policy.zh-CN.md pandoc.yaml style.css
	pandoc --from=markdown --to=html5 --standalone pgp-policy.zh-CN.md -o pgp-policy.zh-CN.html --metadata-file=pandoc.yaml

.PHONY: clean-zh-TW
clean-zh-TW:
	$(RM) pgp-policy.zh-TW.md

pgp-policy.zh-TW.md: pgp-policy.zh-CN.md
	opencc --config s2twp --input pgp-policy.zh-CN.md --output pgp-policy.zh-TW.md
	sed '/（\[正體中文版本\]\(.*\)）/d' -i pgp-policy.zh-TW.md
	sed '/\[English Version\]/a （[简体中文版本](./pgp-policy.zh-CN.html)）' -i pgp-policy.zh-TW.md
	sed 's/title: PGP 密钥签名策略/title: PGP 金鑰簽名策略/g' -i pgp-policy.zh-TW.md
	sed 's/lang: zh-CN/lang: zh-TW/g' -i pgp-policy.zh-TW.md

pgp-policy.zh-TW.html: pgp-policy.zh-TW.md pandoc.yaml style.css
	pandoc --from=markdown --to=html5 --standalone pgp-policy.zh-TW.md -o pgp-policy.zh-TW.html --metadata-file=pandoc.yaml

policy.txt: pgp-policy.en.md
	@# using gfm because markdown will use non-ASCII char
	pandoc --from=gfm --to=plain --preserve-tabs pgp-policy.en.md -o policy.txt
	sed '1 i PGP Sign Policy\n' -i policy.txt
	sed '/中文版本/d' -i policy.txt
	sed '/and QR code/,+3d' -i policy.txt

.PHONY: signed
signed: policy.txt
	$(RM) policy-signed.txt
	gpg -o policy-signed.txt --clear-sign policy.txt

.PHONY: update-policy
update-policy: signed pgp-policy.zh-TW.md

.PHONY: clean
clean:
	$(RM) pgp-policy.*.html
