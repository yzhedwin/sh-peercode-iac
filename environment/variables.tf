variable "MONGO_PEERCODE_DATABASE_NAME" {
  description = "The name of the MongoDB database for peercode"
  type        = string
}

variable "MONGO_PEERCODE_DATABASE_PASSWORD" {
  description = "The password for the MongoDB database for peercode"
  type        = string
}

variable "MONGO_PEERCODE_DATABASE_USER" {
  description = "The user for the MongoDB database for peercode"
  type        = string
}

variable "MONGO_PEERCODE_HOST_NAME" {
  description = "The host name for the MongoDB database for peercode"
  type        = string
}

variable "MONGO_PEERCODE_URL" {
  description = "The URL for the MongoDB database for peercode"
  type        = string
}
variable "MONGO_INITDB_ROOT_USERNAME" {
  description = "The root user for MongoDB initialization"
  type        = string
}
variable "MONGO_INITDB_ROOT_PASSWORD" {
  description = "The root password for MongoDB initialization"
  type        = string
}
variable "RABBITMQ_URL" {
  description = "The url to rabbitmq service"
  type        = string
}
variable "RABBITMQ_DEFAULT_USER" {
  description = "The root user for MongoDB initialization"
  type        = string
}
variable "RABBITMQ_DEFAULT_PASS" {
  description = "The root password for MongoDB initialization"
  type        = string
}
variable "OPENAI_API_KEY" {
  type = string
}
variable "REACT_APP_FIREBASE_API_KEY" {
  type = string
}
variable "REACT_APP_FIREBASE_APP_ID" {
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
variable "REACT_APP_FIREBASE_MEASUREMENT_ID" {
  type = string
}
variable "REACT_APP_API_GATEWAY" {
  type = string
}
variable "REACT_APP_SOCKET_URL" {
  type = string
}
variable "REACT_APP_URL" {
  type = string
}
variable "REACT_APP_MATCHMAKING_TIMEOUT" {
  type = number
}
variable "NODE_ENV" {
  type = string
}
variable "MATCH_TIMEOUT" {
  type = number
}
variable "LEETCODE_FETCH_LIMIT" {
  type = number
}
variable "LOG_LEVEL" {
  type = string
}
variable "KAFKA_GROUP_SERVER" {
  type = string
}
variable "KAFKA_SERVER_NAME" {
  type = string
}
variable "KAFKA_TOPICS" {
  type = string
}
variable "KAFKA_TOPIC_QUESTION_BANK" {
  type = string
}
variable "KAFKA_TOPIC_QUESTION_OF_THE_DAY" {
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
  type = number
}
variable "KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR" {
  type = number
}

variable "KAFKA_TRANSACTION_STATE_LOG_MIN_ISR" {
  type = number
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
variable "JUDGE_SERVICE_URL" {
  type = string
}
variable "KAFKA_TOPIC_QUESTION_SERVICE" {
  type = string
}
variable "QUESTION_SERVICE_URL" {
  type = string
}
variable "SERVER_PORT" {
  type = number
}
variable "MATCH_SERVICE_PORT" {
  type = number
}

