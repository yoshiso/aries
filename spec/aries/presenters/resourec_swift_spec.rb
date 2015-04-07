require "spec_helper"

describe Aries::Presenters::ResourceSwift do

  let(:instance){ Aries::Presenters::ResourceSwift.new(*attrs) }

  let(:schema_path){ File.expand_path("../../../fixtures/schema-heroku.json", __FILE__) }
  let(:schema_body){ File.read(schema_path) }
  let(:schema_json){ JSON.parse!(schema_body) }
  let(:aries_schema){ Aries::Schema.new(schema_json) }
  let(:aries_resource){ aries_schema.resources.first }
  let(:attrs) { aries_resource  }

  describe ".new" do
    it{ expect(instance).to be_a described_class }
  end

  describe ".name" do
    it{ expect(instance.name).to eq "AccountFeature" }
  end

  describe ".resources" do
    it{ expect(instance.links).to be_a Array }
    it{ expect(instance.links.first).to be_a Aries::Presenters::LinkSwift }
  end

end
