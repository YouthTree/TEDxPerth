if ActionView::Helpers::AssetTagHelper.const_defined?(:JAVASCRIPT_DEFAULT_SOURCES)
	ActionView::Helpers::AssetTagHelper.send(:remove_const, "JAVASCRIPT_DEFAULT_SOURCES")
end
ActionView::Helpers::AssetTagHelper::JAVASCRIPT_DEFAULT_SOURCES = ['vendor/jquery', 'vendor/rails']
ActionView::Helpers::AssetTagHelper::reset_javascript_include_default