#!/bin/bash

# debian sources must be updates as root (write to /var/lib/apt/lists/ and /var/cache/apt/)

# default
PACKAGES="ansible ansible-doc"
DEPENDS=0

while getopts f:p:s:r:d flag; do
  case $flag in
    f) PACKAGES_FILE="$OPTARG";
      ;;
    p) PACKAGES="$OPTARG";
      ;;
		s) SOURCELIST="$OPTARG";
			;;
		r) REPO_DIR="$OPTARG";
			;;
		d) DEPENDS=1;
			;;
    ?)
      exit;
      ;;
  esac
done

if [ "x$PACKAGES_FILE" != "x" ] ; then
	if [ -f "${PACKAGES_FILE}" ] ; then
			PACKAGES=$(cat "${PACKAGES_FILE}")
	else
		echo "PACKAGES_FILE (-f) is not a file"
		exit
	fi

fi

CUSTOMSOURCE=""
if [ "x${SOURCELIST}" != "x" ] ; then
	CUSTOMSOURCE="-o Dir::Etc::SourceList=${SOURCELIST}"
fi

sudo apt-get update $CUSTOMSOURCE

if [ "x${REPO_DIR}" != "x" ] ; then
	if [ ! -d "${REPO_DIR}" ] ; then
		mkdir -p "${REPO_DIR}"
	fi
	cd "${REPO_DIR}"
fi

IFS=$'\n'
for pkg in ${PACKAGES} ; do
	if echo "$pkg" | grep -q "^#" ; then
		continue
	fi
  echo "downloading $pkg"
  if [ "x${SOURCELIST}" != "x" ] ; then
    apt-get download -o Dir::Etc::SourceList="${SOURCELIST}" $pkg
  else
    apt-get download $pkg
  fi


	if [ $DEPENDS -eq 1 ] ; then
	 	depends=$(apt-rdepends "$pkg" | grep -v "^ ")
	  for dep in $depends ; do
	    echo "Downloading dependencies for $pkg: $dep"
      if [ "x${SOURCELIST}" != "x" ] ; then
        apt-get download -o Dir::Etc::SourceList="${SOURCELIST}" $dep
      else
        apt-get download $dep
      fi
	  done
	fi
done


rm -rf Packages Packages.gz Release Release.gpg InRelease

apt-ftparchive --arch amd64 packages . > Packages
gzip -k -f Packages
apt-ftparchive release . > Release
gpg  -abs -o Release.gpg Release
gpg --clearsign -o InRelease Release
