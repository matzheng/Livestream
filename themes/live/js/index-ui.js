/************界面相关的脚本*************/
function switchTab(tab, tabBody) {
    $(tabBody).show();
    $(tabBody).siblings().hide();
    $(tab).addClass("selectTab");
    $(tab).siblings().removeClass("selectTab");
}
function switchView() {
    if (!!document.createElement('canvas').getContext && window.WebSocket) {
        if ($("#playerView").hasClass("playerView_big")) {
            WIS.Resize(784, 550);
            WIS.AllowDraw({ ballow: !drawLocked });
            $("#vvMedia1").width(278).height(180);
            $("#hlsMedia1").width(278).height(180);
            $("#html5Media1").width(278).height(180).css("margin-top", "-180px");
            $(".leftBox").css("background-color", "inherit");
            $(".boardView").css("border-radius", "5px 0px 0px 5px");
            var _tmp = $("#displayBox").children("#wis_context").remove();
            _tmp.css("margin-top", "0px");
            $("#boardBox").append(_tmp);
            $("#playerView").removeClass("playerView_big");
            $(".toolsBar").css("visibility", "visible");
            $(".boardBottom").css("visibility", "visible");
        } else {
            WIS.Resize(278, 180);
            WIS.AllowDraw({ ballow: false });
            $("#vvMedia1").width(861).height(608);
            $("#hlsMedia1").width(861).height(608);
            $("#html5Media1").width(861).height(608).css("margin-top", "-180px");
            $(".leftBox").css("background-color", "black");
            $(".boardView").css("border-radius", "0px");
            var _tmp = $("#boardBox").children("#wis_context").remove();
            _tmp.css("margin-top", "-180px");
            $("#displayBox").append(_tmp);
            $("#playerView").addClass("playerView_big");
            $(".toolsBar").css("visibility", "hidden");
            $(".boardBottom").css("visibility", "hidden");
        }
    } else {
        if ($("#wis_context").hasClass("wis_context_small")) {
            WIS.Resize(784, 550);
            WIS.AllowDraw({ ballow: !drawLocked });
            $("#vvMedia1").width(278).height(180);
            $("#hlsMedia1").width(278).height(180);
            $("#html5Media1").width(278).height(180).css("margin-top", "-180px");
            $(".boardView").css("overflow", "hidden");
            $("#wis_context").removeClass("wis_context_small");
            $("#playerView").removeClass("playerView_big");
            $(".toolsBar").css("visibility", "visible");
            $(".boardBottom").css("visibility", "visible");
        } else {
            WIS.Resize(278, 180);
            WIS.AllowDraw({ ballow: false });
            $("#vvMedia1").width(861).height(608);
            $("#hlsMedia1").width(861).height(608);
            $("#html5Media1").width(861).height(608).css("margin-top", "-150px");
            $(".boardView").css("overflow", "visible");
            $("#wis_context").addClass("wis_context_small");
            $("#playerView").addClass("playerView_big");
            $(".toolsBar").css("visibility", "hidden");
            $(".boardBottom").css("visibility", "hidden");
        }
    }
}
var enableScroll = true;
$(function () {
    $(".toolItem").live("click", function () {
        if (!$(this).attr("data-cmd")) {
            $(this).addClass("selectItem");
            $(this).siblings(".toolItem").removeClass("selectItem");
        }
    });
    $(".switchItem").live("click", function (e) {
        if ($(this).hasClass("selectItem")) {
            $(this).removeClass("selectItem");
        } else {
            $(this).addClass("selectItem");
        }
    });
    $.fn.sliderBar = function (option) {
        container = $(this);
        var slider = {
            value: option.value ? option.value : 50,
            maxValue: option.maxValue ? ption.maxValue : 100,
            step: option.step ? option.step : 1,
            container: container,
            valueChanged: option.valueChanged,
            Initialize: function () {
                var obj = container.html("").append('<div class="slider_Track"></div><div class="slider_Thumb"></div>');
                this.value = this.value > this.maxValue ? this.maxValue : this.value;
                var currentValue = container.width() * (this.value / this.maxValue);
                obj.children(".slider_Track").css("width", currentValue + 2 + "px");
                obj.children(".slider_Thumb").css("margin-left", (currentValue - obj.children(".slider_Thumb").width()) + "px");
                this.Value();
                if (slider.valueChanged) {
                    slider.valueChanged(slider);
                }
            },
            Value: function () {
                var valite = false;
                var currentValue = container.width() * (this.value / this.maxValue);
                var obj = container;
                obj.children(".slider_Thumb").mousedown(function () {
                    if (document.selection) {
                        document.selection.empty();
                    } else if (window.getSelection) {
                        window.getSelection().removeAllRanges();
                    }
                    valite = true;
                    $(document.body).mousemove(function (event) {
                        if (valite == false) return;
                        currentValue = event.clientX - obj.offset().left;
                        obj.children(".slider_Thumb").css("margin-left", currentValue + "px");
                        obj.children(".slider_Track").css("width", currentValue + 2 + "px");
                        var thumb_width = obj.children(".slider_Thumb").width();
                        if ((currentValue + thumb_width) >= obj.width()) {
                            obj.children(".slider_Thumb").css("margin-left", obj.width() - thumb_width + "px");
                            obj.children(".slider_Track").css("width", obj.width() + 2 + "px");
                            slider.value = slider.maxValue;
                        } else if (currentValue <= 0) {
                            obj.children(".slider_Thumb").css("margin-left", "0px");
                            obj.children(".slider_Track").css("width", "0px");
                        } else {
                            slider.value = Math.round(100 * (currentValue / obj.width()));
                        }
                        if (slider.valueChanged) {
                            slider.valueChanged(slider);
                        }
                    });
                });
                $(document.body).mouseup(function () {
                    if (!valite) return;
                    slider.value = Math.round(100 * (currentValue / obj.width()));
                    valite = false;
                    if (slider.value >= slider.maxValue) slider.value = slider.maxValue;
                    if (slider.value <= 0) slider.value = 0;
                    if (slider.valueChanged) {
                        slider.valueChanged(slider);
                    }
                });
            }
        }
        slider.Initialize();
        return slider;
    };
});