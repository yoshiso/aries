require "spec_helper"

describe Aries::Presenters::LinkSwift do

  let(:instance){ Aries::Presenters::LinkSwift.new(*attrs) }

  let(:schema_path){ File.expand_path("../../../fixtures/schema-heroku.json", __FILE__) }
  let(:schema_body){ File.read(schema_path) }
  let(:schema_json){ JSON.parse!(schema_body) }
  let(:aries_schema){ Aries::Schema.new(schema_json) }
  let(:aries_link){ aries_schema.resources.first.links.first }
  let(:attrs) { aries_link  }

  describe ".new" do
    it{ expect(instance).to be_a described_class }
  end

  describe ".params" do
    it{ expect(instance.params).to be_a Array }
    it{ expect(instance.params.first).to be_a Aries::Presenters::ParamSwift }
  end

  describe ".method_name" do
    it{ expect(instance.method_name).to eq "Info" }
  end

  describe ".params_for_method" do
    it{ expect(instance.params_for_method).to eq "accountFeatureIdentity: Any" }
  end

  describe ".params_keys" do
    it{ expect(instance.params_keys).to eq "accountFeatureIdentity"  }
  end

end
