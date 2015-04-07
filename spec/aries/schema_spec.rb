require "spec_helper"

describe Aries::Schema do

  let(:instance){ Aries::Schema.new(attrs) }

  let(:schema_path){ File.expand_path("../../fixtures/schema-heroku.json", __FILE__) }
  let(:schema_body){ File.read(schema_path) }
  let(:schema_json){ JSON.parse!(schema_body) }
  let(:attrs) { schema_json  }

  describe ".new" do
    it { expect(instance).to be_a described_class  }
  end

  describe ".root_link" do
    it { expect(instance.root_link.href).to eq "https://api.heroku.com" }
  end

  describe ".base_url" do
    it { expect(instance.base_url).to eq "https://api.heroku.com" }
  end

  describe ".resources" do
    it { expect(instance.resources.size).to eq 1 }
  end

  describe ".property_by" do
    it { expect(instance.property_by("#/definitions/account-feature/definitions/identity")).to be_a JsonSchema::Schema }
  end

end
