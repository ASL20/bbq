require("@rails/ujs").start()

import * as bootstrap from 'bootstrap'
import "bootstrap-icons/font/bootstrap-icons"
import "../stylesheets/application"
import "scripts/maps"

document.addEventListener("DOMContentLoaded", function(event) {
  var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
  var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
    return new bootstrap.Popover(popoverTriggerEl)
  })

  var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
  var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
  })
});

const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
