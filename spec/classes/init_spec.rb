require 'spec_helper'
describe 'pe_ca_proxy' do

    context 'for compile master' do
      let(:params) {
        {
          :proxy_target   => 'gary.zack.tom.james.local',
        }
      }
      let(:facts) {
        {
          'pe_concat_basedir' => '/tmp'
        }
      }
      it { should contain_class('pe_ca_proxy') }

      it {
        should contain_puppet_enterprise__trapperkeeper__bootstrap_cfg('certificate-authority-service-reverse-proxy').with(
          'container' => 'puppetserver',
          'namespace' => 'puppetlabs.enterprise.services.reverse-proxy.reverse-proxy-ca-service',
          'service'   => 'reverse-proxy-ca-service',
        )
      }

      it {
        should contain_file('/etc/puppetlabs/puppetserver/conf.d/ca_proxy.conf').with(
          'ensure'  => 'file',
          'owner'   => 'pe-puppet',
          'group'   => 'pe-puppet',
          'mode'    => '0740',
        ).with_content(/https:\/\/gary\.zack\.tom\.james\.local/)
      }
    end

    context 'for CA master' do
      let(:params) {
        {
          :proxy_target => 'gary.zack.tom.james.local',
          :enable       => false,
        }
      }
      let(:facts) {
        {
          'pe_concat_basedir' => '/tmp'
        }
      }
      it { should contain_class('pe_ca_proxy') }

      it {
        should_not contain_puppet_enterprise__trapperkeeper__bootstrap_cfg('certificate-authority-service-reverse-proxy')
      }

      it {
        should contain_file('/etc/puppetlabs/puppetserver/conf.d/ca_proxy.conf').with(
          'ensure'  => 'absent',
        )
      }
    end

end
