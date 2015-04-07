require "spec_helper"

describe Aries::Presenters::ParamSwift do

  let(:instance){ Aries::Presenters::ParamSwift.new(*attrs) }

  let(:schema_path){ File.expand_path("../../../fixtures/schema-heroku.json", __FILE__) }
  let(:schema_body){ File.read(schema_path) }
  let(:schema_json){ JSON.parse!(schema_body) }
  let(:aries_schema){ Aries::Schema.new(schema_json) }
  let(:aries_param){ aries_schema.resources.first.links.first.params.first }
  let(:attrs) { aries_param  }

  describe ".new" do
    it{ expect(instance).to be_a described_class }
  end

  describe ".name" do
    it{ expect(instance.name).to eq "accountFeatureIdentity"  }
  end

  describe ".types" do
    it{ expect(instance.type).to be_a Aries::Presenters::ParamTypeSwift }
  end

  context "url param" do

    let(:attrs){ Aries::Schema.new(schema_json).resources.first.links.first.url_params.first }

    it { expect(instance.name).to eq "accountFeatureIdentity" }

  end

  context "tree param" do

    let(:tree_param){ aries_schema.resources.first.links.last.params[2] }
    let(:attrs){ tree_param }

    it{ expect(instance.name).to eq "app" }

    describe ".params" do
      it{ expect(instance.params.size).to eq 2 }
      it{ expect(instance.params.first.name).to eq "name" }
    end

  end


end
