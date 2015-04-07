require "spec_helper"

describe Aries::Link do

  let(:instance){ Aries::Link.new(*attrs) }

  let(:schema_path){ File.expand_path("../../fixtures/schema-heroku.json", __FILE__) }
  let(:schema_body){ File.read(schema_path) }
  let(:schema_json){ JSON.parse!(schema_body) }

  let(:link_schema){ JsonSchema.parse!(schema_json).tap(&:expand_references).properties["account-feature"].links.last  }
  let(:aries_schema){ Aries::Schema.new(schema_json) }

  let(:attrs) { [link_schema, aries_schema.resources.first] }

  describe ".new" do
    it{ expect(instance).to be_a described_class }
  end

  describe ".required_params" do
    it{ expect(instance.required_params.size).to eq 2 }
  end

  describe ".optional_params" do
    it{ expect(instance.optional_params.size).to eq 2 }
  end

  describe ".params" do
    it{ expect(instance.params.size).to eq 4 }
  end

  describe ".prop_params" do
    it{ expect(instance.prop_params.size).to eq 3 }
  end

  describe ".url_params" do
    it{ expect(instance.url_params.size).to eq 1 }
  end

  describe ".href" do
    it "should be decoded" do
      expect(instance.href).to include "/identity"
    end
  end

  describe ".pretty_href" do
    it "should be decoded" do
      expect(instance.pretty_href).to include "/{accountFeatureIdentity}"
    end
  end

  describe ".root_schema" do
    it{ expect(aries_schema.resources.first.links.first.root_schema).to eq aries_schema }
  end

end
