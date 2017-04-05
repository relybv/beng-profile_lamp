require 'spec_helper'

describe 'profile_lamp' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge({
            :concat_basedir => "/foo"
          })
        end

        context "profile_lamp class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('profile_lamp') }

          it { is_expected.to contain_class('profile_lamp::params') }
          it { is_expected.to contain_class('profile_lamp::install') }
          it { is_expected.to contain_class('profile_lamp::config') }
          it { is_expected.to contain_class('profile_lamp::service') }
          it { is_expected.to contain_class('profile_lamp::prev4') }
          it { is_expected.to contain_class('profile_lamp::postv4') }

          it { is_expected.to contain_class('epel') }
          it { is_expected.to contain_class('apache') }
          it { is_expected.to contain_class('mysql::server') }
          it { is_expected.to contain_package('php-mssql') }


          it { is_expected.to contain_firewall('000 accept all icmp') }
          it { is_expected.to contain_firewall('001 accept all to lo interface') }
          it { is_expected.to contain_firewall('002 accept related established rules') }
          it { is_expected.to contain_firewall('003 allow ssh access') }

          it { is_expected.to contain_firewall('100 allow http and https access') }

          it { is_expected.to contain_firewall('900 log all drop connections') }
          it { is_expected.to contain_firewall('950 drop udp') }
          it { is_expected.to contain_firewall('951 drop tcp') }
          it { is_expected.to contain_firewall('952 drop icmp') }
          it { is_expected.to contain_firewall('999 drop everything else - this is the failsafe rule') }

        end
      end
    end
  end
end
