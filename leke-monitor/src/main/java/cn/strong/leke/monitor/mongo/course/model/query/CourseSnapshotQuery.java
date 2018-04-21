/**
 * 
 */
package cn.strong.leke.monitor.mongo.course.model.query;

import org.bson.Document;
import org.joda.time.LocalDate;
import org.joda.time.LocalDateTime;

import cn.strong.leke.monitor.util.BsonCriteria;

/**
 * 在线课程统计
 * 
 * @author liulongbiao
 *
 */
public class CourseSnapshotQuery extends BaseAreaSchoolQuery {

	public static final int TYPE_LAST_HOUR = 1;
	public static final int TYPE_TODAY = 2;

	private int type; // 统计时段类型

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public Document toBSON() {
		BsonCriteria filter = new BsonCriteria();

		switch (type) {
		case TYPE_LAST_HOUR:
			LocalDateTime now = LocalDateTime.now();
			filter.gte("ts", now.minusHours(1).minusMinutes(5).toDate()).lt("ts", now.toDate());
			break;
		case TYPE_TODAY:
			LocalDate today = LocalDate.now();
			filter.gte("ts", today.toDate()).lt("ts", today.plusDays(1).toDate());
			break;
		default:
			throw new IllegalStateException("unknown query type : " + type);
		}
		appendAreaSchool(filter);
		return filter;
	}
}
