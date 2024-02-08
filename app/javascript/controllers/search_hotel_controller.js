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
              <img src=${hotelImage} alt="hotel-image" onerror="this.src='${altImageUrl}';" class="h-80 w-full object-cover rounded-t-2xl" />
            </figure>
          </div>
          <div class="card-body">
            <h3 class="card-title">
            <a href="${hotelurl}">${hotelName}</a>
            </h3>
            <p class="flex h-12 items-center">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-5 h-5">
              <path fill-rule="evenodd" d="m9.69 18.933.003.001C9.89 19.02 10 19 10 19s.11.02.308-.066l.002-.001.006-.003.018-.008a5.741 5.741 0 0 0 .281-.14c.186-.096.446-.24.757-.433.62-.384 1.445-.966 2.274-1.765C15.302 14.988 17 12.493 17 9A7 7 0 1 0 3 9c0 3.492 1.698 5.988 3.355 7.584a13.731 13.731 0 0 0 2.273 1.765 11.842 11.842 0 0 0 .976.544l.062.029.018.008.006.003ZM10 11.25a2.25 2.25 0 1 0 0-4.5 2.25 2.25 0 0 0 0 4.5Z" clip-rule="evenodd" />
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
