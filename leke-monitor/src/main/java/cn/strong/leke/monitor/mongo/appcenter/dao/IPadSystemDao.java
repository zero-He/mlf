/**
 * 
 */
package cn.strong.leke.monitor.mongo.appcenter.dao;

import cn.strong.leke.monitor.mongo.appcenter.model.PadSystem;

/**
 * PAD 系统信息 DAO
 * 
 * @author liulongbiao
 *
 */
public interface IPadSystemDao {

	/**
	 * 保存 PadSystem 信息
	 * 
	 * @param sys
	 */
	void save(PadSystem sys);

	/**
	 * 获取 PadSystem 信息
	 * 
	 * @param imei
	 * @return
	 */
	PadSystem getByImei(String imei);
}
