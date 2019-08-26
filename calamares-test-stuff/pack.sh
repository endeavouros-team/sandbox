#!/bin/bash

# Maintainers: Portergos Linux <portergoslinux@gmail.com>, EndeavourOS info@endeavouros.com
# Multipurpose installer for arch based distros


_pkgname() {
# Not working yet
    echo -e "Choose a package name\n"
    echo -e "Default calamares_current \n"
    read -t 20 pkgname
    if [ $? == 1 ]; then pkgname="calamares_current"; fi
    echo "$pkgname" >.pkgname

}

_offline_online() {
    local answer

    # install the package accordingly
    echo "Choose offline/online install:"
    echo "   1   for offline install (default)"
    echo "   2   for online install"
    read -p "Number: " answer
    if [ "$answer" != "2" ]; then answer="1"; fi
    echo "$answer"
}

_prepare() {

    local answer="$(_offline_online)"

    if [ ! -d $srcdir/$_reponame ]
    then 
        #git clone https://github.com/calamares/calamares.git
        wget https://github.com/calamares/calamares/releases/download/v$pkgver/$_reponame-$pkgver.tar.gz
        tar -zxvf $_reponame-$pkgver.tar.gz
        rm $_reponame-$pkgver.tar.gz
        mv $_reponame-$pkgver $_reponame
        rsync -va $srcdir/$_reponame_clone/* $srcdir/$_reponame
        rm -rf $srcdir/$_reponame_clone
    fi

    case $answer in
        1)
            cp -r ${srcdir}/${_reponame}/src/modules/packages/packages.conf_offline ${srcdir}/${_reponame}/src/modules/packages/packages.conf
            cp -r ${srcdir}/${_reponame}/settings.conf_offline ${srcdir}/${_reponame}/settings.conf
            cp -r ${srcdir}/${_reponame}/src/modules/welcome/welcome.conf_offline ${srcdir}/${_reponame}/src/modules/welcome/welcome.conf 
            ;;
        2)
            cp -r ${srcdir}/${_reponame}/src/modules/packages/packages.conf_online ${srcdir}/${_reponame}/src/modules/packages/packages.conf
            cp -r ${srcdir}/${_reponame}/settings.conf_online ${srcdir}/${_reponame}/settings.conf
            cp -r ${srcdir}/${_reponame}/src/modules/welcome/welcome.conf_online ${srcdir}/${_reponame}/src/modules/welcome/welcome.conf
            ;;
        *)
            ;;
    esac

    mkdir -p $srcdir/$_reponame/build/$pkgname
    #rm -r $srcdir/$_reponame/src/modules/{packagechooser}
    rm -r $srcdir/$_reponame/src/modules/{dummypythonqt,tracking,dummycpp,dummyprocess,dummypython,dummypythonqt,dracutlukscfg,plymouthcfg,dracut,initramfs,webview} ||true
    sed -i "s?configuration files\" OFF?configuration files\" ON?g" $srcdir/$_reponame/CMakeLists.txt
    sed -i "s?username: live?username: liveuser?g"  $srcdir/$_reponame/src/modules/removeuser/removeuser.conf
    sed -i 's/\"mkinitcpio\", \"-p\", m_kernel/\"mkinitcpio\", \"-P\"/' $srcdir/$_reponame/src/modules/initcpio/InitcpioJob.cpp
    sed -i "s?./example.sqfs?\"/run/archiso/bootmnt/arch/x86_64/airootfs.sfs\"?g" $srcdir/$_reponame/src/modules/unpackfs/unpackfs.conf
   
}

_build() {

    cd $srcdir/$_reponame/build
    cmake .. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_LIBDIR=/usr/lib -DCMAKE_INSTALL_PREFIX=/usr
    export DESTDIR="$srcdir/$_reponame/build/$pkgname" && make -j4 install

}

_package() {
    #cd $srcdir/$_reponame/build/$pkgname
	#not working yet
    #pgkname=""
    #cat .pkgname 2>1 $pkgname

    local destdir=/usr


    cp -r $srcdir/$_reponame/src/branding                                                      ${srcdir}/${_reponame}/build/$pkgname/usr/share/calamares/
    cp -r $srcdir/$_reponame/{settings.conf_offline,settings.conf_online}                      ${srcdir}/${_reponame}/build/$pkgname/usr/share/calamares/
    cp -r $srcdir/$_reponame/src/modules/welcome/{welcome.conf_online,welcome.conf_offline}    ${srcdir}/${_reponame}/build/$pkgname/usr/share/calamares/modules/
    cp -r $srcdir/$_reponame/src/modules/packages/{packages.conf_online,packages.conf_offline} ${srcdir}/${_reponame}/build/$pkgname/usr/share/calamares/modules/

    cp -r "${srcdir}/${_reponame}/build/$pkgname"/*    "${pkgdir}${destdir}"
}





