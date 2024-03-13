files=(
	~/.zshrc
	~/.taskrc
	~/.zshenv
	~/.zprofile
	~/.myclirc
	~/.gitconfig
)
if [[ $1 == "de" ]]; then
	for f in $files; do
		openssl enc -d -a -aes-128-cbc -p -iv ${OPENSSL_KEY} -K ${OPENSSL_KEY} -in ${GOPASS_STORES}/dotfile/$(basename $f).openssl -out ${f}.bb
	done
else
	for f in $files; do
		echo $f
		openssl enc -e -a -aes-128-cbc -p -iv ${OPENSSL_KEY} -K ${OPENSSL_KEY} -in ${f} -out ${GOPASS_STORES}/dotfile/$(basename $f).openssl
	done
fi
