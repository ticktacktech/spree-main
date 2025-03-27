module Spree
  module PageSections
    class ImageBanner < Spree::PageSection
      TOP_PADDING_DEFAULT = 0
      BOTTOM_PADDING_DEFAULT = 0

      preference :overlay_transparency, :integer, default: 40
      preference :height, :integer, default: 384
      preference :vertical_alignment, :string, default: :middle

      def default_blocks
        [
          Spree::PageBlocks::Heading.new(
            text: Spree.t('page_sections.image_banner.heading_default'),
            preferred_text_alignment: 'center',
            preferred_container_alignment: 'center',
            preferred_width_desktop: 50
          ),
          Spree::PageBlocks::Text.new(
            text: Spree.t('page_sections.image_banner.text_default'),
            preferred_text_alignment: 'center',
            preferred_container_alignment: 'center',
            preferred_width_desktop: 50
          ),
          Spree::PageBlocks::Buttons.new
        ]
      end

      def blocks_available?
        true
      end

      def icon_name
        'slideshow'
      end
    end
  end
end
