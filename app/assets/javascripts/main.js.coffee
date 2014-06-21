$(document).ready ->
  if $('body.index').length
    collapse_navbar_on_scroll()
    prepare_page_scrolling()
    # prepare_google_map()
    projects_detail_modal()
    projects_categories()
    articles_load_more()

collapse_navbar_on_scroll = () ->
  $(window).scroll () ->
    if $(".navbar").offset().top > 50
      $(".navbar-fixed-top").addClass("top-nav-collapse")
      $('.intro-body .arrow-down-transparent').addClass("hiddn")
    else
      $(".navbar-fixed-top").removeClass("top-nav-collapse")
      $('.intro-body .arrow-down-transparent').removeClass("hiddn")

prepare_page_scrolling = () ->
  $('a.page-scroll, .page-scroll a').click (event) ->
      anchor = $(this).attr('data-target')
      scroll_to_anchor(anchor)
      event.preventDefault()
  $('.page-scroll').on 'activate.bs.scrollspy', () ->
    if $('.page-scroll.active a').attr('data-target') == '#page-top'
      $('.navbar-main-collapse .page-scroll:first-child').addClass('hidden')
    else
      $('.navbar-main-collapse .page-scroll:first-child').removeClass('hidden')

scroll_to_anchor = (anchor) ->
  $('html, body').stop().animate({
    scrollTop: $(anchor).offset().top
  }, 800, 'easeInOutQuart')

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
        target = $('.projects-filter-list li.active').attr('data-filter')
        if target == 'all' || $(target).size() > 8
          $('.projects-link-top').show()
          $('.projects-grid').addClass('long')
        else
          $('.projects-link-top').hide()
          $('.projects-grid').removeClass('long')
    }
  })

  $('.projects-block .prev-page').click () ->
    $('.projects-grid').mixItUp('prevPage')
  $('.projects-block .next-page').click () ->
    $('.projects-grid').mixItUp('nextPage')

articles_load_more = () ->
  current_page = 1
  no_more_articles_left = false
  initial_height = $('.articles-grid')[0].scrollHeight - parseInt($('.articles-grid').css('margin-bottom'))
  load_more_link = $('.articles-load-more')

  load_more_link.click (event) ->
    event.preventDefault()
    if !no_more_articles_left
      load_more_link.addClass("loading")
      $.post($(this).attr("href"), { articles_page: current_page })
        .done (data) ->
          # animate append
          $('.articles-grid').height($('.articles-grid')[0].scrollHeight)
          $('.articles-grid').append(data)
          $('.articles-grid').height($('.articles-grid')[0].scrollHeight)
          $('a.articles-resize').show()
          if $('a.articles-resize').hasClass('maximize')
            $('a.articles-resize').toggleClass('minimize maximize')
            $('a.articles-resize').find('i.fa').toggleClass('fa-chevron-up fa-chevron-down')
        .fail () ->
          no_more_articles_left = true
          load_more_link.addClass('disabled')
        .always () ->
          current_page = current_page + 1
          load_more_link.removeClass("loading")

  $('a.articles-resize').click (event) ->
    event.preventDefault()
    if $(this).hasClass('minimize')
      $('.articles-grid').height(initial_height)
      scroll_to_anchor($(this).attr('data-target'))
    else
      $('.articles-grid').height($('.articles-grid')[0].scrollHeight)
    $(this).toggleClass('minimize maximize')
    $(this).find('i.fa').toggleClass('fa-chevron-up fa-chevron-down')

