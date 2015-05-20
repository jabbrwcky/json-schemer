require "json_schemer/version"

module JsonSchemer
  SchemaBase = {"$schema" => 'http://json-schema.org/schema#'}

  module Types
    String   = { type: 'string' }
    Integer  = { type: 'integer' }
    Boolean  = { type: 'boolean' }
    Numeric  = { type: 'numeric' }
    Object   = { type: 'object' }
    Array    = { type: 'array' }

    Datetime = String.merge(format: 'date-time')
  end

  AttributeMap = {
    Axiom::Types::String => Types::String,
    Axiom::Types::Class => Types::String,
    Axiom::Types::Type => Types::String,
    Axiom::Types::Symbol => Types::String,
    Axiom::Types::DateTime => Types::Datetime,
    Axiom::Types::Date => Types::Datetime,
    Axiom::Types::Time => Types::Datetime,
    Axiom::Types::Boolean => Types::Boolean,
    Axiom::Types::Integer => Types::Integer,
    Axiom::Types::Numeric => Types::Numeric,
    Axiom::Types::Infinity => Types::Numeric,
    Axiom::Types::Decimal => Types::Numeric,
    Axiom::Types::Float => Types::Numeric,
    Axiom::Types::NegativeInfinity => Types::Numeric,
    Axiom::Types::Object => Types::Object
  }

  def self.schema(
    schema: 'application_schema',
    element_definitions: {},
    protocol: 'http',
    host: 'localhost',
    path:'/schemas/')
    JsonSchemer::SchemaBase.merge({
      id: "#{protocol}://#{host}#{path}#{schema}.json",
      title: "application_schema",
      definitions: element_definitions
    })
  end

  def self.ref(model)
    { '$ref' => "#/definitions/#{model.definition_name}" }
  end

end
