/**
 * 
 */
package cn.strong.leke.monitor.mongo.appcenter.dao;

import java.util.List;

import cn.strong.leke.monitor.mongo.appcenter.model.UserImei;

/**
 * 用户和 imei 关联信息 DAO
 * 
 * @author liulongbiao
 *
 */
public interface IUserImeiDao {

	/**
	 * 保存用户和 imei 关联
	 * 
	 * @param userId
	 * @param imei
	 */
	void save(String userId, String imei);

	/**
	 * 根据 用户ID 获取 UserImei 列表(按时间倒序排列)
	 * 
	 * @param userId
	 * @return
	 */
	List<UserImei> findByUser(String userId);
}
