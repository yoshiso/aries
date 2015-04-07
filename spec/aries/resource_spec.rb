require 'spec_helper'

describe Aries::Resource do

  let(:instance){ Aries::Resource.new(*attrs) }

  let(:schema_path){ File.expand_path("../../fixtures/schema-heroku.json", __FILE__) }
  let(:schema_body){ File.read(schema_path) }
  let(:schema_json){ JSON.parse!(schema_body) }
  let(:resource_schema){ JsonSchema.parse!(schema_json).tap(&:expand_references).properties.first  }
  let(:attrs) { resource_schema }

  describe ".new" do
    it{ expect(instance).to be_a described_class }
  end

  describe ".name" do
    it{ expect(instance.name).to eq "account_feature" }
  end

  describe ".links" do
    it{ expect(instance.links.size).to eq 3 }
  end

end
