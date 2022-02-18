//动态显示菜单图标 亮/暗 只匹配指定网站
chrome.runtime.onInstalled.addListener(function () {
	chrome.declarativeContent.onPageChanged.removeRules(undefined, function () {
		chrome.declarativeContent.onPageChanged.addRules([
			{
				conditions: [
					// 只有打开百度才显示pageAction
					new chrome.declarativeContent.PageStateMatcher({ pageUrl: { urlContains: 'ph-mmas-admin-open-stg1.paic.com.cn/video/load' } })
				],
				actions: [new chrome.declarativeContent.ShowPageAction()]
			}
		]);
	});
});

//获取网页的url 和 tabId
var myURL = "about:blank";
var myTabId = '';
chrome.tabs.onUpdated.addListener(function (tabId, changeInfo, tab) {
	chrome.tabs.getSelected(null, function (tab) {
		myURL = tab.url;
		myTabId = tabId;
	});
});

//添加右键菜单
chrome.contextMenus.create({
	title: "下载MMAS视频",
	onclick: function () {
		var url = myURL.replace('load', 'download/load');
		//重定向url
		chrome.tabs.update(myTabId, {
			"url": url,
			"selected": true
		});
		// alert('您点击了右键菜单！' + url);
	},
	documentUrlPatterns: ['https://ph-mmas-admin-open-stg1.paic.com.cn/video/load*'] // 只在某些页面显示此右键菜单
});

