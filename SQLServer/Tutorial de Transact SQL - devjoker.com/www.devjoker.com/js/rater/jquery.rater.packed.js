jQuery.fn.rater = function(url, options, callback) {
    if (url == null) return;
    var settings = {
        url: url, // post changes to 
        maxvalue: 5,   // max number of stars
        curvalue: 0,    // number of selected stars
        code: 0 //id del post
         
    };

    if (options) { jQuery.extend(settings, options); };
    jQuery.extend(settings, { cancel: (settings.maxvalue > 1) ? true : false });

    var container = jQuery(this);
    jQuery.extend(container, { averageRating: settings.curvalue, url: settings.url });

    if (!settings.style || settings.style == null || settings.style == 'basic') {
        var raterwidth = settings.maxvalue * 25;
        var ratingparent = '<ul class="star-rating" style="width:' + raterwidth + 'px">';
    }
    if (settings.style == 'small') {
        var raterwidth = settings.maxvalue * 10;
        var ratingparent = '<ul class="star-rating small-star" style="width:' + raterwidth + 'px">';
    }
    if (settings.style == 'inline') {
        var raterwidth = settings.maxvalue * 10;
        var ratingparent = '<span class="inline-rating"><ul class="star-rating small-star" style="width:' + raterwidth + 'px">';
    }
    container.append(ratingparent);

    // create rater
    var starWidth, starIndex, listitems = '';
    var curvalueWidth = Math.floor(100 / settings.maxvalue * settings.curvalue);
    for (var i = 0; i <= settings.maxvalue; i++) {
        if (i == 0) {
            listitems += '<li class="current-rating" style="width:' + curvalueWidth + '%;">' + settings.curvalue + '/' + settings.maxvalue + '</li>';
        } else {
            starWidth = Math.floor(100 / settings.maxvalue * i);
            starIndex = (settings.maxvalue - i) + 2;
            listitems += '<li class="star"><a href="#' + i + '" title="' + i + '/' + settings.maxvalue + '" style="width:' + starWidth + '%;z-index:' + starIndex + '">' + i + '</a></li>';
        }
    }
    container.find('.star-rating').append(listitems); // i am using find here, because the span wrapped in the small style would break children()

    if (settings.maxvalue > 1) // add a container for the ajax result
    {
        container.append('<span class="star-rating-result"></span>');
    }
    var stars = jQuery(container).find('.star-rating').children('.star');
    stars.click(function() {
        if (settings.maxvalue == 1) // on / off
        {
            settings.curvalue = (settings.curvalue == 0) ? 1 : 0;
            jQuery(container).find('.star-rating').children('.current-rating').css({ width: (settings.curvalue * 100) + '%' });
            jQuery.post(container.url, { "rating": settings.curvalue, "code": settings.code });
            return false;
        }
        else {

            settings.curvalue = stars.index(this) + 1;
            raterValue = jQuery(this).children('a')[0].href.split('#')[1];
            if (callback) {
                jQuery.post(container.url, { "rating": raterValue, "code": settings.code }, callback );
            }
            else {
                jQuery.post(container.url, { "rating": raterValue, "code": settings.code }, function(response) {
                    container.children('.star-rating-result').html(response)
                });
            }
            return false;
        }
        return true;
    });

    return this; // strict warning: anonymous function does not always return a value. fix?
}