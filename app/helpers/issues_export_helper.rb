module DownloadHelper
  def add_journals(csv)
    csv = CSV.generate do |newcsv|
      CSV.parse(Redmine::CodesetUtil.to_utf8(csv, 'UTF-8'), :headers => true, :return_headers => true) do |row|
        if row.header_row?
          newcsv << row.fields + [t(:label_history)]
        else
          newcsv << row.fields + Issue.find(row.fields.first).journals.map do |j| 
            j.user.name + "\n" + j.details.map {|d| show_detail(d, true)}.join("\n") + "\n" + (j.notes.nil? ? '' :     j.notes)
          end
        end
      end
    end
    Redmine::CodesetUtil.from_utf8(csv, 'UTF-8')
  end
end
