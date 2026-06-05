package kr.co.udid.payapp.lt.model.payapp;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

/**
 * Created by Thomas on 2016. 11. 29..
 */
@Component
@EnableConfigurationProperties
@ConfigurationProperties (prefix = "payapp")
@Data
public class PayappProperty
{
	private String url;

	private String name;

	/**
	 * Base url guaranteed to end with a single trailing slash, so callers can
	 * safely append a path like "p/{url}" regardless of how the configured
	 * value is set (e.g. the Render env var omits the trailing slash).
	 */
	public String getBaseUrl ()
	{
		if (url == null || url.isEmpty ())
			return "";

		return url.endsWith ("/") ? url : url + "/";
	}
}
