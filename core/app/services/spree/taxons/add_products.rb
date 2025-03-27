module Spree
  module Taxons
    class AddProducts
      prepend Spree::ServiceModule::Base

      # Creates classifications for the given taxons and products in bulk.
      #
      # @param taxons [Array<Spree::Taxon>]
      # @param products [Array<Spree::Product>]
      # @return [Spree::ServiceModule::Base::Result]
      def call(taxons:, products:)
        return if taxons.blank? || products.blank?

        # build the params for the insert_all
        classifications_params = taxons.pluck(:id).flat_map do |taxon_id|
          position = Spree::Classification.where(taxon_id: taxon_id).count

          products.pluck(:id).map do |product_id|
            {
              taxon_id: taxon_id,
              product_id: product_id,
              position: (position += 1),
              created_at: Time.current,
              updated_at: Time.current
            }
          end
        end
        # doing a quick insert_all here to avoid the overhead of instantiating
        Spree::Classification.insert_all(classifications_params)

        # clearing cache
        Spree::Product.where(id: products.pluck(:id)).touch_all
        Spree::Taxon.where(id: taxons.pluck(:id)).touch_all

        success(true)
      end
    end
  end
end
