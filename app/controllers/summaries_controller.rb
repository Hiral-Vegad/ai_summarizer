class SummariesController < ApplicationController
  def index
    @summaries = Summary.order(created_at: :desc)
    @summary = Summary.new
  end

  def create
    @summary = Summary.create(original: summary_params[:original])

    begin
      client = OpenAI::Client.new
      response = client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: [
            { role: "system", content: "You are a helpful assistant that summarizes text." },
            { role: "user", content: "Summarize the following:\n\n#{@summary.original}" }
          ]
        }
      )
      result = response.dig("choices", 0, "message", "content")
      @summary.update(result: result)
    rescue Faraday::TooManyRequestsError => e
      @summary.update(result: "Rate limit hit. Please try again in a moment.")
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to summaries_path }
    end
  end

  private

  def summary_params
    params.require(:summary).permit(:original)
  end
end
