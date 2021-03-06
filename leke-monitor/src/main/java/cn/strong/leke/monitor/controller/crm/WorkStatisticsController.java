package cn.strong.leke.monitor.controller.crm;

import java.time.LocalDate;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.strong.leke.common.serialize.support.json.JsonUtils;
import cn.strong.leke.context.base.SchoolContext;
import cn.strong.leke.context.base.SchoolStageContext;
import cn.strong.leke.context.user.UserContext;
import cn.strong.leke.core.office.ExportExcelForTable;
import cn.strong.leke.framework.page.jdbc.Page;
import cn.strong.leke.framework.web.JsonResult;
import cn.strong.leke.model.base.School;
import cn.strong.leke.model.user.Role;
import cn.strong.leke.model.user.User;
import cn.strong.leke.monitor.core.model.WorkStatistics;
import cn.strong.leke.monitor.core.service.IClassStatisticsService;
import cn.strong.leke.monitor.core.service.IWorkStatisticsService;
import cn.strong.leke.monitor.util.FileUtils;

/**
 * @ClassName: WorkStatisticsController
 * @Description: 作业系统新增统计控制器层接口
 * @author huangkai
 * @date 2016年11月22日 下午3:11:39
 * @version V1.0
 */
@Controller
@RequestMapping("/auth/common/crm/*")
public class WorkStatisticsController
{
	@Resource
	private IWorkStatisticsService workStatisticsService;

	@Resource
	private IClassStatisticsService classStatisticsService;

	/**
	 * @Description: 作业系统新增统计列表
	 * @param mode
	 * @throws
	 */
	@RequestMapping("workStatisticsList")
	public String workStatisticsList(Model model)
	{
		User user = UserContext.user.get();

		Role role = user.getCurrentRole();
		if (role.getId().equals(600L) || role.getId().equals(601L) || role.getId().equals(602L)
				|| role.getId().equals(603L) || role.getId().equals(604L))
		{
			return "redirect:/auth/common/crm/leader/workleaderlist.htm";
		}

		LocalDate localDate = LocalDate.now();

		model.addAttribute("schoolStageStr", JsonUtils.toJSON(classStatisticsService.getSchoolStage()));
		model.addAttribute("dateEnd", localDate);
		model.addAttribute("dateStart", localDate.minusMonths(1));

		return "/auth/common/crm/workStatisticsList";
	}

	/**
	 * @Description: 作业系统新增统计分页
	 * @param workStatistics
	 * @param page（分页）
	 * @return JsonResult
	 * @throws
	 */
	@RequestMapping("workStatisticsListPage")
	@ResponseBody
	public JsonResult workStatisticsListPage(WorkStatistics workStatistics, Page page, String isFind)
	{
		JsonResult jsonResult = new JsonResult();

		User user = UserContext.user.get();
		workStatistics.setSellerId(user.getId());

		List<WorkStatistics> listWorkStatistics = workStatisticsService.querySchoolMarket(workStatistics, page);

		page.setDataList(listWorkStatistics);

		jsonResult.addDatas("page", page);

		return jsonResult;
	}

	/**
	 * @Description: 作业系统新增统计导出
	 * @param dataJson
	 * @param request
	 * @param response
	 * @throws Exception    参数
	 * @throws
	 */
	@RequestMapping("workStatisticsExport")
	@ResponseBody
	public void workStatisticsExport(String dataJson, HttpServletRequest request, HttpServletResponse response)
			throws Exception
	{
		WorkStatistics workStatistics = JsonUtils.fromJSON(dataJson, WorkStatistics.class);

		List<WorkStatistics> listWorkStatistics = workStatisticsService.querySchoolMarket(workStatistics, null);

		String[] headers =
		{ "学校名称", "学段", "所属市场", "新增学生数", "作业系统新增学生数", "新增购课人数" };
		String[] fieldNames =
		{ "schoolName", "schoolStageName", "marketName", "studentNum", "workStudentNum", "buyNum" };

		String pattern = "yyyy-MM-dd HH:mm";
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/octet-stream;charset=UTF-8");

		String agent = request.getHeader("user-agent");

		StringBuffer titleSingle = new StringBuffer("");
		titleSingle.append("新增统计");

		String fileName = FileUtils.getEncodingFileName(titleSingle.toString() + ".xls", agent);
		StringBuffer sb = new StringBuffer();
		sb.append("attachment;").append(fileName);
		response.setHeader("Content-disposition", sb.toString());

		new ExportExcelForTable<WorkStatistics>().exportExcel(titleSingle.toString(), headers, fieldNames,
				listWorkStatistics, response.getOutputStream(), pattern);
	}

	/**
	 * @Description: 新增学生明细
	 * @param schoolId（学校ID）
	 * @param statisticsTimeStart（统计时间开始）
	 * @param statisticsTimeEnd（统计时间结束）
	 * @param model 
	 * @throws
	 */
	@RequestMapping("newStudent")
	public void newStudent(Long schoolStageId, Long schoolId, String statisticsTimeStart, String statisticsTimeEnd,
			Model model)
	{
		School school = SchoolContext.getSchoolBySchoolId(schoolId);

		model.addAttribute("gradeStr", JsonUtils.toJSON(classStatisticsService.getGrade(schoolId, null)));
		model.addAttribute("schoolId", schoolId);
		model.addAttribute("schoolName", school.getName());
		model.addAttribute("schoolStageId", schoolStageId);
		model.addAttribute("schoolStageName", SchoolStageContext.getSchoolStage(schoolStageId).getSchoolStageName());
		model.addAttribute("statisticsTimeStart", statisticsTimeStart);
		model.addAttribute("statisticsTimeEnd", statisticsTimeEnd);
	}

	/**
	 * @Description: 新增学生明细数据源
	 * @param workStatistics（作业统计）
	 * @return JsonResult
	 * @throws
	 */
	@RequestMapping("newStudentPage")
	@ResponseBody
	public JsonResult newStudentPage(WorkStatistics workStatistics, Page page)
	{
		JsonResult jsonResult = new JsonResult();

		List<WorkStatistics> listWorkStatistics = workStatisticsService.getNewStudent(workStatistics, page);
		page.setDataList(listWorkStatistics);
		jsonResult.addDatas("page", page);

		return jsonResult;
	}

	/**
	 * @Description: 新增学生明细导出
	 * @param dataJson
	 * @param request
	 * @param response
	 * @throws Exception    参数
	 * @throws
	 */
	@RequestMapping("newStudentExport")
	@ResponseBody
	public void newStudentExport(String dataJson, HttpServletRequest request, HttpServletResponse response)
			throws Exception
	{
		WorkStatistics workStatistics = JsonUtils.fromJSON(dataJson, WorkStatistics.class);

		List<WorkStatistics> listWorkStatistics = workStatisticsService.getNewStudent(workStatistics, null);

		String[] headers =
		{ "乐号", "姓名", "年级", "创建时间" };
		String[] fieldNames =
		{ "lekeSn", "studentName", "gradeName", "useDateStr" };

		String pattern = "yyyy-MM-dd";
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/octet-stream;charset=UTF-8");

		String agent = request.getHeader("user-agent");

		StringBuffer titleSingle = new StringBuffer("");
		titleSingle.append("新增学生明细");

		String fileName = FileUtils.getEncodingFileName(titleSingle.toString() + ".xls", agent);
		StringBuffer sb = new StringBuffer();
		sb.append("attachment;").append(fileName);
		response.setHeader("Content-disposition", sb.toString());

		new ExportExcelForTable<WorkStatistics>().exportExcel(titleSingle.toString(), headers, fieldNames,
				listWorkStatistics, response.getOutputStream(), pattern);
	}

	/**
	 * @Description: 作业系统新增明细
	 * @param schoolId（学校ID）
	 * @param statisticsTimeStart（统计时间开始）
	 * @param statisticsTimeEnd（统计时间结束）
	 * @param model 
	 * @throws
	 */
	@RequestMapping("workNewStudent")
	public void workNewStudent(Long schoolStageId, Long schoolId, String statisticsTimeStart, String statisticsTimeEnd,
			Model model)
	{
		School school = SchoolContext.getSchoolBySchoolId(schoolId);

		model.addAttribute("gradeStr", JsonUtils.toJSON(classStatisticsService.getGrade(schoolId, null)));
		model.addAttribute("schoolId", schoolId);
		model.addAttribute("schoolName", school.getName());
		model.addAttribute("schoolStageId", schoolStageId);
		model.addAttribute("schoolStageName", SchoolStageContext.getSchoolStage(schoolStageId).getSchoolStageName());
		model.addAttribute("statisticsTimeStart", statisticsTimeStart);
		model.addAttribute("statisticsTimeEnd", statisticsTimeEnd);
	}

	/**
	 * @Description: 作业系统新增明细数据源
	 * @param workStatistics（作业统计）
	 * @return JsonResult
	 * @throws
	 */
	@RequestMapping("workNewStudentPage")
	@ResponseBody
	public JsonResult workNewStudentPage(WorkStatistics workStatistics, Page page)
	{
		JsonResult jsonResult = new JsonResult();

		List<WorkStatistics> listWorkStatistics = workStatisticsService.getWorkNewStudent(workStatistics, page);
		page.setDataList(listWorkStatistics);

		jsonResult.addDatas("page", page);

		return jsonResult;
	}

	/**
	 * @Description: 作业系统新增明细导出
	 * @param dataJson
	 * @param request
	 * @param response
	 * @throws Exception    参数
	 * @throws
	 */
	@RequestMapping("workNewStudentExport")
	@ResponseBody
	public void workNewStudentExport(String dataJson, HttpServletRequest request, HttpServletResponse response)
			throws Exception
	{
		WorkStatistics workStatistics = JsonUtils.fromJSON(dataJson, WorkStatistics.class);

		List<WorkStatistics> listWorkStatistics = workStatisticsService.getWorkNewStudent(workStatistics, null);

		String[] headers =
		{ "乐号", "姓名", "年级", "首次使用时间" };
		String[] fieldNames =
		{ "lekeSn", "studentName", "gradeName", "useDateStr" };

		String pattern = "yyyy-MM-dd";
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/octet-stream;charset=UTF-8");

		String agent = request.getHeader("user-agent");

		StringBuffer titleSingle = new StringBuffer("");
		titleSingle.append("作业系统新增明细");

		String fileName = FileUtils.getEncodingFileName(titleSingle.toString() + ".xls", agent);
		StringBuffer sb = new StringBuffer();
		sb.append("attachment;").append(fileName);
		response.setHeader("Content-disposition", sb.toString());

		new ExportExcelForTable<WorkStatistics>().exportExcel(titleSingle.toString(), headers, fieldNames,
				listWorkStatistics, response.getOutputStream(), pattern);
	}
}
