# -*- encoding: utf-8 -*-
require 'spec_helper'
require 'json_schemer'

class DummyModel
  include Virtus.model
  include JsonSchemer::Virtus
end

describe 'JsonSchemer', focus:true do

  describe '#schema' do
    it 'should return default values' do
      expect(JsonSchemer.schema).to eq(
      JsonSchemer::SchemaBase.merge(
        id: "http://localhost/schemas/application_schema.json",
        title: "application_schema",
        definitions: {}
      ))
    end

    it 'should return model defintions values' do
      expect(JsonSchemer.schema(element_definitions: DummyModel.schema_definition_block)).to eq(
      JsonSchemer::SchemaBase.merge(
        id: "http://localhost/schemas/application_schema.json",
        title: "application_schema",
        definitions: {
          dummy_model: DummyModel.to_schema
        }))

    end
  end

  it '#ref should return reference hash for model' do
    expect(JsonSchemer.ref(DummyModel)).to eq(
      { '$ref' => "#/definitions/dummy_model"}
    )
  end

end
