class TransactionsController
  def index
    respond_to do |format|
      format.csv render_csv
    end
  end

  def render_csv
    set_headers
    response.status = 200
    #setting the body to an enumerator, rails will iterate this enumerator
    self.response_body = csv_lines(filters)
  end

  def csv_lines
    Enumerator.new do |y|
      y << Transaction.csv_header.to_s
      #ideally you'd validate the params, skipping here for brevity
      Transaction.find_in_batches(params){ |transaction| y << transaction.to_csv_row.to_s }
    end
  end

  def set_headers
    file_name = "transactions.csv"
    headers["Content-Type"] = "text/csv"
    headers["Content-disposition"] = "attachment; filename=\"#{file_name}\""

    headers['X-Accel-Buffering'] = 'no'

    headers["Cache-Control"] ||= "no-cache"
    headers.delete("Content-Length")
  end
end
