module Resources
  module V1
    class Root < Grape::API
      version 'v1'
      format :json
      content_type :json, 'application/json'

      # app/api/resources/v1/users.rbをマウント
      mount Resources::V1::Users

      if defined? GrapeSwaggerRails
        add_swagger_documentation(
          markdown: GrapeSwagger::Markdown::RedcarpetAdapter.new(render_options: { highlighter: :rouge}),
          api_version: 'v1',
          base_path: '',
          hide_documentation_path: true,
          hide_format: true)
      end
    end
  end
end
