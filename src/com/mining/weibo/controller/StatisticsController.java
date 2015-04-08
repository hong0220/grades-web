package com.mining.weibo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class StatisticsController {

	@RequestMapping(value = "statistic")
	public String statisticTopicSentiment() {
		return "core/statistic";
	}
}