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
    const allowItems = this.getAllowItems(clickedElement)
    this.filterMenuItems(allowItems)

    this.positionMenu(event);
    this.menuTarget.classList.remove("hide")
  }

  getAllowItems(element) {
    const parentElement = element.parentElement
    if(Object.keys(element.dataset).length > 0) {
      return JSON.parse(element.dataset.allowItems)
    } else if(Object.keys(parentElement.dataset).length > 0) {
      return JSON.parse(parentElement.dataset.allowItems)
    }
    return []
  }

  filterMenuItems(allowItems) {
    const menuItems = $(this.menuTarget).children();
    menuItems.each((_, item) => {
      if(!allowItems.includes($(item).data('item'))) {
        item.classList.add('hide')
      } else {
        item.classList.remove('hide')
      }
    })
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
    element.classList.remove("hide");
    dimensions.width = element.offsetWidth;
    dimensions.height = element.offsetHeight;
    element.classList.add("hide");
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
      event.target.closest("a")
    );
  }

  getItemId(clickedElement) {
    const targetParent = $(clickedElement).parents("[data-item-id]")
    return targetParent.data('itemId');
  }
}
