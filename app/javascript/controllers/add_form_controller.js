import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [ "output", "name", "breed", "size", "birthday" ]

  
  async addForm() {
    const dataIndex = 0;

    const fields = [
      this.nameTarget.innerHTML,
      this.breedTarget.innerHTML,
      this.sizeTarget.innerHTML,
      console.log(this.sizeTarget),
      this.birthdayTarget.innerHTML
    ];

    fields.forEach(field => {
      this.outputTarget.insertAdjacentHTML('beforeend', field);
    });
  }
}