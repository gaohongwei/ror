https://activeadmin.info/8-custom-actions.html#rendering
# csv will be in different section

  # Add download action
  action_item :download, only: :show do
    link_to('Download', download_ml_predict_path(resource))
  end

  member_action :download, method: :get do
    csv = CSV.generate( encoding: 'Windows-1251' ) do |csv|
      csv << [ "Id", "Name", "Gender", "Email", "Mobile number","Email Verified",
      "Mobile Verified", "Language Preference", "Counselling Preference", "Job Role Name",
      "Liked", "Disliked", "Favourited", "Shared", "Video Watched"]
    end

    send_data csv.encode('Windows-1251'), type: 'text/csv; charset=windows-1251; header=present', disposition: "attachment; filename=accounting_report.csv"
  end
