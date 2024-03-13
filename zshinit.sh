alias sss='ip=$(curl -s https://raw.githubusercontent.com/DC-Melo/dynamic/main/ifconfig.me.imac | openssl aes-256-cbc -d -a -K ${OPENSSL_KEY} -iv ${OPENSSL_KEY}) && ssh dc@"$ip"'

curl https://raw.githubusercontent.com/DCDC-Melo/log/main/natapp.ip
curl https://raw.githubusercontent.com/DCDC-Melo/home/main/.zshinit
curl https://raw.githubusercontent.com/DCDC-Melo/home/main/.zshins
curl https://raw.githubusercontent.com/DCDC-Melo/home/main/.zshenv
curl https://raw.githubusercontent.com/DCDC-Melo/home/main/.zshrc
curl https://raw.githubusercontent.com/DCDC-Melo/home/main/.zshhw

# config and download key
chsh -s /bin/zsh
sudo mkdir -p /opt/4T && sudo chown -R $(whoami) $_ ;
git clone git@github.com:DCDC-Melo/home.git . ${cm#get home local}

# import private key
curl https://raw.githubusercontent.com/DCDC-Melo/home/main/.dc.gpg.private.key | tee ${tmpFile::=$(mktemp)} ; gpg --import $tmpFile ;
# curl https://raw.githubusercontent.com/DCDC-Melo/home/main/.dc.private.key.gpg | tee ${tmpFile::=$(mktemp)} ; gpg --import $tmpFile ;
# curl https://raw.githubusercontent.com/DCDC-Melo/home/main/.dc.public.key.gpg  | tee ${tmpFile::=$(mktemp)} ; gpg --import $tmpFile ;
# gpg --import private.key
# gpg --pinentry-mode loopback --import private.key ;
# export key
gpg --export-secret-keys --armor ${GPGRECIPIENT} > .dc.gpg.private.key
gpg -–export --armor ${GPGRECIPIENT} > .dc.gpg.public.key
# start gpg
systemctl --user status gpg-agent ; gpgconf --kill gpg-agent ; systemctl --user stop gpg-agent ; systemctl --user start gpg-agent ;
gpg --list-keys ; gpg --list-secret-keys ; gpg --list-public-keys ;
gpg --edit-key ${GPGRECIPIENT}
# encrypt
gpg --recipient ${GPGRECIPIENT} --armor --output ${tmpFile::=~/.zshenv.sh}.gpg  --encrypt ${tmpFile} ;
gpg --recipient ${GPGRECIPIENT} --armor --output ${tmpFile::=~/.zshfun.sh}.gpg  --encrypt ${tmpFile} ;
gpg --recipient ${GPGRECIPIENT} --armor --output ${tmpFile::=~/.zshsc.sh}.gpg  --encrypt ${tmpFile} ;
gpg --recipient ${GPGRECIPIENT} --armor --output ${tmpFile::=~/.zshhi.sh}.gpg  --encrypt ${tmpFile} ;
gpg --recipient ${GPGRECIPIENT} --armor --output ${tmpFile::=~/.zshhm.sh}.gpg  --encrypt ${tmpFile} ;
# decrypt
gpg --output ${tmpFile::=.zshenv}  --decrypt ${tmpFile}.gpg ;
gpg --output ${rmFile::=$(mktemp)} --decrypt ${tmpFile::=.zshenv}.gpg ; source ${rmFile} ; rm -i $rmFile


# env
function isgo { if [[ "$#" -gt "0" ]]; then export declare allPara="$@" ; export declare lastPara="$@[-1]" ; echo 'isgo: \033[0;32m'"${allPara}"'\033[0m' ; fi ; unset skipCommand ; vared -p 'Is go on ?: ' -c skipCommand ; export declare skipCommand ; }

isgo zshinit        ; curl https://raw.githubusercontent.com/DCDC-Melo/home/main/.zshinit       | tee ${tmpFile::=$(mktemp)} ; source $tmpFile ; rm -i $tmpFile ; mv -i $tmpFile $HOME/.zshinit ;
isgo zshins         ; curl https://raw.githubusercontent.com/DCDC-Melo/home/main/.zshins        | tee ${tmpFile::=$(mktemp)} ; source $tmpFile ; rm -i $tmpFile ; mv -i $tmpFile $HOME/.zshins ;

isgo zshenv         ; curl https://raw.githubusercontent.com/DCDC-Melo/home/main/.zshenv        | tee ${tmpFile::=$(mktemp)} ; source $tmpFile ; rm -i $tmpFile ; mv -i $tmpFile $HOME/.zshenv ;
isgo zshenv.sh      ; curl https://raw.githubusercontent.com/DCDC-Melo/home/main/.zshenv.sh.gpg | tee ${gpgFile::=$(mktemp)} ; gpg --output ${rmFile::=$(mktemp)} --decrypt ${gpgFile} ;  source $rmFile ; rm -i $rmFile ; mv -i $rmFile $HOME/.zshenv.sh ;
# function
isgo zshrc          ; curl https://raw.githubusercontent.com/DCDC-Melo/home/main/.zshrc         | tee ${tmpFile::=$(mktemp)} ; source $tmpFile ; rm -i $tmpFile ; mv -i $tmpFile $HOME/.zshrc ;
isgo zshfun.sh      ; curl https://raw.githubusercontent.com/DCDC-Melo/home/main/.zshfun.sh.gpg | tee ${gpgFile::=$(mktemp)} ; gpg --output ${rmFile::=$(mktemp)} --decrypt ${gpgFile} ;  source $rmFile ; rm -i $rmFile ; mv -i $rmFile $HOME/.zshfun.sh ;
isgo zshsc.sh       ; curl https://raw.githubusercontent.com/DCDC-Melo/home/main/.zshsc.sh.gpg  | tee ${gpgFile::=$(mktemp)} ; gpg --output ${rmFile::=$(mktemp)} --decrypt ${gpgFile} ;  source $rmFile ; rm -i $rmFile ; mv -i $rmFile $HOME/.zshsc.sh ;
# command history
isgo zshhw          ; curl https://raw.githubusercontent.com/DCDC-Melo/home/main/.zshhw         | tee ${tmpFile::=$(mktemp)} ; source $tmpFile ; rm -i $tmpFile ; mv -i $tmpFile $HOME/.zshhw ;
isgo fc -R zshhi.sh ; curl https://raw.githubusercontent.com/DCDC-Melo/home/main/.zshhi.sh.gpg  | tee ${gpgFile::=$(mktemp)} ; gpg --output ${rmFile::=$(mktemp)} --decrypt ${gpgFile} ;  fc -R $rmFile  ; rm -i $rmFile ; mv -i $rmFile $HOME/.zshhi.sh ;
isgo fc -R zshhm.sh ; curl https://raw.githubusercontent.com/DCDC-Melo/home/main/.zshhm.sh.gpg  | tee ${gpgFile::=$(mktemp)} ; gpg --output ${rmFile::=$(mktemp)} --decrypt ${gpgFile} ;  fc -R $rmFile  ; rm -i $rmFile ; mv -i $rmFile $HOME/.zshhm.sh ;


# initialise a standalone store in some throwaway directory
mkdir $HOME/.gopass_store && gopass init --path $HOME/.gopass_store && cd $_
# initialise a git repository, add remote origin and push
git init && git add --all && git commit -m "store creation"
git remote add origin git@github.com:name/repo.git && git push -u origin master
# clone the store from the git repository as a mount
gopass clone git@github.com:name/repo.git store-name
# if successful, find the mounted store, add a secret & list your secrets
gopass mounts
echo "secret-value" | gopass insert store-name/first-secret
gopass list store-name


ssh dc@server.natappfree.cc -p 42818 'ls -alh /opt/4T'
ssh-copy-id -i ~/.ssh/bb_id_rsa.pub dc@192.168.10.68

