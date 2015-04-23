class DownloadListener < Redmine::Hook::ViewListener
  def view_issues_sidebar_issues_bottom(context)
    project = context[:project]
    return '' unless User.current.allowed_to?(:download_issues, project, :global => true)
    context[:controller].send(:render_to_string, {
      :partial => 'hooks/download_csv/view_issues_sidebar_issues_bottom',
      :locals => {:project => project}})
  end
end
