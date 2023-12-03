module MoveComment
  def move_comment_page(plan)
      #トップページに登録した旅行日程のタイトルが表示されていることを確認する。
      expect(page).to have_content(plan.title)

      #画像をクリックする
      click_on("plan-image#{plan.id}")
      
      # コメント詳細ページへ遷移する
      click_link("コメント#{plan.comments.length}件を見る")
  end
end