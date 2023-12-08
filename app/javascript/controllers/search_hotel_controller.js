import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-hotel"
export default class extends Controller {
  static targets = ["prefecture","output"]

  search() {
    this.fetchAreaList()
  }

  async fetchAreaList() {
    const prefecture = this.prefectureTarget.value
    const application_id = gon.application_id
    const GetAreaUrl = `https://app.rakuten.co.jp/services/api/Travel/GetAreaClass/20131024?format=json&elements=middleClasses&formatVersion=2&applicationId=${application_id}`

    try {
      const res = await fetch(GetAreaUrl);
      if (!res.ok) {
        throw new Error("データ取得に失敗しました");
      }
      const data = await res.json();
      const prefectureLists = data.areaClasses.largeClasses[0][0].middleClasses
      let prefectureCode;

      for (const prefectureName of prefectureLists ) {
        if (prefectureName.middleClass[0].middleClassName === prefecture) {
          prefectureCode =  prefectureName.middleClass[0].middleClassCode;
          break;
        }
      }
      this.searchHotel(prefectureCode);
    } catch (error) {
      console.log("エラーが生じました", error);
    }
  }

  async searchHotel(prefectureCode) {
    const keyword = "ペット"
    const application_id = gon.application_id
    try {
      const hotelLists = await fetch(`https://app.rakuten.co.jp/services/api/Travel/KeywordHotelSearch/20170426?format=json&keyword=${keyword}&datumType=1&middleClassCode=${prefectureCode}&applicationId=${application_id }`);
      if (!hotelLists.ok) {
        throw new Error("データ取得に失敗しました");
      }
      const hotelData = await hotelLists.json();
      const hotelDataList = hotelData.hotels;
      this.showLists(hotelDataList);
      
    } catch (error) {
      console.log("該当のホテルがありませんでした", error)
    }
  }

  showLists(hotelDataList) {
    const insertList = [];
    for (const list of hotelDataList) {
      // ホテル情報の変数化
      const basicInfo = list.hotel[0].hotelBasicInfo;
      const hotelName = basicInfo.hotelName;
      const hotelImage = basicInfo.hotelImageUrl;
      const hoteladdress = basicInfo.address1 + basicInfo.address2;
      const hotelurl = basicInfo.hotelInformationUrl;
      const hotelNum = basicInfo.hotelNo
      const reviewAverage = basicInfo.reviewAverage != null ? parseFloat(basicInfo.reviewAverage) : "無し";
  
      // 代替の画像URL
      const altImageUrl = "/images/no_image.png";
  
      const html = `
      <li class="hotel-card">
        <a href="/hotels/${hotelNum}" data-turbolinks="false">
        <div class="card max-w-sm bg-base-100 shadow-xl">
          <div class="relative">
            <figure>
              <img src=${hotelImage} alt="hotel-image" onerror="this.src='${altImageUrl}';" class="h-80 w-full object-cover" />
            </figure>
          </div>
          <div class="card-body">
            <h3 class="card-title">
            <a href="${hotelurl}">${hotelName}</a>
            </h3>
            <p class="flex h-12 items-center">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="w-6 h-6">
                <path fill-rule="evenodd" d="M11.54 22.351l.07.04.028.016a.76.76 0 00.723 0l.028-.015.071-.041a16.975 16.975 0 001.144-.742 19.58 19.58 0 002.683-2.282c1.944-1.99 3.963-4.98 3.963-8.827a8.25 8.25 0 00-16.5 0c0 3.846 2.02 6.837 3.963 8.827a19.58 19.58 0 002.682 2.282 a16.975 16.975 0 001.145 .742zM12 13.5a3 3 0 100-6 a3 a3 0 0006z" clip-rule="evenodd" />
              </svg>
              ${hoteladdress}
            </p>
            <div class="card-actions justify-end">
              <input type="radio" name="rating-4" class="mask mask-star-2 bg-orange-400" disabled /> ${reviewAverage}
            </div>
          </div>
        </div>
        </a>
      </li>
      `;
      insertList.push(html);
    }
    // カンマが表示されないようにjoinメソッドで配列の要素を結合する。
    this.outputTarget.innerHTML = insertList.join('');
  }
}
