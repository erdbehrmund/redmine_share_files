class ShareFilesController < ApplicationController
  before_filter :find_project_by_project_id

  skip_before_filter :check_if_login_required, [:download]
  skip_before_filter :user_setup, [:download]
  skip_before_filter :find_project_by_project_id, [:download]

  def edit
    @attachment = Attachment.find params[:attachment_id]

  end

  def update
    @attachment = Attachment.find params[:attachment_id]
    @attachment.sharing_state = params[:attachment][:sharing_state]
    @attachment.save

    redirect_to project_files_path @attachment.container
  end

  def download
    attachment = Attachment.find_by_digest params[:digest]

    if attachment.nil?
      render_404
    elsif attachment.sharing_state == Attachment::SHARING_STATES[:basic]
      @user = nil
      auth = authenticate_or_request_with_http_basic do |username, pass|
        @user = User.find_by_login username
        @user && @user.check_password?(pass)
      end

      if auth == true && attachment.visible?(@user)
        send_file attachment.diskfile, :filename => filename_for_content_disposition(attachment.filename),
                :type => detect_content_type(attachment),
                :disposition => 'attachment'
      end

    elsif attachment.sharing_state == Attachment::SHARING_STATES[:public]
      send_file attachment.diskfile, :filename => filename_for_content_disposition(attachment.filename),
                :type => detect_content_type(attachment),
                :disposition => 'attachment'
    else
      render_404
    end
  end

  private
    def detect_content_type(attachment)
      content_type = attachment.content_type
      if content_type.blank?
        content_type = Redmine::MimeType.of(attachment.filename)
      end
      content_type.to_s
    end

end