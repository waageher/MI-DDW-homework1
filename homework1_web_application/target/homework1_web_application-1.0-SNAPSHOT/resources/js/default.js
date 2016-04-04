$("rect, text").mouseover(function () {
    $("rect." + $(this).attr('class')).css('fill', 'yellow');
}).mouseout(function () {
    $("rect." + $(this).attr('class')).css('fill', 'transparent');
});
