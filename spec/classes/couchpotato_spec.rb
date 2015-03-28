require 'spec_helper'
lsbdist = {:RedHat => 'CentOS', :Suse => 'openSUSE project' }
lcd = {:Debian => 'precise', :RedHat => 'Final', :Suse => 'Harlequin' }

describe 'couchpotato' do
  context 'supported operating systems' do
    ['RedHat', 'Suse'].each do |osfamily|
      describe "without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
          :lsbdistid => lsbdist[osfamily.to_sym],
          :lsbdistcodename => lcd[osfamily.to_sym],
          :os_maj_version => 6,
          :architecture => 'x68_64'
        }}

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('couchpotato') }
        it { is_expected.to contain_class('couchpotato::defaults') }
        it { is_expected.to contain_class('couchpotato::repo').that_comes_before('couchpotato::install') }
        it { is_expected.to contain_class('couchpotato::install').that_comes_before('couchpotato::config') }
        it { is_expected.to contain_class('couchpotato::config') }
        it { is_expected.to contain_class('couchpotato::service').that_subscribes_to('couchpotato::config') }
        it { is_expected.to contain_file('/var/lib/couchpotato/settings.conf') }
        it { is_expected.to contain_file('/var/lib/couchpotato') }

        it { is_expected.to contain_service('couchpotato') }
        it { is_expected.to contain_file('/etc/sysconfig/couchpotato') }
        it { is_expected.to contain_package('couchpotato').with_ensure('present') }
        if osfamily == 'RedHat'
          it { is_expected.to contain_yumrepo('http__nuxref.com_repo') }
          it { is_expected.to contain_couchpotato__repo__yum('http://nuxref.com/repo') }
        end
        if osfamily == 'Suse'
          it { is_expected.to contain_couchpotato__repo__zyp('http://download.opensuse.org/repositories/home:/waveclaw:/HTPC/SLE_12') }
          it { is_expected.to contain_zypprepo('http__download.opensuse.org_repositories_home_waveclaw_HTPC_SLE_12') }
        end
     end
    end
  end
  
  context 'unsupported operating system' do
    describe 'couchpotato class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { is_expected.to contain_package('couchpotato') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
