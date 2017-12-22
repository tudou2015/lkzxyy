/* 
 * drag 1.0
 * create by tony@jentian.com
 * date 2015-08-18
 * 拖动滑块
 */
(function($){
    $.fn.drag = function(options){
        var x, drag = this, isMove = false, defaults = {
        };
        var options = $.extend(defaults, options);
        //添加背景，文字，滑块
        var html = '<div class="drag_bg"></div>'+
                    '<div class="drag_text" onselectstart="return false;" unselectable="on">拖动滑块验证</div>'+
                    '<div class="handler handler_bg"></div>';
        this.append(html);
        
        var handler = drag.find('.handler');
        var drag_bg = drag.find('.drag_bg');
        var text = drag.find('.drag_text');
        var maxWidth = drag.width() - handler.width();  //能滑动的最大间距
        
		//判断是否移动端
		if(browser.versions.mobile||browser.versions.android||browser.versions.ios||browser.versions.weixin||browser.versions.iPhone||browser.versions.iPad||browser.versions.qq){ 
			//alert("移动端"); 
			var shebei="phone";
			//alert(shebei);
			//document.addEventListener("touchmove",defaultEvent,false);//阻止页面的滑动默认事件   
			}
		else{			
			var shebei="pc";
			//alert(shebei);
			}
        //鼠标按下时候的x轴的位置
        if(shebei=="pc"){
			handler.mousedown(function(e){
            isMove = true;
            x = e.pageX - parseInt(handler.css('left'), 10);
			});
			//鼠标指针在上下文移动时，移动距离大于0小于最大间距，滑块x轴位置等于鼠标移动距离
			$(document).mousemove(function(e){
            var _x = e.pageX - x;
            if(isMove){
                if(_x > 0 && _x <= maxWidth){
                    handler.css({'left': _x});
                    drag_bg.css({'width': _x});
					}else if(_x > maxWidth){  //鼠标指针移动距离达到最大时清空事件
                    dragOk();
					$("#Label2").text("验证成功");					
					}
				}
			}).mouseup(function(e){
            isMove = false;
            var _x = e.pageX - x;
            if(_x < maxWidth){ //鼠标松开时，如果没有达到最大距离位置，滑块就返回初始位置
                handler.css({'left': 0});
                drag_bg.css({'width': 0});
				}
			});
		}
		else{
			handler.touchstart(function(e){
				event.preventDefault(); //阻止触摸事件的默认行为，即阻止滚屏
				isMove = true;
				x = e.originalEvent.targetTouches[0].pageX - parseInt(handler.css('left'), 10);
				//document.addEventListener("touchmove",defaultEvent,false);//阻止页面的滑动默认事件
				//event.preventDefault(); //阻止触摸事件的默认行为，即阻止滚屏
			});
			//鼠标指针在上下文移动时，移动距离大于0小于最大间距，滑块x轴位置等于鼠标移动距离
			$(document).touchmove(function(e){
            var _x = e.originalEvent.targetTouches[0].pageX - x;
            if(isMove){
                if(_x > 0 && _x <= maxWidth){
                    handler.css({'left': _x});
                    drag_bg.css({'width': _x});
					}else if(_x > maxWidth){  //鼠标指针移动距离达到最大时清空事件
                    dragOk();
					$("#Label2").text("验证成功");					
					}
				}
			}).touchend(function(e){
				isMove = false;
				var _x = e.originalEvent.targetTouches[0].pageX - x;
				if(_x < maxWidth){ //鼠标松开时，如果没有达到最大距离位置，滑块就返回初始位置
					handler.css({'left': 0});
					drag_bg.css({'width': 0});
					}
				//document.addEventListener("touchmove",defaultEvent,false);//阻止页面的滑动默认事件
			});
		}
		
        
        /*//鼠标指针在上下文移动时，移动距离大于0小于最大间距，滑块x轴位置等于鼠标移动距离
        $(document).touchmove(function(e){
            var _x = e.originalEvent.targetTouches[0].pageX - x;
            if(isMove){
                if(_x > 0 && _x <= maxWidth){
                    handler.css({'left': _x});
                    drag_bg.css({'width': _x});
                }else if(_x > maxWidth){  //鼠标指针移动距离达到最大时清空事件
                    dragOk();
					$("#Label2").text("验证成功");					
                }
            }
        }).mouseup(function(e){
            isMove = false;
            var _x = e.originalEvent.targetTouches[0].pageX - x;
            if(_x < maxWidth){ //鼠标松开时，如果没有达到最大距离位置，滑块就返回初始位置
                handler.css({'left': 0});
                drag_bg.css({'width': 0});
            }
        });*/
        
        //清空事件
        function dragOk(){
            handler.removeClass('handler_bg').addClass('handler_ok_bg');
            text.text('验证通过');
            drag.css({'color': '#fff'});
            handler.unbind('mousedown');
            $(document).unbind('mousemove');
            $(document).unbind('mouseup');
        }
    };
})(jQuery);


