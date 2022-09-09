task :nil_edit_count => :environment do
    articles = Article.where(edit_count: nil)
        articles.each do |article|
            article.update(edit_count: 0)
        end
  end