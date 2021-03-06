<%@ page pageEncoding="UTF-8"%>
<%@ include file="/pages/common/tags.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>新增统计-乐课网</title>
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
						<label for="" class="title">学校名称：</label>
						<input class="u-ipt u-ipt-nm" type="text" name="schoolName" id="schoolName" autocomplete="off" />
						<div class="operation">
							<input class="u-btn u-btn-nm u-btn-bg-turquoise f-mr10" id="find" value="查询" type="submit">
							<input class="f-fr u-btn u-btn-nm u-btn-bg-orange f-mr10" value="导出" data-bind="click:classExport">
						</div>
						<div class="f-mt15">
							<label class="title" for="">统计时间：</label>
							<input class="u-ipt u-ipt-nm Wdate" type="text" id="statisticsTimeStart" name="statisticsTimeStart" value="${dateStart }" />
							<label for="" class="title f-ml5 f-mr5">至</label>
							<input class="u-ipt u-ipt-nm Wdate" type="text" id="statisticsTimeEnd" name="statisticsTimeEnd" value="${dateEnd }" />
						</div>
					</form>
				</div>
				<div class="f-mt20 bgwhite">
					<h3 class="tabtitle">
						新增统计 <i class="queries" title="新增学生数：统计时间新导入的学生数。&#13;
作业系统新增学生数：在统计时间内历史第一次使用作业系统的学生数。&#13;
新增购课人数：在统计时间内，历史第一次购买课程的人数(默认统计学生)"></i>
					</h3>
					<div class="m-table m-table-center f-mb0 m-fixedtable">
						<table>
							<thead>
								<tr>
									<th>学校名称</th>
									<th>学段</th>
									<th>营销处</th>
									<th>新增学生数</th>
									<th>作业系统新增学生数</th>
									<th>新增购课人数</th>
									<th width="14%">操作区</th>
								</tr>
							</thead>
							<tbody id="j_bodyComments">
							</tbody>
						</table>
					</div>
					<div class="page" id="divPage"></div>
				</div>
			</div>
		</div>
	</div>
</body>
<script id="j_tempComments" type="x-mustache">
{{#dataList}}
<tr>
<td>{{schoolName}}</td>
<td>{{schoolStageName}}</td>
<td>{{marketName}}</td>
<td>{{studentNum}}</td>
<td>{{workStudentNum}}</td>
<td>{{buyNum}}</td>
<td class="operation blocka">
<a onclick="window.open('newStudent.htm?spm=112004&schoolStageId={{schoolStageId}}&schoolId={{schoolId}}&statisticsTimeStart={{statisticsTimeStart}}&statisticsTimeEnd={{statisticsTimeEnd}}')" href="#">新增学生明细</a>
<a onclick="window.open('workNewStudent.htm?spm=112004&schoolStageId={{schoolStageId}}&schoolId={{schoolId}}&statisticsTimeStart={{statisticsTimeStart}}&statisticsTimeEnd={{statisticsTimeEnd}}')" href="#">作业新增明细</a>
</td>
</tr>
{{/dataList}}
</script>
<script type="text/javascript">
window.data={
		schoolStageStr:${schoolStageStr}
};
	seajs.use('monitor/pages/common/crm/workStatistics');
</script>
</html>