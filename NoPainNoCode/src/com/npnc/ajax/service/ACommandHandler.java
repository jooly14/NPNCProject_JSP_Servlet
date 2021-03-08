package com.npnc.ajax.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

public interface ACommandHandler {	//ajax 처리하는 handler
	public JSONObject process(HttpServletRequest request,HttpServletResponse response);
}
