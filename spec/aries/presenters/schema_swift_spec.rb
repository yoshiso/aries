require "spec_helper"

describe Aries::Presenters::SchemaSwift do

  let(:instance){ Aries::Presenters::SchemaSwift.new(*attrs) }

  let(:schema_path){ File.expand_path("../../../fixtures/schema-heroku.json", __FILE__) }
  let(:schema_body){ File.read(schema_path) }
  let(:schema_json){ JSON.parse!(schema_body) }
  let(:aries_schema){ Aries::Schema.new(schema_json) }
  let(:attrs) { aries_schema  }

  describe ".new" do
    it{ expect(instance).to be_a described_class }
  end

  describe ".resources" do
    it{ expect(instance.resources).to be_a Array }
    it{ expect(instance.resources.first).to be_a Aries::Presenters::ResourceSwift }
  end

end
