class TrackerAPI

  def initialize
    @conn = Faraday.new(:url => 'https://www.pivotaltracker.com')
  end

  def projects(token)
    if token
      response = @conn.get do |req|
          req.url "/services/v5/projects"
          req.headers['Content-Type'] = 'application/json'
          req.headers['X-TrackerToken'] = token
      end
      JSON.parse(response.body, symbolize_names: true)
    end
  end

  def stories(token, project_id)
    if token
      response = @conn.get do |req|
        req.url "/services/v5/projects/#{project_id}/stories"
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-TrackerToken'] = token
      end
      JSON.parse(response.body, symbolize_names: true)
    end
  end

end
