# SPDX-License-Identifier: AGPL-3.0-or-later

MAKE = make
RM   = rm -rf

.PHONY: pgp-policy
pgp-policy:
	$(MAKE) -C pgp-policy render-all

.PHONY: update-policy
update-policy:
	$(MAKE) -C pgp-policy update-policy

.PHONY: render-policy
render-policy: pgp-policy
	mkdir -p output
	cp pgp-policy/pgp-policy.*.html output/
	cp pgp-policy/policy.txt output/
	cp pgp-policy/policy-signed.txt output/
	cp pgp-policy/key-ownership-statement.txt output/
	cp pgp-policy/*.css output/
	cp pgp-policy/favicon.ico output/

.PHONY: render-keytext
render-keytext:
	mkdir -p output
	cp public-key-*.asc output/
	cp ssh-key.txt output/

.PHONY: render-key-qrcode
render-key-qrcode: #public-key.png public-key.svg
	cp public-key.* output/

.PHONY: render-key-slips
render-key-slips: key-slips.tex
	xelatex key-slips.tex
	$(RM) key-slips.aux key-slips.log

.PHONY: prepare-signing-party
prepare-signing-party: render-key-slips public-key.png public-key.svg
	mkdir -p key-signing-party/
	cp public-key.* key-signing-party/
	cp key-slips.pdf key-signing-party/

.PHONY: render
render: render-policy render-keytext render-key-qrcode

.PHONY: upload-pubkey
upload-pubkey:
	gpg --export 15F4180E73787863 | curl -T - https://keys.openpgp.org
	gpg --keyserver hkps://keyserver.ubuntu.com --send-keys 892EBC7DC392DFF9C9C03F1D15F4180E73787863
	gpg --keyserver hkps://pgp.mit.edu --send-keys 892EBC7DC392DFF9C9C03F1D15F4180E73787863
	gpg --keyserver hkps://keys.gnupg.net --send-keys 892EBC7DC392DFF9C9C03F1D15F4180E73787863
	gpg --keyserver hkps://pgp.surfnet.nl --send-keys 892EBC7DC392DFF9C9C03F1D15F4180E73787863
	gpg --keyserver hkps://pgp.gnd.pw --send-keys 892EBC7DC392DFF9C9C03F1D15F4180E73787863
	@#gpg --keyserver hkps://pgp.key-server.io --send-keys 892EBC7DC392DFF9C9C03F1D15F4180E73787863
	gpg --keyserver hkps://pgp.uni-mainz.de --send-keys 892EBC7DC392DFF9C9C03F1D15F4180E73787863
	gpg --keyserver hkp://pgp.rediris.es --send-keys 892EBC7DC392DFF9C9C03F1D15F4180E73787863
	gpg --keyserver hkps://sks.pod02.fleetstreetops.com --send-keys 892EBC7DC392DFF9C9C03F1D15F4180E73787863

.PHONY: refresh-pubkey
refresh-pubkey:
	gpg --keyserver hkps://keys.openpgp.org --refresh-keys || true
	gpg --keyserver hkps://keyserver.ubuntu.com --refresh-keys || true
	@#gpg --keyserver hkps://pgp.mit.edu --refresh-keys || true
	@#gpg --keyserver hkps://keys.gnupg.net --refresh-keys || true
	gpg --keyserver hkps://pgp.surfnet.nl --refresh-keys || true
	@#gpg --keyserver hkps://pgp.gnd.pw --refresh-keys || true
	gpg --keyserver hkps://keyring.debian.org --refresh-keys || true
	gpg --keyserver hkps://keys.gentoo.org --refresh-keys || true
	@#gpg --keyserver hkps://keys.mailvelope.com --refresh-keys || true

sign-graph.dot:
	gpg --list-sigs | sig2dot -q 2>/dev/null > sign-graph.dot
sign-graph.png: sign-graph.dot
	dot -Tpng -o sign-graph.png sign-graph.dot
sign-graph.svg: sign-graph.dot
	dot -Tsvg -o sign-graph.svg sign-graph.dot
sign-graph.round.svg: sign-graph.dot
	neato -Tsvg -Goverlap=scale -Gsplines=true -o sign-graph.round.svg sign-graph.dot

.PHONY: gen-sign-graph
gen-sign-graph: sign-graph.round.svg
.PHONY: clean-pubilc-qrcode
clean-public-qrcode:
	$(RM) public-key.*

public-key.png: clean-pubilc-qrcode
	qrencode -o public-key.png -i "OPENPGP4FPR:892EBC7DC392DFF9C9C03F1D15F4180E73787863" --size=10 --level=H --dpi=400 --type=PNG

public-key.svg: clean-pubilc-qrcode
	qrencode -o public-key.svg -i "OPENPGP4FPR:892EBC7DC392DFF9C9C03F1D15F4180E73787863" --size=10 --level=H --dpi=400 --type=SVG

.PHONY: clean-pubilc-keys
clean-public-keys:
	$(RM) public-key-*.asc
	$(RM) ssh-key.txt

public-key-auth.asc: clean-public-keys
	gpg --armor -o public-key-auth.asc --export 06F96A0FB5AD258D!
public-key-encrypt.asc: clean-public-keys
	gpg --armor -o public-key-encrypt.asc --export 7C20D9B5ED32703C!
public-key-sign.asc: clean-public-keys
	gpg --armor -o public-key-sign.asc --export E35C89E45867AE35!
public-key-master.asc: clean-public-keys
	gpg --armor -o public-key-master.asc --export 15F4180E73787863

ssh-key.txt: clean-public-keys
	gpg --export-ssh-key 06F96A0FB5AD258D > ssh-key.txt

secret-key-auth.asc:
	gpg --armor -o secret-key-auth.asc --export-secret-subkeys 06F96A0FB5AD258D!
secret-key-encrypt.asc:
	gpg --armor -o secret-key-encrypt.asc --export-secret-subkeys 7C20D9B5ED32703C!
secret-key-sign.asc:
	gpg --armor -o secret-key-sign.asc --export-secret-subkeys E35C89E45867AE35!
secret-key-master.asc:
	gpg --armor -o secret-key-master.asc --export-secret-keys 15F4180E73787863

892EBC7DC392DFF9C9C03F1D15F4180E73787863.rev:
	gpg --output 892EBC7DC392DFF9C9C03F1D15F4180E73787863.rev --gen-revoke '15F4180E73787863'

ownertrust.txt:
	gpg --export-ownertrust > ownertrust.txt

.PHONY: export export-subkeys export-master-key export-revoke export-ownertrust export-ownertrust export-pubkey export-seckey
export-subkeys: public-key-auth.asc public-key-encrypt.asc public-key-sign.asc secret-key-auth.asc secret-key-encrypt.asc secret-key-sign.asc
export-master-key: public-key-master.asc secret-key-master.asc
export-pubkey: public-key-auth.asc public-key-encrypt.asc public-key-sign.asc public-key-master.asc
export-seckey: secret-key-auth.asc secret-key-encrypt.asc secret-key-sign.asc secret-key-master.asc
export-revoke: 892EBC7DC392DFF9C9C03F1D15F4180E73787863.rev
export: export-master-key export-subkeys ssh-key.txt
export-ownertrust: ownertrust.txt
backup: export export-ownertrust export-revoke

# Clean up
.PHONY: clean-policy
clean-policy: 
	$(MAKE) -C pgp-policy clean
	$(RM) output

.PHONY: clean-graph
clean-graph:
	$(RM) sign-graph.*

.PHONY: clean-secret-keys
clean-secret-keys:
	$(RM) secret-key-*.asc
	$(RM) 892EBC7DC392DFF9C9C03F1D15F4180E73787863.rev

.PHONY: clean-ownertrust-db
clean-ownertrust-db:
	$(RM) ownertrust.txt

.PHONY: clean
clean: clean-graph clean-policy clean-secret-keys clean-ownertrust-db
