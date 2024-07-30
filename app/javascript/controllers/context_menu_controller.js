import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    this.hideMenu = this.hideMenu.bind(this)
    document.addEventListener("click", this.hideMenu);
  }

  disconnect() {
    document.removeEventListener("click", this.hideMenu);
  }

  toggle(event) {
    event.preventDefault();
    event.stopPropagation();

    const clickedElement = event.target
    console.log(clickedElement)
    this.positionMenu(event);
    this.menuTarget.classList.remove("hide")
  }

  positionMenu(event) {
    let menuDimensions = this.getDimensions(this.menuTarget);
    this.menuTarget.style.left = `${this.clampValue(
      event.clientX,
      window.innerWidth,
      menuDimensions.width
    )}px`;
    this.menuTarget.style.top = `${this.clampValue(
      event.clientY,
      window.innerHeight,
      menuDimensions.height
    )}px`;
  }

  clampValue(value, maxValue, elementDimension) {
    let viewportDimension = maxValue - elementDimension;
    return value > viewportDimension ? viewportDimension : value;
  }

  getDimensions(element) {
    let dimensions = {};
    element.classList.remove("hidden");
    dimensions.width = element.offsetWidth;
    dimensions.height = element.offsetHeight;
    element.classList.add("hidden");
    return dimensions;
  }


  hideMenu(event) {
    if (this.shouldHideMenu(event)) {
      this.menuTarget.classList.add("hide");
    }
  }

  shouldHideMenu(event) {
    return (
      !this.menuTarget.contains(event.target) ||
      event.target === this.menuTarget ||
      event.target.closest("a")
    );
  }
}
