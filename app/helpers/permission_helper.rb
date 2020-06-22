module PermissionHelper

  def canEdit(record)
    if record.respond_to?(:user_id) and user_signed_in? and record.user_id === current_user.id
      true
    else
      false
    end
  end

end
