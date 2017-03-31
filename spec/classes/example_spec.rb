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

          it { is_expected.to contain_class('apache') }
          it { is_expected.to contain_class('mysql::server') }
          it { is_expected.to contain_package('php-mssql') }

        end
      end
    end
  end
end
