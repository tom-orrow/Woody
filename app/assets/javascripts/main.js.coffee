$(document).ready ->
  collapse_navbar_on_scroll()
  prepare_page_scrolling()
  # prepare_google_map()
  projects_detail_modal()
  projects_categories()

collapse_navbar_on_scroll = () ->
  $(window).scroll () ->
    if $(".navbar").offset().top > 50
      $(".navbar-fixed-top").addClass("top-nav-collapse")
      $('.intro-body .arrow-down-transparent').addClass("hiddn")
    else
      $(".navbar-fixed-top").removeClass("top-nav-collapse")
      $('.intro-body .arrow-down-transparent').removeClass("hiddn")

prepare_page_scrolling = () ->
  $('.page-scroll a').click (event) ->
      anchor = $(this)
      $('html, body').stop().animate({
        scrollTop: $(anchor.attr('href')).offset().top
      }, 800, 'easeInOutQuart')
      event.preventDefault()
  $('.page-scroll').on 'activate.bs.scrollspy', () ->
    if $('.page-scroll.active a').attr('href') == '#page-top'
      $('.navbar-main-collapse .page-scroll:first-child').addClass('hidden')
    else
      $('.navbar-main-collapse .page-scroll:first-child').removeClass('hidden')


prepare_google_map = () ->
  myLatlng = new google.maps.LatLng(51.53658, 45.97337);
  myOptions = {
    zoom: 16,
    center: myLatlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    disableDefaultUI: true,
    # Styles from http://snazzymaps.com/
    styles: [{"stylers":[{"saturation":-100},{"gamma":1}]},{"elementType":"labels.text.stroke","stylers":[{"visibility":"off"}]},{"featureType":"poi.business","elementType":"labels.text","stylers":[{"visibility":"off"}]},{"featureType":"poi.business","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"poi.place_of_worship","elementType":"labels.text","stylers":[{"visibility":"off"}]},{"featureType":"poi.place_of_worship","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"geometry","stylers":[{"visibility":"simplified"}]},{"featureType":"water","stylers":[{"visibility":"on"},{"saturation":50},{"gamma":0},{"hue":"#50a5d1"}]},{"featureType":"administrative.neighborhood","elementType":"labels.text.fill","stylers":[{"color":"#333333"}]},{"featureType":"road.local","elementType":"labels.text","stylers":[{"weight":0.5},{"color":"#333333"}]},{"featureType":"transit.station","elementType":"labels.icon","stylers":[{"gamma":1},{"saturation":50}]}]
  }
  map = new google.maps.Map(document.getElementById('map'), myOptions)
  marker = new google.maps.Marker({
    position: myLatlng,
    map: map,
    title:"Here!"
  })

projects_detail_modal = () ->
  $('#projects ul.projects-grid li').click (e) ->
    console.log(e.target)
    if $(e.target).is(':not(a)') && $(e.target).parent().is(':not(a)')
      show_project_modal($(this))

show_project_modal = (item) ->
  $('.projects-block').find('.prev-page, .next-page').addClass('transparent')
  $('.projects-modal ol.carousel-indicators').html('')
  $('.projects-modal .carousel-inner').html('')
  item.find('ul li').each (index) ->
    $('.projects-modal ol.carousel-indicators').append('<li data-target="#carousel" data-slide-to="' + index + '"></li>')
    $('.projects-modal .carousel-inner').append('<div class="item" style="background-image: url(' + $(this).text() + ')"></div>')
  $('.projects-modal ol.carousel-indicators li:first-child').addClass('active')
  $('.projects-modal .carousel-inner .item:first-child').addClass('active')
  $('.projects-modal').modal('show')

projects_categories = () ->
  # MixItUp
  $('.projects-grid').mixItUp({
    load: {
      filter: '.recent'
    },
    animation: {
      duration: 400,
      effects: 'fade stagger(34ms) translateY(-40px) translateZ(-1000px)',
      easing: 'cubic-bezier(0.645, 0.045, 0.355, 1)'
    },
    callbacks: {
      onMixStart: () ->
        target = $('#projects .projects-filter-list li.active').attr('data-filter')
        if target == 'all' || $(target).size() > 6
          $('.projects-block').find('.prev-page, .next-page').removeClass('transparent')
        else
          $('.projects-block').find('.prev-page, .next-page').addClass('transparent')
      ,
    }
  })

  $('.projects-block .prev-page').click () ->
    $('.projects-grid').mixItUp('prevPage')
  $('.projects-block .next-page').click () ->
    $('.projects-grid').mixItUp('nextPage')
