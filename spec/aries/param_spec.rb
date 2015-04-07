require "spec_helper"

describe Aries::Param do

  let(:instance){ Aries::Param.new(*attrs) }

  let(:schema_path){ File.expand_path("../../fixtures/schema-heroku.json", __FILE__) }
  let(:schema_body){ File.read(schema_path) }
  let(:schema_json){ JSON.parse!(schema_body) }
  let(:json_schema){ JsonSchema.parse!(schema_json).tap(&:expand_references) }
  let(:param_schema){ json_schema.properties["account-feature"].links.last.schema.properties.first }
  let(:attrs) { param_schema }

  describe ".new" do
    it{ expect(instance).to be_a described_class }
  end

  describe ".type" do
    it{ expect(instance.type).to be_a Aries::ParamType }
  end

  describe ".name" do
    it{ expect(instance.name).to eq "enabled" }
  end

  describe ".pretty_name" do
    it{ expect(instance.name).to eq "enabled" }
  end

  context "url param" do

    let(:instance){ Aries::Schema.new(schema_json).resources.first.links.first.url_params.first }

    it { expect(instance.name).to eq "identity" }
    it { expect(instance.pretty_name).to eq "account_feature_identity" }

  end

  context "tree param" do

    let(:tree_param_schema){ json_schema.properties["account-feature"].links.last.schema.properties }
    let(:attrs){ tree_param_schema.to_a.last }

    it{ expect(instance.name).to eq "app" }
    it{ expect(instance.type).to be_a Aries::ParamType }
    it{ expect(instance.type.type).to eq "object" }

    describe ".params" do
      it{ expect(instance.params.size).to eq 2 }
      it{ expect(instance.params.first.name).to eq "name" }
      it{ expect(instance.params.first.pretty_name).to eq "name" }
    end

  end


end
