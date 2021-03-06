/**
 * 
 */
package cn.strong.leke.monitor.mongo.appcenter.model;

import java.util.Date;
import java.util.List;

import cn.strong.leke.data.mongo.annotations._id;

/**
 * 系统应用信息
 * 
 * @author liulongbiao
 *
 */
public class PadSystem {

	@_id
	private String imei; // 移动设备识别码
	private String version; // 操作系统版本号
	private Boolean rooted; // 是否被 root
	private List<App> apps; // 安装的应用列表
	private Date ts; // 最后更新时间

	public String getImei() {
		return imei;
	}

	public void setImei(String imei) {
		this.imei = imei;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public Boolean getRooted() {
		return rooted;
	}

	public void setRooted(Boolean rooted) {
		this.rooted = rooted;
	}

	public List<App> getApps() {
		return apps;
	}

	public void setApps(List<App> apps) {
		this.apps = apps;
	}

	public Date getTs() {
		return ts;
	}

	public void setTs(Date ts) {
		this.ts = ts;
	}

	/**
	 * 是否是 3 代平板
	 * 
	 * @return
	 */
	public boolean wasGen3() {
		return version != null && version.endsWith("student");
	}

	/**
	 * 应用信息
	 * 
	 * @author liulongbiao
	 *
	 */
	public static class App {
		private String pkgName; // 包名
		private String appName; // 应用名

		public String getPkgName() {
			return pkgName;
		}

		public void setPkgName(String pkgName) {
			this.pkgName = pkgName;
		}

		public String getAppName() {
			return appName;
		}

		public void setAppName(String appName) {
			this.appName = appName;
		}
	}
}
