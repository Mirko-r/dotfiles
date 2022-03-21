echo -e "\nUpdating the ebuilds on the machine\n"

emaint sync -a

echo -e "\nUpdating eix and mlocate databases\n"

eix-update && updatedb

echo -e "\nPerformin a dry run for the upgrade of any packages in the World file that have new versions\n"

emerge -uvpDN --with-bdeps=y @world

echo -e "\nLaunching the upgrade of those packages in the World file that have new versions\n"

emerge -uvDN --with-bdeps=y --keep-going @world

echo -e "\nUpgrading any packages that are still built against old versions of libraries\n"

emerge @preserved-rebuild

echo -e "\nScanning libraries and binaries for missing shared library dependencies and re-merge any broken binaries and shared libraries\n"

revdep-rebuild -i

echo -e "\nRemoving outdated and unneeded packages\n"

emerge --ask --depclean

echo -e "\nMerging any configuration files\n"
etc-update

echo -e "\nUpdating mlocate index filei\n"
updatedb

echo -e "\nChecking if there are any installed obsolete packages and then remove them\n"
eix-test-obsolete

echo -e "\nmaking sure no temporary work files have been left around by any failed merges\n"
rm -rf /usr/tmp/portage/*

