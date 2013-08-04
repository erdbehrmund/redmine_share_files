require_dependency 'attachment_patch'

Redmine::Plugin.register :redmine_share_files do
  name 'Share Files plugin'
  author 'Sergey Sytchewoj'
  description 'This plugin allows you to make project files publicly available'
  version '0.0.2'
  url 'https://github.com/erdbehrmund/redmine_share_files'
  author_url 'https://github.com/erdbehrmund'
end
