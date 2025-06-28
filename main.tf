terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

provider "kubernetes" {
  config_path            = var.kubeconfig_path
  host                   = var.host
  client_certificate     = base64decode(var.client_certificate)
  client_key             = base64decode(var.client_key)
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}



module "environment" {
  source = "./environment"


  REACT_APP_FIREBASE_MESSAGING_SENDER_ID = var.REACT_APP_FIREBASE_MESSAGING_SENDER_ID
  REACT_APP_FIREBASE_STORAGE_BUCKET      = var.REACT_APP_FIREBASE_STORAGE_BUCKET
  REACT_APP_FIREBASE_PROJECT_ID          = var.REACT_APP_FIREBASE_PROJECT_ID
  REACT_APP_FIREBASE_API_KEY             = var.REACT_APP_FIREBASE_API_KEY
  REACT_APP_FIREBASE_MEASUREMENT_ID      = var.REACT_APP_FIREBASE_MEASUREMENT_ID
  REACT_APP_FIREBASE_APP_ID              = var.REACT_APP_FIREBASE_APP_ID
  REACT_APP_FIREBASE_AUTH_DOMAIN         = var.REACT_APP_FIREBASE_AUTH_DOMAIN
  REACT_APP_API_GATEWAY                  = var.REACT_APP_API_GATEWAY
  REACT_APP_SOCKET_URL                   = var.REACT_APP_SOCKET_URL
  REACT_APP_MATCHMAKING_TIMEOUT          = var.REACT_APP_MATCHMAKING_TIMEOUT
  REACT_APP_URL                          = var.REACT_APP_URL
  NODE_ENV                               = var.NODE_ENV
  MATCH_TIMEOUT                          = var.MATCH_TIMEOUT
  SERVER_PORT                            = var.SERVER_PORT
  QUESTION_SERVICE_URL                   = var.QUESTION_SERVICE_URL
  JUDGE_SERVICE_URL                      = var.JUDGE_SERVICE_URL
  OPENAI_API_KEY                         = var.OPENAI_API_KEY
  LOG_LEVEL                              = var.LOG_LEVEL
  MATCH_SERVICE_PORT                     = var.MATCH_SERVICE_PORT


  KAFKA_TOPIC_QUESTION_SERVICE                   = var.KAFKA_TOPIC_QUESTION_SERVICE
  KAFKA_GROUP_QUESTION_SERVICE                   = var.KAFKA_GROUP_QUESTION_SERVICE
  KAFKA_SERVER_NAME                              = var.KAFKA_SERVER_NAME
  KAFKA_TOPICS                                   = var.KAFKA_TOPICS
  KAFKA_TOPIC_QUESTION_BANK                      = var.KAFKA_TOPIC_QUESTION_BANK
  KAFKA_TOPIC_QUESTION_OF_THE_DAY                = var.KAFKA_TOPIC_QUESTION_OF_THE_DAY
  KAFKA_GROUP_SERVER                             = var.KAFKA_GROUP_SERVER
  KAFKA_ADVERTISED_LISTENERS                     = var.KAFKA_ADVERTISED_LISTENERS
  KAFKA_BROKER_ID                                = var.KAFKA_BROKER_ID
  KAFKA_LISTENER_SECURITY_PROTOCOL_MAP           = var.KAFKA_LISTENER_SECURITY_PROTOCOL_MAP
  KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR         = var.KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR
  KAFKA_TRANSACTION_STATE_LOG_MIN_ISR            = var.KAFKA_TRANSACTION_STATE_LOG_MIN_ISR
  KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR = var.KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR
  KAFKA_ZOOKEEPER_CONNECT                        = var.KAFKA_ZOOKEEPER_CONNECT
  ZOOKEEPER_CLIENT_PORT                          = var.ZOOKEEPER_CLIENT_PORT
  ZOOKEEPER_TICK_TIME                            = var.ZOOKEEPER_TICK_TIME

  RABBITMQ_URL          = var.RABBITMQ_URL
  RABBITMQ_DEFAULT_PASS = var.RABBITMQ_DEFAULT_PASS
  RABBITMQ_DEFAULT_USER = var.RABBITMQ_DEFAULT_USER

  MONGO_INITDB_ROOT_PASSWORD       = var.MONGO_INITDB_ROOT_PASSWORD
  MONGO_INITDB_ROOT_USERNAME       = var.MONGO_INITDB_ROOT_USERNAME
  MONGO_PEERCODE_HOST_NAME         = var.MONGO_PEERCODE_HOST_NAME
  MONGO_PEERCODE_DATABASE_NAME     = var.MONGO_PEERCODE_DATABASE_NAME
  MONGO_PEERCODE_DATABASE_USER     = var.MONGO_PEERCODE_DATABASE_USER
  MONGO_PEERCODE_URL               = var.MONGO_PEERCODE_URL
  MONGO_PEERCODE_DATABASE_PASSWORD = var.MONGO_PEERCODE_DATABASE_PASSWORD
  LEETCODE_FETCH_LIMIT             = var.LEETCODE_FETCH_LIMIT
  KAFKA_GROUP_LEETCODE_SERVICE     = var.KAFKA_GROUP_LEETCODE_SERVICE

}
module "rabbitmq" {
  source               = "./rabbitmq"
  amqp_broker_port     = var.RABBITMQ_BROKER_PORT
  amqp_management_port = var.RABBITMQ_MANAGEMENT_PORT
}

module "kafka" {
  source         = "./kafka"
  config_map     = module.environment.peercode_config_map
  kafka_port     = var.KAFKA_PORT
  kafka_port_2   = var.KAFKA_PORT_2
  zookeeper_port = var.ZOOKEEPER_CLIENT_PORT
}
module "mongodb" {
  source       = "./mongodb"
  mongodb_port = var.MONGODB_PORT
}

module "api_gateway" {
  source      = "./gateway"
  config_map  = module.environment.peercode_config_map
  server_port = var.SERVER_PORT
}

module "question_service" {
  source                = "./question_service"
  config_map            = module.environment.peercode_config_map
  question_service_port = var.QUESTION_SERVICE_PORT
}

module "match_service" {
  source               = "./match_service"
  match_service_port   = var.MATCH_SERVICE_PORT
  openapi_service_port = var.OPENAPI_SERVICE_PORT
  config_map           = module.environment.peercode_config_map
}

module "leecode_service" {
  source                = "./leetcode_service"
  config_map            = module.environment.peercode_config_map
  leetcode_service_port = var.LEETCODE_SERVICE_PORT
}

module "peercode_app" {
  source     = "./app"
  config_map = module.environment.peercode_config_map
  http_port  = var.HTTP_PORT
  https_port = var.HTTPS_PORT
}

module "cloudflare" {
  source                = "./cloudflare"
  cloudflare_account_id = var.cloudflare_account_id
  cloudflare_api_token  = var.cloudflare_api_token
  cloudflare_zone_id    = var.cloudflare_zone_id


  cloudflare_services_peercode    = var.cloudflare_services_peercode
  cloudflare_services_ssh         = var.cloudflare_services_ssh
  cloudflare_tunnel_name_peercode = var.cloudflare_tunnel_name_peercode
  cloudflare_tunnel_name_ssh      = var.cloudflare_tunnel_name_ssh
}

# module "nginx" {
#   source = "./nginx_reverse_proxy"
# }
