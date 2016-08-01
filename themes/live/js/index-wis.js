/****************************************** 全局定义 ******************************************/
function getLastScriptArgs() {
    var sc = document.getElementsByTagName('script');
    var urlComp = sc[sc.length - 1].src.split('?');
    if (urlComp.length < 2) return {};
    var paramsArr = urlComp[1].split('&');
    var args = {}, argsStr = [], param, t, name, value;
    for (var ii = 0, len = paramsArr.length; ii < len; ii++) {
        param = paramsArr[ii].split('=');
        name = param[0], value = param[1];
        if (typeof args[name] == "undefined") {
            args[name] = value;
        } else if (typeof args[name] == "string") {
            args[name] = [args[name]];
            args[name].push(value);
        } else {
            args[name].push(value);
        }
    }
    return args;
};
function getQueryStr(str) {
    var LocString = String(window.document.location.href);
    var rs = new RegExp("(^|)" + str + "=([^&]*)(&|$)", "gi").exec(LocString), tmp;
    if (tmp = rs) {
        return decodeURIComponent(tmp[2]);
    }
    return "";
}
var wisJsArgs = getLastScriptArgs();
var manager = wisJsArgs["manager"] ? wisJsArgs["manager"] != "0" : true;    //区分教师端和学生端

/****************************************** WIS白板相关 ******************************************/
//WIS相关参数
var wisWidth = wisJsArgs["wisWidth"] ? parseInt(wisJsArgs["wisWidth"]) : 784;   //白板宽度
var wisHeight = wisJsArgs["wisWidth"] ? parseInt(wisJsArgs["wisHeight"]) : 550; //白板高度
var wisId = getQueryStr("wisId");
wisId = wisId ? wisId : "b3a081baabc47aacf067a60e4cae3e52";     //修改为自己的wisId
var pageNum = 0;
var drawLocked = false, drawAlpha = 1, drawTrack = false;
var docObject;
var pendingTask = [];
var WisState = 0;
function sendCustomMessage(msg) {
    if (WisState == 0) {
        if (pendingTask.length > 1000) {
            delete pendingTask[0];
        }
        pendingTask.append(msg);
    } else if (WisState == 1) {
        WIS.SendCustomMessage(msg);
    }
}
function getDocList(option) {
    $.ajax({
        type: "POST",
        timeout: 8000,
        url: "./wis/wis_interface.php",
        dataType: "json",
        data: { method: 'DocList', skip: option.skip, num: option.num },
        success: function (data) {
            if (data.Flag == 100) {
                if (option.success) option.success(data.Info);
            } else {
                if (option.failure) option.failure(data.FlagString);
            }
        },
        error: option.failure,
    });
}
function loadDocList(err) {
    if (!manager) return;
    if (err != null) {
        alert(err);
    }
    $(".docUploader img").remove();
    $(".docUploader a").show();
    $("#uploadForm").attr("src", "wis/uploadForm.html");
    getDocList({
        skip: 0,
        num: 100,
        success: function (data) {
            console.log("获取文档列表:", data.list);
            var list = data.list;
            $("#docList").html("");
            for (var i = 0; i < list.length; i++) {
                var itemHtml = "<div docId='" + list[i]["id"] + "'><img src='" + list[i].pdfUrl + "?page/1/density/150/quality/80/resize/300' /><span>" +
                    jQuery('<div />').text(decodeURIComponent(list[i].fileName)).html() + "</span><a>删除</a></div>";
                $("#docList").append(itemHtml);
            }
            if (!!docObject) {
                $("#docList div[docId=" + docObject["id"] + "]").addClass("selectDoc");
                $("#docList div[docId=" + docObject["id"] + "]").siblings().removeClass("selectDoc");
            }
            $("#docList div img,#docList div span").live("click", function () {
                WIS.ChoseDoc({
                    docId: $(this).parent().attr("docId"),
                    failure: function () {
                        alert("文档不存在!");
                        loadDocList();
                    }
                });
            });
            $("#docList div a").live("click", function () {
                alert("Demo中的文档不能删除!");
            });
        },
        failure: function (errStr) {
            WisState = -1;
            if (typeof str != "string") {
                alert("文档列表获取失败")
            } else {
                alert(errStr);
            }
        }
    });
}
function initWIS(handler) {
    $(".colorList .toolItem").live("click", function () {
        WIS.Color($(this).attr("data-color"));
    });
    $(".lineList .toolItem").live("click", function () {
        WIS.LineWidth($(this).attr("data-line"));
    });
    $(".toolList .toolItem").live("click", function () {
        if ($(this).attr("data-cmd") == "Clear") {
            WIS.Clear();
        } else if ($(this).attr("data-cmd") == "Lock") {
            drawLocked = !drawLocked;
            WIS.AllowDraw({ ballow: !drawLocked });
        } else if ($(this).attr("data-cmd") == "Alpha") {
            drawAlpha = drawAlpha == 1 ? 0.5 : 1;
            WIS.Alpha(drawAlpha);
        } else if ($(this).attr("data-cmd") == "Track") {
            drawTrack = !drawTrack;
            WIS.Track({ state: drawTrack, time: 200 });
        } else {
            WIS.SetDrawType($(this).attr("data-type") + "");
        }
    });
    $("#pageList").live("change", function (val) {
        WIS.ToPage($("#pageList").val());
    });
    var api = WISAPI.New('./wis/wis_interface.php', { })
    WIS.Init({
        wisId: wisId,
        api: api,
        container: 'wis_context_inner',
        width: wisWidth,
        height: wisHeight,
        success: function () {
            WIS.Color("#FF8C00");
            WIS.AllowDraw({ ballow: manager });
            if (WIS.GetCurrentDoc() == "" || WIS.GetCurrentDoc() == null) {
                alert("请选择文档")
            }
            while (pendingTask.length > 0) {
                WIS.SendCustomMessage(preTask[0]);
                delete preTask[0];
            }
            WisState = 1;
        },
        failure: function (err) {
            alert("init fail:  " + err);
        },
        updateUser: function (total) { },
        onCustomMessage: function (msg) {
            try {
                console.log("WIS自定义消息:", msg);
                if (handler.onCustomMessage[msg.msgType]) {
                    handler.onCustomMessage[msg.msgType](msg);
                }
            } catch (ex) {
                console.log("WIS自定义消息 error:", ex);
            }
        },
        onConnect: function () { },
        onReconnect: function () { },
        onConnectClose: function () { },
        onDocLoad: function (info) {
            console.log(info);
            docObject = info;
            $("#docList div[docId=" + docObject["id"] + "]").addClass("selectDoc");
            $("#docList div[docId=" + docObject["id"] + "]").siblings().removeClass("selectDoc");
        },
        onPageChange: function (page, total) {
            pageNum = total;
            $("#pageList").html("");
            for (var i = 1; i <= total; i++) {
                var option = $("<option>").val(i).text(i);
                $("#pageList").append(option);
            }
            $("#pageList").val(page);
        }
    });
    loadDocList();
}

/****************************************** TIS文字互动相关 ******************************************/
//TIS相关参数
var tisId = getQueryStr("tisId");
tisId = tisId ? tisId : "95596cacd97888e4302b1bb288024ab4";     //修改为自己的tisId
var userMap = {}
var userName = $.trim(getQueryStr("name"));
//var DefName = [
//            "曹操", "曹丕", "曹睿", "曹芳", "曹髦", "曹奂", "曹仁", "曹洪", "曹纯", "曹真", "曹休", "曹爽", "曹植", "曹昂", "曹彰", "曹冲", "曹羲", "曹训", "曹彦", "夏侯渊",
//            "夏侯敦", "夏侯茂", "夏侯衡", "夏侯霸", "夏侯称", "夏侯威", "夏侯荣", "夏侯惠", "夏侯和", "夏侯尚", "夏侯玄", "司马懿", "司马师", "司马昭", "钟会", "邓艾", "羊祜", "杜预", "王浚", "唐彬",
//            "郭淮", "许褚", "典韦", "张辽", "臧霸", "鲜于辅", "徐质", "徐晃", "王基", "文聘", "张郃", "胡遵", "孙观", "吕虔", "乐进", "于禁", "朱灵", "车胄", "徐邈", "李通",
//            "孙礼", "陈骞", "申仪", "申耽", "庞德", "庞会", "李典", "吕昭", "阎柔", "贾逵", "田豫", "秦朗", "王双", "高览", "郭嘉", "贾诩", "蒋济", "满宠", "辛敞", "程昱",
//            "钟繇", "华歆", "王朗", "王肃", "贾充", "杜畿", "杜袭", "傅嘏", "毛玠", "杨彪", "刘劭", "山涛", "郭修", "王戎", "韩暨", "董昭", "陈矫", "荀攸", "荀彧", "荀顗",
//            "温恢", "护羌校尉", "张既", "李立", "刘馥", "刘晔", "孔融", "孟建", "卫瓘", "陈登", "华表", "观阳伯", "杨济", "张华", "裴秀", "高堂隆", "蒯越", "杨阜", "李丰", "徐奕",
//            "邢颙", "薛悌", "鲍勋", "冯紞", "许攸", "陈群", "陈泰", "何晏", "刘靖", "丁仪", "丁廙", "向秀", "管宁", "杨修", "刘桢", "傅干", "石韬", "蒋干", "管辂", "杜夔",
//            "王粲", "徐干", "陈琳", "阮咸", "阮瑀", "阮籍", "应玚", "嵇康", "刘伶", "老王", "刘备", "刘禅", "刘永", "刘理", "刘谌", "诸葛亮", "武乡侯", "庞统", "关羽", "张飞",
//            "阆中牧", "赵云", "马超", "黄忠", "姜维", "魏延", "马岱", "关兴", "张苞", "关平", "廖化", "张翼", "王平", "陈到", "吴懿", "吴班", "李严", "胡济", "蒋斌", "诸葛瞻",
//            "罗宪", "马忠", "李恢", "刘敏", "邓芝", "张嶷", "高翔", "辅匡", "阎宇", "句扶", "向宠", "刘琰", "赵统", "杨戏", "诸葛乔", "刘邕", "邓方", "霍弋", "李球", "赵累",
//           "黄权", "傅佥", "刘封", "霍峻", "冯习", "张南", "刘巴", "吕乂", "黄崇", "张遵", "陈式", "严颜", "徐庶", "蒋琬", "费祎", "董厥", "陈祗", "李福", "法正", "宗预",
//           "向朗", "王连", "费观", "孙乾", "简雍", "糜竺", "来敏", "伊籍", "杨洪", "张裔", "董允", "卫继", "李撰", "杨颙", "谯周", "张绍", "邓良", "郤正", "廖立", "王甫",
//            "杨仪", "费诗", "杜微", "五梁", "刘豹", "向举", "尹默", "董和", "许靖", "马良", "王谋", "杜琼", "秦宓", "孟光", "许慈", "何宗", "韩冉", "周群", "陈震", "程畿",
//            "樊建", "殷观", "陈寿", "孟达", "射援", "射坚", "李密", "吕凯", "庞宏", "王伉", "马谡", "彭羕", "黄皓", "老湿", "孙权", "孙亮", "孙休", "孙皓", "孙坚", "孙策",
//            "孙和", "孙邵", "孙峻", "顾雍", "陆逊", "步鹭", "滕胤", "张悌", "周瑜", "鲁肃", "吕蒙", "孙韶", "孙桓", "孙静", "孙瑜", "孙皎", "孙贲", "孙翊", "朱然", "全琮",
//            "程普", "甘宁", "周泰", "蒋钦", "丁奉", "徐盛", "潘璋", "诸葛靓", "留赞", "施绩", "吕岱", "朱治", "鲁淑", "虞汜", "贺齐", "张承", "钟离牧", "太史慈", "韩当", "沈莹",
//            "黄盖", "祖茂", "凌统", "董袭", "陈武", "吕范", "步阐", "步玑", "楼玄", "张昭", "张休", "华核", "胡综", "陆抗", "阚泽", "是仪", "桓阶", "全尚", "潘浚", "顾谭",
//            "士燮", "朱据", "陆景", "骆统", "严畯", "诸葛诞", "诸葛瑾", "诸葛恪", "陆绩", "张纮", "张温", "虞翻", "刘基", "程秉", "薛综", "吾粲", "叫兽", "校长"
//];
var DefName = ["观众"];
if (!userName) {
    //userName = DefName[parseInt(Math.random() * (DefName.length - 1) + 0.5)];
    userName = DefName[parseInt(Math.random() * (DefName.length - 1) + 0.5)] + parseInt(Math.random() * 10000 + 1);
}
if (manager) {
//  userName += "老师";
}
if (userName.length > 12) {
    userName = userName.substr(0, 12);
    alert("用户名大于12个字符，已被截断");
}
var dmsSKey = getQueryStr("dmsSKey");
function initTIS(handler) {
    var tisTimestamp = new Date().getTime() + "";
    tisTimestamp = tisTimestamp.length > 10 ? tisTimestamp.substr(tisTimestamp.length - 10) : tisTimestamp;
    var tisClientId = userName + "_" + tisTimestamp + parseInt(10000 + Math.random() * 90000);
    window.getTisClientId = function () { return tisClientId }
    var api = TISAPI.New('./tis/tis_interface.php', { tisId: tisId }, false);
    window.tis = TIS(".tis-container", {
        api: api,                               //必须
        clientid: tisClientId,                  //可选，默认随机生成
        name: userName,                           //可选，默认为Anonymous
        image: "http://cdn.aodianyun.com/tis/ui/default/img/anonymous.png",          //可选，默认未定义
        defaultFacesPath: "images/faces/",    //可选，默认为/images/faces/
        generateUserEvent: true,             //可选，默认为true
        template: tis_default_ui,     //界面模版
        //以下均可选
        failure: function (error, when) {       //某个操作失败时调用
            if (typeof error != "string") {
                if (when == "sendMsg" && error.code == 400 && error.error == "instance closed") {
                    alert("TIS实例已关闭");
                    return;
                }
                alert(when + "操作失败");
            } else {
                alert("操作失败：" + error);
            }
        },
        onSendSuccess: function (data) {
            //当发送消息成功时调用
            console.log("消息发送成功");
        },
        onReconnect: function () {
            //当需要与服务器重新连接时调用
            console.log("正在与服务器重连");
        },
        onConnect: function (data) {
            //当与服务器连接成功时调用
            tisClientId = data.clientId;
            getUserList(data.clientId, data.topic);
            console.log("与服务器重连接成功:", data.clientId + ":" + data.topic);
        },
        onLoadComponent: function () {
            //当组件加载完成时调用
            console.log("组件加载完成");
        },
        updateUser: function (total, clientId, state) {
            //当generateUserEvent=true,并且在线人数发生变化时调用
            console.log("在线人数:", total);
            $("#topTotalLabel").html(total);
            if (state == 1) {
                appendUserList(clientId, "updateUser");
            } else {
                $('.userList div[cltId="' + encodeURIComponent(clientId) + '"]').remove();
                delete userMap[clientId];
            }
            handler.updateUser(total, clientId, state);
        }
    });
    $("#topNameLabel").html(userName);
}
function getNameFromClientId(clientId) {
    var idx = clientId.lastIndexOf("_");
    if (idx <= 0) {
        return "匿名";
    }
    return $('<div />').text(clientId.substr(0, idx)).html();
}
function appendUserList(clientId, from) {
    var name = getNameFromClientId(clientId);
    if (!userMap[clientId]) {
        userMap[clientId] = name;
        $(".userList").append('<div cltId="' + encodeURIComponent(clientId) + '"><img src="../themes/live/images/anonymous.png" /><span>' + name + '</span></div>');
    } else if (userMap[clientId] != name) {
        $('.userList div[cltId="' + encodeURIComponent(clientId) + '"]').html('<img src="../themes/live/images/anonymous.png" /><span>' + name + '</span>');
    }
}
//获取在线用户列表
function onlineList(topic, option, skip, num) {
    skip = skip ? skip : 0;
    num = num ? num : 1000;
    var url = "./tis/userList.php?method=userList&topic=" + encodeURIComponent(topic) + "&skip=" + skip + "&num=" + num +
        "&dmsSKey=" + dmsSKey + "&timestamp=" + new Date().getTime();
    $.ajax({
        type: "GET",
        timeout: 8000,
        url: url,
        success: option.success,
        error: option.failure
    });
}
function getUserList(clientId, topic) {
    onlineList(topic, {
        success: function (data) {
            data = JSON.parse(data);
            if (data.code == 401 && data.error == "not authed") {
                alert("获取用户列表失败，无效的dmsSKey");
                return;
            }
            console.log("onlineList:", data);
            var size = data.total;
            var list = data.list;
            for (var i = 0 ; i < size; i++) {
                appendUserList(list[i], "onlineList");
                console.log(list[i]);
            }
        },
        failure: function (error) {
            alert("加载在线用户信息失败");
            console.log("加载在线用户信息失败:", error);
        }
    });
}

/****************************************** LSS直播相关 ******************************************/
//发布播放相关的参数
var micList = {};
var curMicId = null, curLssApp = null, curLssStream = null;
var lssApp = getQueryStr("lssApp");
var lssStream = getQueryStr("lssStream");
var adUserId = getQueryStr("uid");
var thApp = getQueryStr("thApp");
var thStream = getQueryStr("thStream");
lssApp = lssApp ? lssApp : "wsp_22279_1468819260";   //学生端lssApp
lssStream = lssStream ? lssStream : "stream";      //学生端lssStream
thApp = thApp ? thApp : "wsp_22279_1468819260";      //教师端thApp
thStream = thStream ? thStream : "stream";         //教师段thStream
adUserId = adUserId ? adUserId : "22279";            //奥点云帐号Id
var lssPublishAddr = "rtmp://" + adUserId + ".lsspublish.aodianyun.com";
var lssPlayAddr = "rtmp://" + adUserId + ".lssplay.aodianyun.com";
var thPlay = lssPlayAddr + "/" + thApp + "/" + thStream;
var thHlsPlay = "http://" + adUserId + ".hlsplay.aodianyun.com/" + thApp + "/" + thStream + ".m3u8";
var thPublish = lssPublishAddr + "/" + thApp + "/" + thStream;
//发送下麦消息
function sendOffMic() {
    sendCustomMessage({
        msg: "{'msgType':'offMic','clientId':'" + curMicId + "'}",
        success: function () {
            console.log("发送结束消息成功");
        },
        error: function (error) {
            console.log("发送结束消息失败:", error);
        }
    });
}
//发送上麦消息
function sendOnMic(cltId, app, stream) {
    sendCustomMessage({
        msg: "{'msgType':'onMic','clientId':'" + cltId + "','app':'" + app + "','stream':'" + stream + "'}",
        success: function () {
            console.log("发送上麦消息成功");
        },
        error: function (error) {
            console.log("发送上麦消息失败:", error);
        }
    });
}
//教师端点击发言
function startPlay(cltId, app, stream) {
    var url = "micFrame.html?addr=" + encodeURIComponent(lssPlayAddr) + "&app=" + app + "&stream=" + stream + "&volume=" + voiceSlider.value + "&mode=play";
    $("#micFrame").attr('src', url);
    $("#micFrameWrap").show();
    $(".micList").hide();
    sendOnMic(cltId, app, stream);
    curMicId = cltId;
    curLssApp = app;
    curLssStream = stream;
    $("#curMicIdLabel").html(getNameFromClientId(curMicId));
    $(".micWindow .clearMicList").html("结束发言");
}
//收到上下麦的消息
function onMic(data) {
    if (manager || curMicId) return;
    var url;
    if (data.clientId == getTisClientId()) {
        url = "micFrame.html?addr=" + encodeURIComponent(lssPublishAddr) + "&app=" + data.app + "&stream=" + data.stream + "&volume=" + voiceSlider.value + "&mode=publish";
        console.log("我正在发言");
        $(".micWindow .clearMicList").show();
    } else {
        url = "micFrame.html?addr=" + encodeURIComponent(lssPlayAddr) + "&app=" + data.app + "&stream=" + data.stream + "&volume=" + voiceSlider.value + "&mode=play";
        console.log("有学生正在发言");
    }
    switchTab(document.getElementById("micTabBtn"), '#tabBody4');
    curMicId = data.clientId;
    $("#micFrame").attr('src', url);
    $("#micFrameWrap").show();
    $(".micList").hide();
    $("#curMicIdLabel").html(getNameFromClientId(curMicId));
}
function offMic(data) {
    if (data.clientId == curMicId) {
        $("#micFrame").attr('src', '');
        $("#micFrameWrap").hide();
        $(".micList").show();
        $('.micList div[clientId="' + encodeURIComponent(curMicId) + '"]').remove();
        delete micList[curMicId];
        curMicId = null;
        curLssApp = null;
        curLssStream = null;
        if (manager) {
            $(".micWindow .clearMicList").html("清除列表");
        } else {
            $(".micWindow .clearMicList").hide();
        }
        $("#curMicIdLabel").html("");
    }
}
function onMicListClear(data) {
    offMic({ clientId: curMicId });
    $(".micList").html("");
    micList = {}
}
function onHandUp(data) {
    if ($(".micList").children().length < 10 && !micList[data.clientId]) {
        micList[data.clientId] = true;
        var html = '<div clientId="' + encodeURIComponent(data.clientId) + '"><img src="images/anonymous.png" /><span>' + getNameFromClientId(data.clientId) + '</span>' + 
        (manager ? ('<a onclick="startPlay(\'' + data.clientId + "','" + data.app + "','" + data.stream + "'" + ');">发言</a></div>') : ('</div>'))
        $(".micList").append(html);
    }
}
function initLSS() {
    if (manager) {
        $(".micWindow .clearMicList").live("click", function () {
            if (curMicId != null) {
                sendOffMic();
            } else {
                sendCustomMessage({
                    msg: "{'msgType':'clearMic','clientId':'" + getTisClientId() + "'}",
                    success: function () {
                        console.log("发送清麦消息成功");
                    },
                    error: function (error) {
                        console.log("发送清麦消息失败:", error);
                    }
                });
            }
        });
    } else {
        $(".micWindow .clearMicList").live("click", function () {
            if (curMicId != getTisClientId()) {
                alert("您当前不是发言者");
                return;
            }
            sendOffMic();
        });
    }
}

/****************************************** 初始化 ******************************************/
$(function () {
    initWIS({
        onCustomMessage: {
            handUp: onHandUp,
            clearMic: onMicListClear,
            onMic: onMic,
            offMic: offMic
        }
    });
    initTIS({
        updateUser: function (total, clientId, state) {
            if (state == 1) {
                //有新用户上线，再发送上麦消息
                if (curMicId == null || !manager) return;
                var timerId = setInterval(function () {
                    if (curMicId == null || !manager) return;
                    sendOnMic(curMicId, curLssApp, curLssStream);
                    clearInterval(timerId);
                }, 1000);
            }
        }
    });
    initLSS();
});

