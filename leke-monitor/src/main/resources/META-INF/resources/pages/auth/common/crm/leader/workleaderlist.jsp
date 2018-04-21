<%@ page pageEncoding="UTF-8"%>
<%@ include file="/pages/common/tags.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
						<c:if test="${roleId!=603 && roleId!=604 }">
							<label for="" class="title f-ml0">营销处：</label>
							<select name="marketId" class="u-select u-select-nm" id="marketId">
								<option value="">全部</option>
								<c:forEach var="item" items="${secondDpt }">
									<option value="${item.id }">${item.name }</option>
								</c:forEach>
							</select>
						</c:if>

						<c:if test="${roleId==604 }">
							<label for="" class="title f-ml0">营销部：</label>
							<select name="market" class="u-select u-select-nm" id="market" data-bind="event:{change:marketChange}">
								<option value="">全部</option>
								<c:forEach var="item" items="${firstDpt }">
									<option value="${item.id }">${item.name }</option>
								</c:forEach>
							</select>

							<label for="" class="title f-ml0">营销处：</label>
							<select name="marketId" class="u-select u-select-nm" id="marketId"
								data-bind="options:dptData,
                                                       optionsText:'name',
                                                       optionsValue:'id', optionsCaption:'全部'">
							</select>
						</c:if>

						<label for="" class="title f-ml0">乐号：</label>
						<input class="u-ipt u-ipt-nm" type="text" name="lekeSn" id="lekeSn" />
						<label for="" class="title f-ml0">客户经理：</label>
						<input class="u-ipt u-ipt-nm" type="text" name="sellerName" id="sellerName" />
						<c:if test="${roleId!=604 }">
							<label class="title" for="">学段：</label>
							<select name="schoolStageId" class="u-select u-select-nm" id="schoolStageId"
								data-bind="options:schoolStageData,
                                                       optionsText:'schoolStageName',
                                                       optionsValue:'schoolStageId',
                                                       optionsCaption:'请选择'">
							</select>
						</c:if>
						<div class="operation">
							<input class="u-btn u-btn-nm u-btn-bg-turquoise f-mr10" id="find" value="查询" type="submit">
							<a class="f-fr u-btn u-btn-nm u-btn-bg-orange f-mr15" data-bind="click:classExport">导出</a>
						</div>
						<div class="f-mt15">
							<c:if test="${roleId==604 }">
								<label class="title" for="">学段：</label>
								<select name="schoolStageId" class="u-select u-select-nm" id="schoolStageId"
									data-bind="options:schoolStageData,
                                                       optionsText:'schoolStageName',
                                                       optionsValue:'schoolStageId',
                                                       optionsCaption:'请选择'">
								</select>
							</c:if>
							<label class="title" for="">学校：</label>
							<input class="u-ipt u-ipt-nm" type="text" name="schoolName" id="schoolName" autocomplete="off" />
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
									<th>乐号</th>
									<th>客户经理</th>
									<c:if test="${roleId!=603 }">
										<th>营销处</th>
									</c:if>
									<th>学校名称</th>
									<th>学段</th>
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
<td>{{lekeSn}}</td>
<td>{{sellerName}}</td>
<c:if test="${roleId!=603 }">
<td>{{marketName}}</td>
</c:if>
<td>{{schoolName}}</td>
<td>{{schoolStageName}}</td>
<td>{{studentNum}}</td>
<td>{{workStudentNum}}</td>
<td>{{buyNum}}</td>
<td class="operation blocka">
<a onclick="window.open('leaderStudent.htm?spm=112004&sellerName={{sellerName}}&marketName={{marketName}}&schoolStageId={{schoolStageId}}&schoolId={{schoolId}}&statisticsTimeStart={{statisticsTimeStart}}&statisticsTimeEnd={{statisticsTimeEnd}}')" href="#">新增学生明细</a>
<a onclick="window.open('workLeaderStudent.htm?spm=11200&sellerName={{sellerName}}&marketName={{marketName}}&schoolStageId={{schoolStageId}}&schoolId={{schoolId}}&statisticsTimeStart={{statisticsTimeStart}}&statisticsTimeEnd={{statisticsTimeEnd}}')" href="#">作业新增明细</a>
</td>
</tr>
{{/dataList}}
</script>
<script type="text/javascript">
window.data={
		schoolStageStr:${schoolStageStr},
		areas:${areas}
};
	seajs.use('monitor/pages/common/crm/leader/workleaderlist');
</script>
</html>