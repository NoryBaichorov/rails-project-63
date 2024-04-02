# frozen_string_literal: true

module HexletCode
  class Form
    attr_accessor :struct, :action, :method
    attr_reader :form_body

    def initialize(struct, **options)
      @struct = struct
      @action = options[:url] || '#'
      @method = options[:method] || 'post'

      @form_body = {
        inputs: [],
        submit: {},
        form_options: { action:, method: }.merge(options.except(:url, :method))
      }
    end

    def input(field_name, options = {})
      field_type = options.fetch(:as, '').to_s
      new_options = options.except(:as)

      value = @struct.public_send(field_name)
      new_options[:name] = field_name

      @form_body[:inputs] << build_attributes(new_options, field_type, value)
    end

    def submit(value = 'Save', options = {})
      new_options = { type: 'submit', value: }

      all_options = options.merge(new_options)

      @form_body[:submit] = { options: all_options }
    end

    def build_attributes(options, field_type, value)
      { options:, field_type:, value: }
    end
  end
end
