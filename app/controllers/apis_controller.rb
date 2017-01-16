class ApisController < ApplicationController
  acts_as_token_authentication_handler_for User

  respond_to :json

  #用户调用天气接口数据
  def api_date
    _appid = params[:appid]
    _appkey = params[:appkey]
    _api_type = params[:api_type]
    if _appid.present? && _appkey.present?
      @user = User.find_by(appkey: _appkey, appid:_appid)
      if @user.present?
        @interface_document = current_user.interface_documents.find_by(api_type: _api_type)
        if @interface_document.present?
          appid = "bFLKk0uV7IZvzcBoWJ1j"
          appkey = "mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe"
          url = "#{@interface_document.site}appid=#{appid}&appkey=#{appkey}"
          params.each do |key, value| 
            url << "&" << key << "=" << value if key == "lon" || key == "lat" || key == "city_name" || key == "unit"
          end
          @api_dates = DataJson.get_data(url) 
          if @api_dates.present?
            @interface_document.update(frequency: @interface_document.frequency + 1) #记录访问次数
            @interface_document.ceate_statis_info(@user.id, @interface_document.id)#创建统计信息
          end
          respond_with @api_dates, template: '/api_dates, status: 200'
        end
      else
        @error = "current_user not present !"
        respond_with(@error,template: 'error', status: 422)
      end
   else
      @error = "appid  or appkey not present !"
      respond_with(@error,template: 'error', status: 422)
   end
  end
end
