$(document).ready ->
  if $('body.index').length
    collapse_navbar_on_scroll()
    prepare_page_scrolling()
    projects_detail_modal()
    articles_load_more()

    if $(window).width() < 980
      prepare_projects()
    else
      prepare_projects_mixitup()

collapse_navbar_on_scroll = () ->
  $(window).scroll () ->
    if $(".navbar").offset().top > 50
      $(".navbar-fixed-top").addClass("top-nav-collapse")
      $('.intro-body .arrow-down-transparent').addClass("hiddn")
    else
      $(".navbar-fixed-top").removeClass("top-nav-collapse")
      $('.intro-body .arrow-down-transparent').removeClass("hiddn")

  $('.navbar-collapse li a').click () ->
    $('.navbar-collapse.collapse').collapse('hide');

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

projects_detail_modal = () ->
  $('#projects ul.projects-grid li').click (e) ->
    if $(e.target).is(':not(a)') && $(e.target).parent().is(':not(a)')
      show_project_modal($(this))

  $('#projects .owl-item-data a.gallery').click (e) ->
      target = $(this).attr('data-target')
      show_project_modal($(target))
      e.preventDefault();

  $('.projects-modal').click (e) ->
    if $(e.target).is('.item, .modal-dialog')
      $('.projects-modal').modal('hide')

  # Fix for Bootstrap Modal Shifting Page Contents
  $winWidth = $(window).width()
  $(document).on 'show.bs.modal', () ->
    $('body.modal-open,.navbar-fixed-top').css('marginRight', $(window).width() - $winWidth)
  $(document).on 'hidden.bs.modal', () ->
    $('body,.navbar-fixed-top').css('marginRight', 0)

show_project_modal = (item) ->
  if $('#modal-carousel').hasClass('owl-theme')
    $('#modal-carousel').data('owlCarousel').destroy()
    $('#modal-carousel').html('')
  item.find('ul li').each (index) ->
    $('#modal-carousel').append('<div class="item">' + $(this).html() + '</div>')
  $('.projects-modal .modal-desc').text(item.find('.project-desc').text())
  $('.projects-modal .modal-title').text(item.find('.project-name').text())
  $("#modal-carousel").owlCarousel({
    singleItem : true,
    navigation: true,
    pagination: true,
    mouseDrag: false,
    lazyLoad : true,
    navigationText: ["<i class='fa fa-chevron-left'></i>", "<i class='fa fa-chevron-right'></i>"],
  })
  $('.projects-modal').modal('show')

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


# Desktop Only
prepare_projects_mixitup = () ->
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


# Mobile Only
prepare_projects = () ->
  $("#projects-mobile-carousel").owlCarousel({
    singleItem: true,
    navigation: true,
    pagination: false,
    mouseDrag: false,
    navigationText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
  })

  offset = $('.owl-carousel').offset().top - $('#projects').offset().top
  height = $(window).height() - offset
  $('.owl-item-wrapper').height(height + 'px')
