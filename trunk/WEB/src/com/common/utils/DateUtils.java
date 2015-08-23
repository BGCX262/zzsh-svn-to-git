package com.common.utils;

import java.sql.Time;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import java.text.SimpleDateFormat;  
import java.util.Calendar;  
import java.util.Date;  
  
import org.apache.commons.logging.Log;  
import org.apache.commons.logging.LogFactory;  
  
/** 
 * 
 * @author px 
 * @date 2010-04-26 
 * 
 */  
public class DateUtils {  
  
    private static final Log logger = LogFactory.getLog(DateUtils.class);  
  
    public static final String YYYYMMDD = "yyyy-MM-dd";  
  
    public static final String YYYYMMDD_ZH = "yyyy年MM月dd日";  
  
    public static final int FIRST_DAY_OF_WEEK = Calendar.MONDAY; //中国周一是一周的第一天  
  
    /** 
     * 
     * @param strDate 
     * @return 
     */  
    public static Date parseDate(String strDate) {  
        return parseDate(strDate, null);  
    }  
  
    /** 
     * parseDate 
     * 
     * @param strDate 
     * @param pattern 
     * @return 
     */  
    public static Date parseDate(String strDate, String pattern) {  
        Date date = null;  
        try {  
            if(pattern == null) {  
                pattern = YYYYMMDD;  
            }  
            SimpleDateFormat format = new SimpleDateFormat(pattern);  
            date = format.parse(strDate);  
        } catch (Exception e) {  
            logger.error("parseDate error:" + e);  
        }  
        return date;  
    }  
  
    /** 
     * format date 
     * 
     * @param date 
     * @return 
     */  
    public static String formatDate(Date date) {  
        return formatDate(date, null);  
    }  
  
    /** 
     * format date 
     * 
     * @param date 
     * @param pattern 
     * @return 
     */  
    public static String formatDate(Date date, String pattern) {  
        String strDate = null;  
        try {  
            if(pattern == null) {  
                pattern = YYYYMMDD;  
            }  
            SimpleDateFormat format = new SimpleDateFormat(pattern);  
            strDate = format.format(date);  
        } catch (Exception e) {  
            logger.error("formatDate error:", e);  
        }  
        return strDate;  
    }  
  
    /** 
     * 取得一年的第几周 
     * 
     * @param date 
     * @return 
     */  
    public static int getWeekOfYear(Date date){  
        Calendar c = Calendar.getInstance();  
        c.setTime(date);  
        int week_of_year = c.get(Calendar.WEEK_OF_YEAR);  
        return week_of_year - 1;  
    }  
  
    /** 
     * getWeekBeginAndEndDate 
     * 
     * @param date 
     * @param pattern 
     * @return 
     */  
    public static String getWeekBeginAndEndDate(Date date, String pattern){  
        Date monday = getMondayOfWeek(date);  
        Date sunday = getSundayOfWeek(date);  
        return formatDate(monday, pattern) + " - " + formatDate(sunday, pattern) ;  
    }  
  
    /** 
     * 根据日期取得对应周周一日期 
     * 
     * @param date 
     * @return 
     */  
    public static Date getMondayOfWeek(Date date) {  
        Calendar monday = Calendar.getInstance();  
        monday.setTime(date);  
        monday.setFirstDayOfWeek(FIRST_DAY_OF_WEEK);  
        monday.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);  
        return monday.getTime();  
    }  
  
    /** 
     * 根据日期取得对应周周日日期 
     * 
     * @param date 
     * @return 
     */  
    public static Date getSundayOfWeek(Date date) {  
        Calendar sunday = Calendar.getInstance();  
        sunday.setTime(date);  
        sunday.setFirstDayOfWeek(FIRST_DAY_OF_WEEK);  
        sunday.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);  
        return sunday.getTime();  
    }  
  
    /** 
     * 取得月的剩余天数 
     * 
     * @param date 
     * @return 
     */  
    public static int getRemainDayOfMonth(Date date) {  
        int dayOfMonth = getDayOfMonth(date);  
        int day = getPassDayOfMonth(date);  
        return dayOfMonth - day;  
    }  
  
    /** 
     * 取得月已经过的天数 
     * 
     * @param date 
     * @return 
     */  
    public static int getPassDayOfMonth(Date date) {  
        Calendar c = Calendar.getInstance();  
        c.setTime(date);  
        return c.get(Calendar.DAY_OF_MONTH);  
    }  
  
    /** 
     * 取得月天数 
     * 
     * @param date 
     * @return 
     */  
    public static int getDayOfMonth(Date date) {  
        Calendar c = Calendar.getInstance();  
        c.setTime(date);  
        return c.getActualMaximum(Calendar.DAY_OF_MONTH);  
    }  
  
    /** 
     * 取得月第一天 
     * 
     * @param date 
     * @return 
     */  
    public static Date getFirstDateOfMonth(Date date) {  
        Calendar c = Calendar.getInstance();  
        c.setTime(date);  
        c.set(Calendar.DAY_OF_MONTH, c.getActualMinimum(Calendar.DAY_OF_MONTH));  
        return c.getTime();  
    }  
  
    /** 
     * 取得月最后一天 
     * 
     * @param date 
     * @return 
     */  
    public static Date getLastDateOfMonth(Date date) {  
        Calendar c = Calendar.getInstance();  
        c.setTime(date);  
        c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));  
        return c.getTime();  
    }  
    
    /** 
     * 取得月第一天
     * 
     * @param date 
     * @return 
     */  
    public static Date getFirstDateOfMonthByMonth(int year, int month) {  
        Calendar c = Calendar.getInstance();  
        c.set(Calendar.YEAR, year);
        c.set(Calendar.MONTH, month - 1);
        c.set(Calendar.DATE, 1);
        c.set(Calendar.DAY_OF_MONTH, c.getActualMinimum(Calendar.DAY_OF_MONTH));  
        return c.getTime();  
    }    
    
    /** 
     * 取得月最后一天 
     * 
     * @param date 
     * @return 
     */  
    public static Date getLastDateOfMonthByMonth(int year, int month) {  
        Calendar c = Calendar.getInstance();  
        c.set(Calendar.YEAR, year);
        c.set(Calendar.MONTH, month - 1);
        c.set(Calendar.DATE, 1);
        c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));  
        return c.getTime();  
    }
    
  
    /** 
     * 取得季度第一天 
     * 
     * @param date 
     * @return 
     */  
    public static Date getFirstDateOfSeason(Date date) {  
        return getFirstDateOfMonth(getSeasonDate(date)[0]);  
    }  
  
    /** 
     * 取得季度第某天 
     * 
     * @param year  quarter
     * @return 
     */  
    public static Date getFirstDateOfSeasonByQuarter(int year, int quarter, int offset) {  
    	Calendar c = Calendar.getInstance();  
    	c.set(Calendar.YEAR, year);
    	if (quarter == 1) {
    		c.set(Calendar.MONTH, 0);
    	}
    	
    	if (quarter == 2) {
    		c.set(Calendar.MONDAY, 3);
    	}
    	
    	if (quarter == 3) {
    		c.set(Calendar.MONDAY, 6);
    	}
    	
    	if (quarter == 4) {
    		c.set(Calendar.MONDAY, 9);
    	}    	
    	
    	c.set(Calendar.DATE, 1);
    	Date date = c.getTime();
        Date result =  getFirstDateOfMonth(getSeasonDate(date)[0]);
        Calendar c1 = Calendar.getInstance();  
        c1.setTime(result);  
        
        int day = c1.get(Calendar.DAY_OF_YEAR);
        c1.set(Calendar.DAY_OF_YEAR, day + offset);         
        return c1.getTime();         
    }      
    
    
    /** 
     * 取得季度最后一天 
     * 
     * @param date 
     * @return 
     */  
    public static Date getLastDateOfSeason(Date date) {  
        return getLastDateOfMonth(getSeasonDate(date)[2]);  
    }  
    
    /** 
     * 取得季度某一天 
     * 
     * @param year  quarter
     * @return 
     */  
    public static Date getLastDateOfSeasonByQuarter(int year, int quarter, int offset) {  
    	Calendar c = Calendar.getInstance();  
    	c.set(Calendar.YEAR, year);
    	if (quarter == 1) {
    		c.set(Calendar.MONTH,  Calendar.MARCH);
    	}
    	
    	if (quarter == 2) {
    		c.set(Calendar.MONTH, Calendar.JUNE);
    	}
    	
    	if (quarter == 3) {
    		c.set(Calendar.MONTH, Calendar.SEPTEMBER);
    	}
    	
    	if (quarter == 4) {
    		c.set(Calendar.MONTH, Calendar.DECEMBER);
    	}    	
    	
    	c.set(Calendar.DATE, 1);
    	Date date = c.getTime();

        Date result =  getLastDateOfMonth(getSeasonDate(date)[2]);  
        Calendar c1 = Calendar.getInstance();  
        c1.setTime(result);  
        
        int day = c1.get(Calendar.DAY_OF_YEAR);
        c1.set(Calendar.DAY_OF_YEAR, day + offset);         
        return c1.getTime();         
    
    }    
    
    
  
    /** 
     * 取得季度天数 
     * @param date 
     * @return 
     */  
    public static int getDayOfSeason(Date date) {  
        int day = 0;  
        Date[] seasonDates  = getSeasonDate(date);  
        for (Date date2 : seasonDates) {  
            day += getDayOfMonth(date2);  
        }  
        return day;  
    }  
  
    /** 
     * 取得季度剩余天数 
     * 
     * @param date 
     * @return 
     */  
    public static int getRemainDayOfSeason(Date date) {  
        return getDayOfSeason(date) - getPassDayOfSeason(date);  
    }  
  
    /** 
     * 取得季度已过天数 
     * 
     * @param date 
     * @return 
     */  
    public static int getPassDayOfSeason(Date date) {  
        int day = 0;  
  
        Date[] seasonDates  = getSeasonDate(date);  
  
        Calendar c = Calendar.getInstance();  
        c.setTime(date);  
        int month = c.get(Calendar.MONTH);  
  
        if(month == Calendar.JANUARY || month == Calendar.APRIL || month == Calendar.JULY || month == Calendar.OCTOBER) {//季度第一个月  
            day = getPassDayOfMonth(seasonDates[0]);  
        } else if(month == Calendar.FEBRUARY || month == Calendar.MAY || month == Calendar.AUGUST || month == Calendar.NOVEMBER) {//季度第二个月  
            day = getDayOfMonth(seasonDates[0]) + getPassDayOfMonth(seasonDates[1]);  
        } else if(month == Calendar.MARCH || month == Calendar.JUNE || month == Calendar.SEPTEMBER || month == Calendar.DECEMBER) {//季度第三个月  
            day = getDayOfMonth(seasonDates[0]) + getDayOfMonth(seasonDates[1]) + getPassDayOfMonth(seasonDates[2]);  
        }  
        return day;  
    }  
  
    /** 
     * 取得季度月 
     * 
     * @param date 
     * @return 
     */  
    public static Date[] getSeasonDate(Date date) {  
        Date[] season = new Date[3];  
  
        Calendar c = Calendar.getInstance();  
        c.setTime(date);  
  
        int nSeason = getSeason(date);  
        if(nSeason == 1) {//第一季度  
            c.set(Calendar.MONTH, Calendar.JANUARY);  
            season[0] = c.getTime();  
            c.set(Calendar.MONTH, Calendar.FEBRUARY);  
            season[1] = c.getTime();  
            c.set(Calendar.MONTH, Calendar.MARCH);  
            season[2] = c.getTime();  
        } else if(nSeason == 2) {//第二季度  
            c.set(Calendar.MONTH, Calendar.APRIL);  
            season[0] = c.getTime();  
            c.set(Calendar.MONTH, Calendar.MAY);  
            season[1] = c.getTime();  
            c.set(Calendar.MONTH, Calendar.JUNE);  
            season[2] = c.getTime();  
        } else if(nSeason == 3) {//第三季度  
            c.set(Calendar.MONTH, Calendar.JULY);  
            season[0] = c.getTime();  
            c.set(Calendar.MONTH, Calendar.AUGUST);  
            season[1] = c.getTime();  
            c.set(Calendar.MONTH, Calendar.SEPTEMBER);  
            season[2] = c.getTime();  
        } else if(nSeason == 4) {//第四季度  
            c.set(Calendar.MONTH, Calendar.OCTOBER);  
            season[0] = c.getTime();  
            c.set(Calendar.MONTH, Calendar.NOVEMBER);  
            season[1] = c.getTime();  
            c.set(Calendar.MONTH, Calendar.DECEMBER);  
            season[2] = c.getTime();  
        }  
        return season;  
    }  
  
    /** 
     * 
     * 1 第一季度  2 第二季度 3 第三季度 4 第四季度 
     * 
     * @param date 
     * @return 
     */  
    public static int getSeason(Date date) {  
  
        int season = 0;  
  
        Calendar c = Calendar.getInstance();  
        c.setTime(date);  
        int month = c.get(Calendar.MONTH);  
        switch (month) {  
            case Calendar.JANUARY:  
            case Calendar.FEBRUARY:  
            case Calendar.MARCH:  
                season =  1;  
                break;  
            case Calendar.APRIL:  
            case Calendar.MAY:  
            case Calendar.JUNE:  
                season =  2;  
                break;  
            case Calendar.JULY:  
            case Calendar.AUGUST:  
            case Calendar.SEPTEMBER:  
                season =  3;  
                break;  
            case Calendar.OCTOBER:  
            case Calendar.NOVEMBER:  
            case Calendar.DECEMBER:  
                season =  4;  
                break;  
            default:  
                break;  
        }  
        return season;  
    }  
    
    public static int getAge(Date birthDay) throws Exception {
        Calendar cal = Calendar.getInstance();

        if (cal.before(birthDay)) {
            throw new IllegalArgumentException(
                "The birthDay is before Now.It's unbelievable!");
        }

        int yearNow = cal.get(Calendar.YEAR);
        int monthNow = cal.get(Calendar.MONTH);
        int dayOfMonthNow = cal.get(Calendar.DAY_OF_MONTH);
        cal.setTime(birthDay);

        int yearBirth = cal.get(Calendar.YEAR);
        int monthBirth = cal.get(Calendar.MONTH);
        int dayOfMonthBirth = cal.get(Calendar.DAY_OF_MONTH);

        int age = yearNow - yearBirth;

        if (monthNow <= monthBirth) {
            if (monthNow == monthBirth) {
                //monthNow==monthBirth
                if (dayOfMonthNow < dayOfMonthBirth) {
                    age--;
                } else {
                    //do nothing
                }
            } else {
                //monthNow>monthBirth
                age--;
            }
        } else {
            //monthNow<monthBirth
            //donothing
        }

        return age;
    }
    
    
  
    public static void main(String[] args) {  
        String strDate = "2010-03-26";  
        Date date = parseDate(strDate);  
        System.out.println(strDate + " 是一年的第几周？" + getWeekOfYear(date));  
        System.out.println(strDate + " 所在周起始结束日期？" + getWeekBeginAndEndDate(date, "yyyy年MM月dd日"));  
        System.out.println(strDate + " 所在周周一是？" + formatDate(getMondayOfWeek(date)));  
        System.out.println(strDate + " 所在周周日是？" + formatDate(getSundayOfWeek(date)));  
  
        System.out.println(strDate + " 当月第一天日期？" + formatDate(getFirstDateOfMonth(date)));  
        System.out.println(strDate + " 当月最后一天日期？" + formatDate(getLastDateOfMonth(date)));  
        System.out.println(strDate + " 当月天数？" + getDayOfMonth(date));  
        System.out.println(strDate + " 当月已过多少天？" + getPassDayOfMonth(date));  
        System.out.println(strDate + " 当月剩余多少天？" + getRemainDayOfMonth(date));  
  
        System.out.println(strDate + " 所在季度第一天日期？" + formatDate(getFirstDateOfSeason(date)));  
        System.out.println(strDate + " 所在季度最后一天日期？" + formatDate(getLastDateOfSeason(date)));  
        System.out.println(strDate + " 所在季度天数？" + getDayOfSeason(date));  
        System.out.println(strDate + " 所在季度已过多少天？" + getPassDayOfSeason(date));  
        System.out.println(strDate + " 所在季度剩余多少天？" + getRemainDayOfSeason(date));  
        System.out.println(strDate + " 是第几季度？" + getSeason(date));  
        System.out.println(strDate + " 所在季度月份？" + formatDate(getSeasonDate(date)[0], "yyyy年MM月") + "/" + formatDate(getSeasonDate(date)[1], "yyyy年MM月") + "/" + formatDate(getSeasonDate(date)[2], "yyyy年MM月"));
        System.out.println("第一季度的第一天" + formatDate(getFirstDateOfSeasonByQuarter(2012, 1,0)));
        System.out.println("第二季度的第一天" + formatDate(getFirstDateOfSeasonByQuarter(2012, 2,0)));
        System.out.println("第三季度的第一天" + formatDate(getFirstDateOfSeasonByQuarter(2012, 3,0)));
        System.out.println("第四季度的第一天" + formatDate(getFirstDateOfSeasonByQuarter(2012, 4,0)));
        
        System.out.println("第一季度的最后一天" + formatDate(getLastDateOfSeasonByQuarter(2012, 1,0)));
        System.out.println("第二季度的最后一天" + formatDate(getLastDateOfSeasonByQuarter(2012, 2,0)));
        System.out.println("第三季度的最后一天" + formatDate(getLastDateOfSeasonByQuarter(2012, 3,0)));
        System.out.println("第四季度的最后一天" + formatDate(getLastDateOfSeasonByQuarter(2012, 4,0)));
        
        System.out.println("月份最后一天" + formatDate(getLastDateOfMonthByMonth(2012, 2)));
        System.out.println("月份第一天" + formatDate(getFirstDateOfMonthByMonth(2012, 2)));  
        
        System.out.println(System.currentTimeMillis());
        
    }  
}  
