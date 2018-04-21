/**
 * 
 */
package cn.strong.leke.monitor.core.service.online;

import cn.strong.leke.monitor.core.model.DeviceHeartbeat;

/**
 * 设备在线用户服务
 * 
 * @author liulongbiao
 *
 */
public interface IDeviceOnlineUserService {

	/**
	 * 保存设备在线心跳
	 * 
	 * @param hb
	 */
	void saveHeartbeat(DeviceHeartbeat hb);

}
