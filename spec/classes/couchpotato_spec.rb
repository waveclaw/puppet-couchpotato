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
        it { is_expected.to contain_class('couchpotato::users').that_comes_before('couchpotato::repo') }
        it { is_expected.to contain_class('couchpotato::repo').that_comes_before('couchpotato::install') }
        it { is_expected.to contain_class('couchpotato::install').that_comes_before('couchpotato::sysconfig') }
        it { is_expected.to contain_class('couchpotato::sysconfig').that_comes_before('couchpotato::config') }
        it { is_expected.to contain_class('couchpotato::config') }
        it { is_expected.to contain_class('couchpotato::service').that_subscribes_to('couchpotato::config') }
        it { is_expected.to contain_file('/var/lib/couchpotato/settings.conf') }
        it { is_expected.to contain_file('/var/lib/couchpotato/Downloads') }
        it { is_expected.to contain_file('/var/lib/couchpotato/Movies') }
        it { is_expected.to contain_file('/var/lib/couchpotato') }

        it { is_expected.to contain_user('couchpotato') }
        it { is_expected.to contain_group('couchpotato') }
        it { is_expected.to contain_service('couchpotato') }
        it { is_expected.to contain_package('couchpotato').with_ensure('present') }
        if osfamily == 'RedHat'
          it { is_expected.to contain_file('/etc/sysconfig') }
          it { is_expected.to contain_file('/etc/sysconfig/couchpotato') }
          it { is_expected.to contain_yumrepo('http__nuxref.com_repo') }
          it { is_expected.to contain_couchpotato__repo__yum('http://nuxref.com/repo') }
        end
        if osfamily == 'Suse'
          it { is_expected.to contain_file('/etc/sysconfig') }
          it { is_expected.to contain_file('/etc/sysconfig/couchpotato') }
          it { is_expected.to contain_couchpotato__repo__zyp('http://download.opensuse.org/repositories/home:/waveclaw:/HTPC/SLE_12') }
          it { is_expected.to contain_zypprepo('http__download.opensuse.org_repositories_home_waveclaw_HTPC_SLE_12') }
        end
        if osfamily == 'Debian'
          it { is_expected.to contain_file('/etc/defaults') }
          it { is_expected.to contain_file('/etc/defaults/couchpotato') }
        end
      end
    describe "with selected parameters on #{osfamily}" do
        let(:params) {{ 
  :user_name           => 'loveseat',
  :user_home           => '/divan',
  :group_name          => 'couch',
  :repo_name           => 'http://nobody.com',
  :package_name        => 'tater',
  :service_name        => 'couch-tater',
  :config_file_path    => '/baz/config',
  :sysconfig_file_path => '/camera',
  :sysconfig_file_name => 'couchpotato',
  :data_path           => '/bar/data',
  :pidfile             => '/foo/pid',
  :servers             => {},
  :apikey              => '123456',
  :webuser             => 'nobody',
  :webpass             => '12345',
  :library             => '/baz',
  :target_path         => '/bar',
  :source_path         => '/foo',
  :servers             => {},
  :nzb                 => {},
  :torrent             => {},
  :automation          => {},
  :notification        => {},
        }}
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
        it { is_expected.to contain_class('couchpotato::users').that_comes_before('couchpotato::repo') }
        it { is_expected.to contain_class('couchpotato::repo').that_comes_before('couchpotato::install') }
        it { is_expected.to contain_class('couchpotato::install').that_comes_before('couchpotato::sysconfig') }
        it { is_expected.to contain_class('couchpotato::sysconfig').that_comes_before('couchpotato::config') }
        it { is_expected.to contain_class('couchpotato::config') }
        it { is_expected.to contain_class('couchpotato::service').that_subscribes_to('couchpotato::config') }
        it { is_expected.to contain_file('/var/lib/couchpotato/settings.conf') }

          it { is_expected.to contain_file('/bar/data') }
          it { is_expected.to contain_file('/bar') }
          it { is_expected.to contain_file('/camera/couchpotato') }
          it { is_expected.to contain_file('/camera') }
          it { is_expected.to contain_file('/foo') }
          it { is_expected.to contain_group('couch') }
          it { is_expected.to contain_package('tater') }
          it { is_expected.to contain_service('couch-tater') }
          it { is_expected.to contain_user('loveseat') }

        if osfamily == 'RedHat'
          it { is_expected.to contain_yumrepo('http__nobody.com') }
          it { is_expected.to contain_couchpotato__Repo__Yum('http://nobody.com') }
        end
        if osfamily == 'Suse'
          it { is_expected.to contain_zypprepo('http__nobody.com') }
          it { is_expected.to contain_couchpotato__Repo__Zyp('http://nobody.com') }
        end
        if osfamily == 'Debian'
# nothing unique, yet
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
