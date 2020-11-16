/*******************************************************************************
 * Copyright 2017 Cognizant Technology Solutions
 * 
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License.  You may obtain a copy
 * of the License at
 * 
 *   http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
 * License for the specific language governing permissions and limitations under
 * the License.
 ******************************************************************************/
package com.cognizant.devops.engines.platformdataarchivalengine.message.subscriber;

import java.io.IOException;
import java.util.concurrent.TimeoutException;

import com.cognizant.devops.platformcommons.config.ApplicationConfigCache;
import com.cognizant.devops.platformcommons.config.ApplicationConfigProvider;
import com.cognizant.devops.platformcommons.config.MessageQueueDataModel;
import com.cognizant.devops.platformcommons.constants.MQMessageConstants;
import com.cognizant.devops.platformdal.agentConfig.AgentConfigDAL;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;

public class TestSubscriber {

	public void publishDataArchivalDetails(String routingKey, String publishDataJson)
			throws IOException, TimeoutException {

		ConnectionFactory factory = new ConnectionFactory();
		MessageQueueDataModel messageQueueConfig = ApplicationConfigProvider.getInstance().getMessageQueue();
		factory.setHost(messageQueueConfig.getHost());
		factory.setUsername(messageQueueConfig.getUser());
		factory.setPassword(messageQueueConfig.getPassword());
		Connection connection = factory.newConnection();
		Channel channel = connection.createChannel();
		String queueName = routingKey.replace(".", "_");
		channel.exchangeDeclare(MQMessageConstants.EXCHANGE_NAME, MQMessageConstants.EXCHANGE_TYPE, true);
		channel.queueDeclare(queueName, true, false, false, null);
		channel.queueBind(queueName, MQMessageConstants.EXCHANGE_NAME, routingKey);
		channel.basicPublish(MQMessageConstants.EXCHANGE_NAME, routingKey, null, publishDataJson.getBytes());
		channel.close();
		connection.close();

	}
	static public JsonObject convertStringIntoJson(String convertregisterkpi) {
		JsonObject objectJson = new JsonObject();
		JsonParser parser = new JsonParser();
		objectJson = parser.parse(convertregisterkpi).getAsJsonObject();
		return objectJson;
	}

}