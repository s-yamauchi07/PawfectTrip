import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="preview-image"
export default class extends Controller {
  static targets = ["file", "image"]
  preview() {
    this.fileTarget.addEventListener('change', (e) =>{
      const preview = this.imageTarget
      const file = e.target.files[0]

      const fileReader = new FileReader();
      fileReader.onload = (e) => {
        const alreadyPreview = document.querySelector('.preview');
        if (alreadyPreview) {
          alreadyPreview.remove();
        }
        
        const dataURL = e.target.result;
        const blobImage = document.createElement('img')
        blobImage.setAttribute('src',dataURL);
        blobImage.setAttribute('style',"width: 100%");
        blobImage.setAttribute('class',"preview");
        preview.append(blobImage)
      }
      fileReader.readAsDataURL(file)
    })
  }
}
