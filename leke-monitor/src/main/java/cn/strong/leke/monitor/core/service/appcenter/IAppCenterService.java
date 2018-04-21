/**
 * 
 */
package cn.strong.leke.monitor.core.service.appcenter;

import cn.strong.leke.monitor.core.model.appcenter.PadSystemReport;

/**
 * 应用中心服务接口
 * 
 * @author liulongbiao
 *
 */
public interface IAppCenterService {

	/**
	 * 保存PAD系统报告
	 * 
	 * @param report
	 */
	void savePadSystemReport(PadSystemReport report);

}