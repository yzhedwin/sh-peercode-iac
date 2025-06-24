#Mongo
variable "MONGO_INITDB_ROOT_USERNAME" {
  type = string
}
variable "MONGO_INITDB_ROOT_PASSWORD" {
  type = string
}
variable "MONGO_PEERCODE_HOST_NAME" {
  type = string
}
variable "MONGO_PEERCODE_DATABASE_NAME" {
  type = string
}
variable "MONGO_PEERCODE_DATABASE_USER" {
  type = string
}
variable "MONGO_PEERCODE_DATABASE_PASSWORD" {
  type = string
}
variable "MONGO_PEERCODE_URL" {
  type = string
}

#RMQ
variable "RABBITMQ_URL" {
  type = string
}
variable "RABBITMQ_DEFAULT_USER" {
  type = string
}
variable "RABBITMQ_DEFAULT_PASS" {
  type = string
}
#OPENAPI
variable "OPENAI_API_KEY" {
  type = string
}

#React App
variable "REACT_APP_FIREBASE_API_KEY" {
  type = string
}
variable "REACT_APP_FIREBASE_AUTH_DOMAIN" {
  type = string
}
variable "REACT_APP_FIREBASE_PROJECT_ID" {
  type = string
}
variable "REACT_APP_FIREBASE_STORAGE_BUCKET" {
  type = string
}
variable "REACT_APP_FIREBASE_MESSAGING_SENDER_ID" {
  type = string
}
variable "REACT_APP_FIREBASE_APP_ID" {
  type = string
}
variable "REACT_APP_FIREBASE_MEASUREMENT_ID" {
  type = string
}
variable "REACT_APP_MATCHMAKING_TIMEOUT" {
  type = number
}
variable "REACT_APP_SOCKET_URL" {
  type = string
}
variable "NODE_ENV" {
  type = string
}
variable "REACT_APP_API_GATEWAY" {
  type = string
}
variable "REACT_APP_URL" {
  type = string
}
#KAFKA
variable "KAFKA_TOPICS" {
  type = string
}
variable "KAFKA_SERVER_NAME" {
  type = string
}
variable "KAFKA_TOPIC_QUESTION_SERVICE" {
  type = string
}
variable "KAFKA_TOPIC_QUESTION_BANK" {
  type = string
}

variable "KAFKA_TOPIC_QUESTION_OF_THE_DAY" {
  type = string
}
variable "KAFKA_GROUP_SERVER" {
  type = string
}
variable "KAFKA_GROUP_QUESTION_SERVICE" {
  type = string
}
variable "KAFKA_GROUP_LEETCODE_SERVICE" {
  type = string
}

variable "KAFKA_ADVERTISED_LISTENERS" {
  type = string
}
variable "KAFKA_LISTENER_SECURITY_PROTOCOL_MAP" {
  type = string
}
variable "KAFKA_BROKER_ID" {
  type = string
}
variable "KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR" {
  type = string
}

variable "KAFKA_TRANSACTION_STATE_LOG_MIN_ISR" {
  type = string
}
variable "KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR" {
  type = string
}
variable "KAFKA_ZOOKEEPER_CONNECT" {
  type = string
}
variable "ZOOKEEPER_CLIENT_PORT" {
  type = number
}
variable "ZOOKEEPER_TICK_TIME" {
  type = number
}

#Services
variable "JUDGE_SERVICE_URL" {
  type = string
}
variable "QUESTION_SERVICE_URL" {
  type = string
}
variable "SERVER_PORT" {
  type = number
}
variable "LOG_LEVEL" {
  type = string
}
variable "LEETCODE_FETCH_LIMIT" {
  type = number
}
variable "MATCH_TIMEOUT" {
  type = number
}
variable "MATCH_SERVICE_PORT" {
  type = number
}
variable "LEETCODE_SERVICE_PORT" {
  type = number
}
variable "OPENAPI_SERVICE_PORT" {
  type = number
}
variable "QUESTION_SERVICE_PORT" {
  type = number
}
variable "RABBITMQ_BROKER_PORT" {
  type = number
}
variable "RABBITMQ_MANAGEMENT_PORT" {
  type = number
}

variable "KAFKA_PORT" {
  type = number
}
variable "KAFKA_PORT_2" {
  type = number
}
variable "MONGODB_PORT" {
  type = number
}


#Kubernetes
variable "host" {
  type = string
}
variable "client_key" {
  type = string
}
variable "cluster_ca_certificate" {
  type = string
}
variable "kubeconfig_path" {
  type = string
}
variable "client_certificate" {
  type = string
}
