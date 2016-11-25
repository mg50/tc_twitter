class SearchTweets
  def self.execute(search_string)
    from_username, search_body = parse_search_string(search_string)
    scope = Tweet.joins(:user)
                 .order(created_at: :desc)
                 .limit(100)
    scope = scope.where(users: {username: from_username}) if from_username
    scope = scope.where("body ILIKE ?", "%#{search_body}%") if search_body.present?
    scope.map(&:as_json)
  end

  FROM_USERNAME_REGEX = /from:@([A-Za-z]+)/
  def self.parse_search_string(search_string)
    username = search_string.match(FROM_USERNAME_REGEX).try(:[], 1)
    body = search_string.gsub(FROM_USERNAME_REGEX, '').strip
    [username, body]
  end
  private_class_method :parse_search_string
end
