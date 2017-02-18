# ovm-template-config-satellite
OVM Template config scripts to bootstrap server to Satellite.  The purpose of this is to bootstrap Oracle Enterprise Linux VMs to RedHat Satellite.

## Requirements
You must be running RedHat Satellite 6.2 in order to have the bootstrap.py available.
The Content View that you register to must have repos for the upstream subscription-manager, puppet, and katello-agent, as these are not part of the public Oracle Linux Repositories.
I have synced:
* https://yum.puppetlabs.com/el/7Server/products/x86_64/
* https://yum.puppetlabs.com/el/7Server/dependencies/x86_64/
* https://fedorapeople.org/groups/katello/releases/yum/2.2/client/RHEL/7Server/x86_64/
* https://copr-be.cloud.fedoraproject.org/results/dgoodwin/subscription-manager/epel-7-x86_64/

I have also added the bootstrap.py script from the RedHat Satellite server, /var/www/html/pub/bootstrap.py, to /root on the VM Template.
I preferred this to having to do a wget, since our minimal image does not include that package.  If in the future we need that, I may make it a dependency and add the functionality.

I also suggest removing the spacewalk packages from the VM Template.  Oracle has obsoleted the subscription-manager package in their versions. So even though, the bootstrap.py can remove them, the subscrition-manager attempts to install before this and will fail.  I removed the following packages from my VM Template:
*	rhn-check 
*	rhn-client-tools 
*	rhn-setup 
*	rhn-setup-gnome 
*	rhnlib 
* rhnsd 
*	yum-rhn-plugin 
*	yum-plugin-ulninfo

It is required to create Hostgroup, Activation Key, Content Views, etc before running this.  It is also more seemless if you create an autosign entry for the host.
