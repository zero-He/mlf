<%@ page pageEncoding="UTF-8"%>
<%@ include file="/pages/common/tags.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>课堂用户监控- 乐课网</title>
    <%@ include file="/pages/common/meta.jsp"%>
    <link rel="stylesheet" href="${assets}/styles/monitor/monitor.css" type="text/css">
    <link rel="stylesheet" href="${assets}/styles/home/personal-center.css" type="text/css">
</head>

<%@ include file="/pages/header/header.jsp"%>
<div class="g-bd"> 
    <%@ include file="/pages/navigate/navigate.jsp"%>
    <div class="g-mn z-personal-mn">
        <div>
            <div class="z-percenter-mn-wrap">
                <!-- 技术支持 -->
                <div class="support f-pt20">
                    <div class="do-count" data-bind="component:{
                    	name:'technical-support-total',
                    	params:{
                    		options:{
                    			postUrl:'/auth/technicalSupport/course/currentPlatformCourseStat.htm?callback=?'
                    		}
                    	}
                    }">
                    </div>
                </div>
                <div data-bind="component: {
					name: 'clazzroom-echart',
					params: {
							options: {
								roleId: Leke.user.currentRoleId,
								postUrl: '/auth/technicalSupport/course/findCourseSnapshotStats.htm'
							}
						}
					}"></div>
            </div>
        </div>
    </div>
</div>
<script src="${ctx}/scripts/common/ui/ui-echarts/echarts-plain.js"></script>
<script type="text/javascript">
seajs.use('monitor/pages/technicalSupport/course/clazzroomView');
</script>
</body>
</html>