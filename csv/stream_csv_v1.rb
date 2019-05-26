https://medium.com/table-xi/stream-csv-files-in-rails-because-you-can-46c212159ab7

  def show
    respond_to do |format|
      format.html \{\}
      format.csv do
        headers["X-Accel-Buffering"] = "no"
        headers["Cache-Control"] = "no-cache"
        headers["Content-Type"] = "text/csv; charset=utf-8"
        headers["Content-Disposition"] =
           %(attachment; filename="#{csv_filename}")
        headers["Last-Modified"] = Time.zone.now.ctime.to_s
        self.response_body = build_csv_enumerator(header, data)
      end
    end
  end

  private def csv_filename
    "report-#{Time.zone.now.to_date.to_s(:default)}.csv"
  end


build_csv_enumerator(header, Model.csv_collection)

  def build_csv_enumerator(header, data)
    Enumerator.new do |y|
      CsvBuilder.new(header, data, y)
    end
  end
  
  class CsvBuilder

    attr_accessor :output, :header, :data

    def initialize(header, data, output = "")
      @output = output
      @header = header
      @data = data
    end

    def build
      output << CSV.generate_line(header)
      data.each do |row|
        output << CSV.generate_line(row)
      end
      output
    end
  end
  
  def self.csv_collection
    Model.find_each.lazy.map do |model|
      model.to_row
    end
  end
