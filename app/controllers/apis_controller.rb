# class ApisController < ApplicationController
#   acts_as_token_authentication_handler_for User

#   respond_to :json

#   ##### 需要重写
#   #用户调用天气接口数据
#   def api_date
#     if params[:appid].present? && params[:appkey].present?
#       @user = User.find_by(appkey: params[:appkey], appid: params[:appid])#准备把find_by封装成scope：check_app，但是结果出错。
#       if @user.present?
#         @interface_document = @user.interface_documents.check_api_type(params[:api_type]) if params[:api_type].present?
#         if @interface_document.present? && @interface_document.records.check_user(@user.id).state #申请的接口存在并且有效
#           p @api_dates = RequestData.get_data(params, @interface_document)
#           if @api_dates.present?
#             RequestData.create_statis_info(@interface_document, @user.id)
#           end
#           respond_with @api_dates, template: '/api_dates, status: 200'
#         else
#           @error = "current_user 未取得该接口权限 !"
#           respond_with(@error,template: 'error', status: 422)
#         end
#       else
#         @error = "current_user not present !"
#         respond_with(@error,template: 'error', status: 422)
#       end
#     else
#       @error = "appid  or appkey not present !"
#       respond_with(@error,template: 'error', status: 422)
#     end
#   end
# end
