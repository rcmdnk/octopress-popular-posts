module Jekyll

  class PopularPosts < Generator
    safe :true
    priority :lowest

    def generate(site)
      # require octopress-page-view plugin
      if !site.config['page-view']
        return
      end
      n_posts = site.config['page-view']['n_posts']

      popular_posts = site.posts.docs.sort do |px, py|
        if px.data['_pv'] == nil || py.data['_pv'] == nil then 0
        elsif px.data['_pv'] > py.data['_pv'] then -1
        elsif px.data['_pv'] < py.data['_pv'] then 1
        else 0
        end
      end

      site.config.merge!('popular_posts' => popular_posts[0, n_posts])
    end
  end
end
