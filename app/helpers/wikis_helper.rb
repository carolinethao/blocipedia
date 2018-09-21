module WikisHelper
  def user_is_authorized_for_private?
    current_user.premium? || current_user.admin?
  end

  def user_is_authorized_for_edit?
    current_user
  end

  def user_is_authorized_for_delete?
    current_user && current_user.admin?
  end

  def user_is_authorized_for_collaborator_edit?
    @wiki.user || current_user.premium?
  end

  def wiki_has_collaborators?
    @wiki.collaborators.any?
  end

  def find_users()
    users = []
    collaborators = Collaborator.pluck(:user_id) # find all user_id's that are currently collaborators
    all_users = User.all
    all_users.each do |user|
      if !collaborators.include?(user.id)
        users << user # if user is not a collaborator, add to list
      end
    end
    users
    puts users
  end
end
