/**
 * 
 */
package cn.strong.leke.monitor.mongo.appcenter.model;

import java.util.Date;

import cn.strong.leke.data.mongo.annotations.ObjectId;
import cn.strong.leke.data.mongo.annotations._id;

/**
 * 用户和 imei 关联表
 * 
 * @author liulongbiao
 *
 */
public class UserImei {

	@_id
	@ObjectId
	private String id;
	private String userId; // 用户ID
	private String imei; // 移动设备识别码
	private Date ts; // 最后更新时间

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getImei() {
		return imei;
	}

	public void setImei(String imei) {
		this.imei = imei;
	}

	public Date getTs() {
		return ts;
	}

	public void setTs(Date ts) {
		this.ts = ts;
	}

}
