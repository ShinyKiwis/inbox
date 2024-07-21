import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    $(".togglable").each(function() {
      const parent = $(this).parent();
      parent.add($(this)).on("click", function(event) {
        // Allow anchor tag with data-turbo-method to continue the propagation 
        if($(event.target).closest('a[data-turbo-method]').length > 0) {
          return;
        }
        event.stopPropagation();
      })
    })

    $(this.element).on("click", function() {
      $(".togglable").each(function() {
        if(!$(this).hasClass("hide")) {
          $(this).addClass("hide")
        }
      })
    })
  }
}
