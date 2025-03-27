module Spree
  module Api
    module V2
      module Platform
        class TaxonSerializer < BaseSerializer
          include ResourceSerializerConcern

          attributes :pretty_name, :seo_title

          attribute :description do |taxon|
            taxon.description.to_plain_text
          end

          attribute :header_url do |taxon|
            taxon.image.attachment&.url
          end

          attribute :is_root do |taxon|
            taxon.root?
          end

          attribute :is_child do |taxon|
            taxon.child?
          end

          attribute :is_leaf do |taxon|
            taxon.leaf?
          end

          belongs_to :parent,   record_type: :taxon, serializer: :taxon
          belongs_to :taxonomy, record_type: :taxonomy

          has_many   :children, record_type: :taxon, serializer: :taxon
          has_many   :products, record_type: :product,
                                if: proc { |_taxon, params| params && params[:include_products] == true }

          has_one    :image,
                     object_method_name: :icon,
                     id_method_name: :icon_id,
                     record_type: :taxon_image,
                     serializer: :taxon_image
        end
      end
    end
  end
end
