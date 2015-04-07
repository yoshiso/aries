require 'spec_helper'

describe Aries::Generator do

  let(:instance){ Aries::Generator.new(*attrs) }

  let(:schema_path){ File.expand_path("../../fixtures/schema-heroku.json", __FILE__) }
  let(:output_path){ File.expand_path("../../../tmp", __FILE__) }
  let(:output_file_path){ output_path + "/AriesApi.swift" }
  let(:attrs) { [schema_path, {output_path: output_path} ] }

  describe ".new" do
    it{ expect(instance).to be_a described_class }
  end

  describe ".exec" do
    before{ FileUtils.rm output_file_path if File.exist? output_file_path }
    after{ FileUtils.rm output_file_path }
    it { expect(instance.exec).to eq true }
    it "generated api file" do
      expect(File.exist? output_file_path).to eq false
      instance.exec
      expect(File.exist? output_file_path).to eq true
    end
  end



end
