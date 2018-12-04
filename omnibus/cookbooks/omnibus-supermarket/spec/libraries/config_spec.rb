require_relative '../../libraries/config'

describe Supermarket::Config do
  describe 'environment_variables_from' do
    it 'creates environment varibles from attributes' do
      expect(described_class.environment_variables_from(
        'test1' => 123,
        'test2' => 'abc',
        'test3' => {},
        'test4' => [],
        'test5' => 'def',
        'test6' => true,
        'test7' => false,
        'test8' => nil
      )).to eq(<<EOF
export TEST1="123"
export TEST2="abc"
export TEST5="def"
export TEST6="true"
export TEST7="false"
EOF
)
    end
  end

  describe '#audit_config' do
    let(:all_required_settings) do
      {
        's3_bucket' => 'bettergetabucket',
        's3_access_key_id' => 'thisismyidtherearemanylikeitbutthisoneismine',
        's3_secret_access_key' => 'superdupersecret',
        's3_region' => 'over-yonder-1'
      }
    end
    it 'passes if all required S3 config values are present' do
      expect { described_class.audit_config(all_required_settings) }
        .not_to raise_error
    end

    it 'fails the chef run if S3 config is incomplete' do
      incomplete_s3_config = { 's3_bucket' => 'bettergetabucket' }
      expect { described_class.audit_config(incomplete_s3_config) }
        .to raise_error(Supermarket::Config::IncompleteConfig)
    end

    context 'with compatible S3 bucket configurations' do
      [
        ['no-dot-in-bucket-name', 'us-east-1', ':s3_domain_url'],
        ['no-dot-in-bucket-name', 'us-east-1', ':s3_path_url'],
        ['no-dot-in-bucket-name', 'not-nova-1', ':s3_domain_url'],
        ['no-dot-in-bucket-name', 'not-nova-1', ':s3_path_url'],
        ['bucket.name.has.dots', 'us-east-1', ':s3_path_url']
      ].each do |s3_bucket, s3_region, s3_domain_style|
        it "passes with #{s3_bucket}, #{s3_region}, and #{s3_domain_style}" do
          ok_config = all_required_settings.merge({
            's3_bucket' => s3_bucket,
            's3_region' => s3_region,
            's3_domain_style' => s3_domain_style
          })
          expect { described_class.audit_config(ok_config) }
            .not_to raise_error
        end
      end
    end

    context 'with incompatible S3 bucket configurations' do
      [
        ['bucket.name.has.dots', 'us-east-1', ':s3_domain_url'],
        ['bucket.name.has.dots', 'not-nova-1', ':s3_domain_url'],
        ['bucket.name.has.dots', 'not-nova-1', ':s3_path_url']
      ].each do |s3_bucket, s3_region, s3_domain_style|
        it "fails the chef run with #{s3_bucket}, #{s3_region}, and #{s3_domain_style}" do
          incompatible_config = all_required_settings.merge({
            's3_bucket' => s3_bucket,
            's3_region' => s3_region,
            's3_domain_style' => s3_domain_style
          })
          expect { described_class.audit_config(incompatible_config) }
            .to raise_error(Supermarket::Config::IncompatibleConfig)
        end
      end
    end
  end
end
