import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tab"
export default class extends Controller {
  static targets = ["tab", "card"]
  static values = { defaultTab: String  }

  connect() {
    this.cardTargets.map(x => x.hidden = true)
    try {
      // デフォルトのタブを開いておく
      let selectedTab = this.tabTargets.find(element => element.id === this.defaultTabValue)
      let selectedCard = this.cardTargets.find(element => element.id === this.defaultTabValue)

      selectedCard.hidden = false
      selectedTab.classList.add("tab-active")
    } catch {}
  }

  click(e) {
    //クリックしたタブと同じid情報を持ったcard要素を取得する
    let selectedCard = this.cardTargets.find(element => element.id === e.currentTarget.id)

    if (selectedCard.hidden) {
      // 取得したcard要素が非表示の場合、取得したカードcard要素を非表示を解除+アクティブのタブを無効にする
      this.cardTargets.map(x => x.hidden = true)
      this.tabTargets.map(x => x.classList.remove("tab-active"))
      

      selectedCard.hidden = false
      e.currentTarget.classList.add("tab-active")
    } else {
      // 現在非アクティブのタブを表示させる
      this.cardTargets.map(x => x.hidden = true)
      this.tabTargets.map(x => x.classList.remove("tab-active"))
      selectedCard.hidden = true
      e.currentTarget.classList.remove("tab-active")
    }
  }
}
