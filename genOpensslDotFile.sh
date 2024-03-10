openssl enc -e -a -aes-128-cbc -p -iv ${OPENSSL_KEY} -K ${OPENSSL_KEY} -in ${tf::=~/.zshrc} -out ${$(gopass config stores.path)//\~/$HOME}/dotfile/$(basename $tf).openssl
openssl enc -e -a -aes-128-cbc -p -iv ${OPENSSL_KEY} -K ${OPENSSL_KEY} -in ${tf::=~/.taskrc} -out ${$(gopass config stores.path)//\~/$HOME}/dotfile/$(basename $tf).openssl
openssl enc -e -a -aes-128-cbc -p -iv ${OPENSSL_KEY} -K ${OPENSSL_KEY} -in ${tf::=~/.zshenv} -out ${$(gopass config stores.path)//\~/$HOME}/dotfile/$(basename $tf).openssl
openssl enc -e -a -aes-128-cbc -p -iv ${OPENSSL_KEY} -K ${OPENSSL_KEY} -in ${tf::=~/.zprofile} -out ${$(gopass config stores.path)//\~/$HOME}/dotfile/$(basename $tf).openssl
openssl enc -e -a -aes-128-cbc -p -iv ${OPENSSL_KEY} -K ${OPENSSL_KEY} -in ${tf::=~/.myclirc} -out ${$(gopass config stores.path)//\~/$HOME}/dotfile/$(basename $tf).openssl
openssl enc -e -a -aes-128-cbc -p -iv ${OPENSSL_KEY} -K ${OPENSSL_KEY} -in ${tf::=~/.gitconfig} -out ${$(gopass config stores.path)//\~/$HOME}/dotfile/$(basename $tf).openssl
