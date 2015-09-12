#!/bin/bash -x
#
# Sync the generated doc tree.
# To be called like:
#   synchtml.sh html530

prog=`basename $0`
if [ $# -ne 1 ]; then
   echo "$prog: no docdir argument specified"
   exit 1
else
   docdir="$1"
fi

if [ "$docdir" = "master" ]; then
  rsync -a $docdir/ root.cern.ch:/user/httpd/root/doc/$docdir
  ret=$?
else
  rsync -a $docdir/ root.cern.ch:/user/httpd/root/root/$docdir
  ret=$?
fi

if [ $docdir != "master" -a $docdir != "html602" ]; then
   tar zcf ${docdir}.tar.gz $docdir
   scp ${docdir}.tar.gz root.cern.ch:/user/ftp/root
fi

exit $ret
