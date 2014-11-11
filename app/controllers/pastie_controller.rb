class PastieController < ApplicationController
  def new
    new_token = gen_token
    flash[:notice] = 'Created new Pastie!'
    redirect_to("/pastie/#{new_token}")
  end

  def edit
    @token_key = params[:token_key]
    @pastie = Pastie.find_by_token(@token_key)

    if @pastie.present? && Time.current.utc > (@pastie.updated_at + 5.minutes)
      @pastie.update(content: '')
      @pastie.reload
      flash[:error] = 'We have cleared your pastie content'
    end
    render :index
  end

  def delete
    token_key = params[:token_key]
    pastie = Pastie.find_by(token:token_key)
    if pastie.present?
      pastie.destroy
    end
    flash[:error] = 'We have cleared your pastie content'
    redirect_to "/pastie/#{token_key}"
  end

  def update
    token_key = params[:token_key]

    pastie = Pastie.where(token:token_key).first_or_create
    pastie.update(content:params[:content])
    flash[:notice] = 'Saved!'

    redirect_to "/pastie/#{token_key}"
  end

  private

  def gen_token
    while (true) do
      new_token = token_string_generate
      return new_token unless Pastie.exists?(token:new_token)
    end
  end

  def token_string_generate
    (0...8).map { (65 + rand(26)).chr }.join.downcase
  end
end
