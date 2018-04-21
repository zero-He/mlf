define(function(require, exports, module) {
	var $ = require('jquery');
	var Mustache = require('mustache');
	var Page = require('page');
	var Utils = require('utils');
	var Dialog = require('dialog');
	var LekeDate = require('common/base/date');
	var http = require('common/base/http');
	var utils = require('utils');
	var ko = require('knockout');
	var WdatePicker = require('date');
	require('common/ui/ui-autocomplete/ui-autocomplete');

	// 定义ViewModel
	function ViewModel() {
		var self = this;

		// 添加动态监视数组对象
		self.schoolStageData = ko.observableArray(window.data.schoolStageStr);

		// 查询条件
		self.findSellerName = ko.observable();
		self.findSchoolId = ko.observable();
		self.findStatisticsTimeStart = ko.observable();
		self.findStatisticsTimeEnd = ko.observable();

		// 学校自动完成控件
		self.$sch = $('#schoolName');
		self.$sch.autocomplete({
					url : Leke.ctx + '/auth/common/data/querySchoolLike.htm',
					nameKey : 'schoolName',
					onChange : function(school) {
						if (school != null) {
							$("#schoolId").val(school.schoolId);
						} else {
							$("#schoolId").val("");
						}
					}
				});

		// 导出
		self.classExport = function() {
			var condition = new Object();
			if (self.findSellerName() != "") {
				condition.sellerName = self.findSellerName();
			}

			if (self.findSchoolId() != "") {
				condition.schoolId = self.findSchoolId();
			}

			if (self.findStatisticsTimeStart() != "") {
				condition.statisticsTimeStart = self.findStatisticsTimeStart();
			}

			if (self.findStatisticsTimeEnd() != "") {
				condition.statisticsTimeEnd = self.findStatisticsTimeEnd();
			}

			var data = JSON.stringify(condition || {});

			window.location.href = Leke.ctx
					+ '/auth/common/crm/workStatisticsExport.htm?dataJson='
					+ data;
		}
	}

	var vm = new ViewModel();

	var win = {
		init : function() {
			this.statisticsTimeStartBind();
			this.statisticsTimeEndBind();
			utils.Notice.mask.create("正在查询请稍等");
			this.loadData();
			this.findClick();
		},
		statisticsTimeStartBind : function() {
			$('#statisticsTimeStart').focus(function() {
						WdatePicker({
									dateFmt : 'yyyy-MM-dd',
									maxDate : '#F{$dp.$D(\'statisticsTimeEnd\')}',
									readOnly : true
								});
					})
		},
		statisticsTimeEndBind : function() {
			$('#statisticsTimeEnd').focus(function() {
						WdatePicker({
									dateFmt : 'yyyy-MM-dd',
									minDate : '#F{$dp.$D(\'statisticsTimeStart\')}',
									readOnly : true
								});
					})
		},
		findClick : function() {
			$("#find").click(function() {
						$("#isFind").val("1");
						utils.Notice.mask.create("正在查询请稍等");
					})
		},
		loadData : function() {
			var _this = this;
			_this.page = Page.create({
				id : 'divPage',
				url : '/auth/common/crm/workStatisticsListPage.htm',
				curPage : 1,
				pageSize : 10,
				pageCount : 10,// 分页栏上显示的分页数
				formId : 'form',
				tipsId : "jTipsId",
				callback : function(datas) {
					utils.Notice.mask.close();
					// 数据处理，渲染表格
					var page = datas.page;
					page.starStr = function() {
						return _this.getStarHtml(this.star + 0.0);
					}
					page.starInfo = function() {
						return _this.getStarInfo(this.star);
					}

					vm.findSellerName($("#sellerName").val());
					vm.findSchoolId($("#schoolId").val());
					vm.findStatisticsTimeStart($("#statisticsTimeStart").val());
					vm.findStatisticsTimeEnd($("#statisticsTimeEnd").val());

					page.statisticsTimeStart = function() {
						return $("#statisticsTimeStart").val();
					}

					page.statisticsTimeEnd = function() {
						return $("#statisticsTimeEnd").val();
					}

					var output = Mustache.render($("#j_tempComments").html(),
							page);
					$('#j_bodyComments').html(output);

				}
			});
		}
	}

	win.init();
	ko.applyBindings(vm);
});