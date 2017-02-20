Name: ovm-template-config-satellite
Version: 0.2
Release: 1%{?dist}
Summary: Oracle VM template configuration script for bootstrapping server to RedHat Satellite.
Group: Applications/System
License: GPL
Source0: %{name}-%{version}.tar.gz
BuildRoot: %(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)
BuildArch: noarch
Requires: ovm-template-config

%description
Oracle VM template configuration script for bootstrapping server to RedHat Satellite.

%prep
%setup -q

%install
rm -rf $RPM_BUILD_ROOT
make install DESTDIR=$RPM_BUILD_ROOT

%clean
rm -rf $RPM_BUILD_ROOT

%post
if [ $1 = 1 ]; then
    /usr/sbin/ovm-chkconfig --add satellite
fi

%preun
if [ $1 = 0 ]; then
    /usr/sbin/ovm-chkconfig --del satellite
fi

%files
%defattr(-,root,root, -)
%{_sysconfdir}/template.d/scripts/satellite
%attr(700,root,root) %{_prefix}/local/sbin/bootstrap_wrapper.sh
%attr(644,root,root) %{_prefix}/lib/systemd/system/bootstrap-wrapper.service

%changelog
