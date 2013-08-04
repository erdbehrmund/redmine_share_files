require_dependency 'attachment'

module AttachmentPatch
  def included(base)
    base.class_eval do
      unloadable

    end
  end

  SHARING_STATES = {
      :disabled => 0,
      :basic => 1,
      :public => 2
  }

end

Attachment.send(:include, AttachmentPatch)
