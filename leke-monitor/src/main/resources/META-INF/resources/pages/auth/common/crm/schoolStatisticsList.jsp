<%@ page pageEncoding="UTF-8"%>
<%@ include file="/pages/common/tags.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>教学统计-乐课网</title>
<%@ include file="/pages/common/meta.jsp"%>
<link rel="stylesheet" href="${assets}/styles/gili/gili.css?t=${_t}" />
<link rel="stylesheet" href="${assets}/scripts/common/ui/ui-scrollbar/skin/default/jquery-scrollbar.css?t=${_t}" />
<link rel="stylesheet" href="${assets}/styles/tutor/common/inputDisabledChange.css?t=${_t}" type="text/css" />
<link rel="stylesheet" href="${assets}/styles/crm/ruzhu.css" type="text/css">
</head>
<body>
	<%@ include file="/pages/header/header.jsp"%>
	<div class="g-bd">
		<%@ include file="/pages/navigate/navigate.jsp"%>
		<div class="g-mn">
			<div class="z-statisticalcenter">
				<div class="m-search-box f-pt15">
					<form id="form">
						<input type="hidden" id="isFind" name="isFind" />
						<input type="hidden" id="schoolId" name="schoolId" autocomplete="off" />
						<label class="title" for="">学段：</label>
						<select name="schoolStageId" class="u-select u-select-nm" id="schoolStageId"
							data-bind="options:schoolStageData,
                                                       optionsText:'schoolStageName',
                                                       optionsValue:'schoolStageId',
                                                       optionsCaption:'请选择'">
						</select>
						<label class="title" for="">学校：</label>
						<input class="u-ipt u-ipt-nm" type="text" name="schoolName" id="schoolName" autocomplete="off" />
						<div class="operation">
							<input class="u-btn u-btn-nm u-btn-bg-turquoise f-mr10" id="find" value="查询" type="submit">
							<a class="f-fr u-btn u-btn-nm u-btn-bg-orange f-mr15" data-bind="click:classExport">导出</a>
						</div>
						<div class="f-mt15">
							<label class="title" for="">统计时间：</label>
							<input class="u-ipt u-ipt-nm Wdate" type="text" id="statisticsTimeStart" name="statisticsTimeStart" value="${dateStart }" />
							<label for="" class="title f-ml5 f-mr5">至</label>
							<input class="u-ipt u-ipt-nm Wdate" type="text" id="statisticsTimeEnd" name="statisticsTimeEnd" value="${dateEnd }" />
						</div>
					</form>
				</div>
				<div class="f-mt20 bgwhite" style="padding:5px;">
					<h3 class="tabtitle">学校课堂统计</h3>
					<div class="m-table m-table-center f-mb0 m-fixedtable">
						<table>
							<thead>
								<tr>
									<th width="10%">学校名称</th>
									<th width="8%">学段</th>
									<th width="12%">已结束课堂数</th>
									<th width="12%">备课课堂数</th>
									<th width="12%">上课课堂数</th>
									<th width="8%">备课率</th>
									<th width="8%">上课率</th>
									<th width="28%">操作区</th>
								</tr>
							</thead>
							<tbody data-bind="foreach: { data: schoolClass }">
								<tr>
									<td data-bind="text:schoolName"></td>
									<td data-bind="text:schoolStageName"></td>
									<td data-bind="text:endClassNum"></td>
									<td data-bind="text:beikeClassNum"></td>
									<td data-bind="text:classNum"></td>
									<td data-bind="text:beikeRate"></td>
									<td data-bind="text:classRate"></td>
									<td class="operation">
										<a data-bind="click:$root.details">详情</a>
										<a data-bind="click:$root.classDetails">课堂明细</a>
										<a data-bind="click:$root.attendance">考勤统计</a>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="page" id="divPage"></div>
				</div>
				<div class="f-mt20 bgwhite" id="beikeDetails" style="display: none;">
					<h3 class="tabtitle">
						课堂明细 <i class="queries" title="1，预习作业绑定率：备有预习作业的&#13;
课堂数/备课课堂数。&#13;
2，课件绑定率：备有课件的课堂数/&#13;
备课课堂数。&#13;
3，随堂作业绑定率：备有随堂作&#13;
业的课堂数/备课课堂数。&#13;
4，作业布置数：布置给学生的作业&#13;
数之和。&#13;
5，随堂测试发起率：发起随堂测试&#13;
课堂数/上课课堂数。&#13;
6，快速问答发起率：发起快速问答&#13;
课堂数/上课课堂数。"></i>
					</h3>
					<div class="m-table m-table-center f-mb0 classdetail">
						<table>
							<tbody>
								<tr>
									<th>学校名称</th>
									<th>学段</th>
									<th colspan="2">课前</th>
									<th colspan="8">课中</th>
									<th colspan="6">课后</th>
								</tr>
								<tr>
									<td></td>
									<td></td>
									<td>
										预习作业 <br>布置份数
									</td>
									<td>
										预习作业 <br>绑定率
									</td>
									<td>课件数</td>
									<td>
										课件 <br>绑定率
									</td>
									<td>
										随堂作业 <br>布置份数
									</td>
									<td>
										随堂作业 <br>绑定率
									</td>
									<td>
										随堂测试 <br>次数
									</td>
									<td>
										随堂测试 <br>发起率
									</td>
									<td>
										快速问答 <br>次数
									</td>
									<td>
										快速问答 <br>发起率
									</td>
									<td>
										课后作业 <br>布置份数
									</td>
									<td>
										作业 <br>布置数
									</td>
									<td>
										作业 <br>提交数
									</td>
									<td>
										作业 <br>批改数
									</td>
									<td>
										作业 <br>提交率
									</td>
									<td>
										作业 <br>批改率
									</td>
								</tr>
								<tr>
									<td data-bind="text:schoolName"></td>
									<td data-bind="text:schoolStageName"></td>
									<td data-bind="text:previewWorkNum"></td>
									<td data-bind="text:previewWorkRate"></td>
									<td data-bind="text:coursewareNum"></td>
									<td data-bind="text:coursewareRate"></td>
									<td data-bind="text:classWorkNum"></td>
									<td data-bind="text:classWorkRate"></td>
									<td data-bind="text:classTestNum"></td>
									<td data-bind="text:classTestRate"></td>
									<td data-bind="text:questionsAnswersNum"></td>
									<td data-bind="text:questionsAnswersRate"></td>
									<td data-bind="text:afterClassWorkNum"></td>
									<td data-bind="text:classWorkTotalNum"></td>
									<td data-bind="text:workFinishNum"></td>
									<td data-bind="text:workcorrectNum"></td>
									<td data-bind="text:workFinishRate"></td>
									<td data-bind="text:workcorrectRate"></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	window.schoolStageStr = ${schoolStageStr};
	window.classStatistics = ${classStatistics};
	seajs.use('monitor/pages/common/crm/schoolStatistics');
</script>
</html>