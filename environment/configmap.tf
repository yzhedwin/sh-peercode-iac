resource "kubernetes_config_map" "peercode_config" {
  metadata {
    name      = "peercode-config"
    namespace = "dev"
  }

  data = {
    SERVER_PORT                                    = var.SERVER_PORT
    NODE_ENV                                       = var.NODE_ENV
    LOG_LEVEL                                      = var.LOG_LEVEL
    REACT_APP_URL                                  = var.REACT_APP_URL
    REACT_APP_API_GATEWAY                          = var.REACT_APP_API_GATEWAY
    REACT_APP_SOCKET_URL                           = var.REACT_APP_SOCKET_URL
    REACT_APP_MATCHMAKING_TIMEOUT                  = var.REACT_APP_MATCHMAKING_TIMEOUT
    MATCH_TIMEOUT                                  = var.MATCH_TIMEOUT
    KAFKA_GROUP_SERVER                             = var.KAFKA_GROUP_SERVER
    KAFKA_GROUP_QUESTION_SERVICE                   = var.KAFKA_GROUP_QUESTION_SERVICE
    KAFKA_SERVER_NAME                              = var.KAFKA_SERVER_NAME
    KAFKA_TOPICS                                   = var.KAFKA_TOPICS
    KAFKA_TOPIC_QUESTION_BANK                      = var.KAFKA_TOPIC_QUESTION_BANK
    KAFKA_TOPIC_QUESTION_OF_THE_DAY                = var.KAFKA_TOPIC_QUESTION_OF_THE_DAY
    KAFKA_TOPIC_QUESTION_SERVICE                   = var.KAFKA_TOPIC_QUESTION_SERVICE
    KAFKA_ADVERTISED_LISTENERS                     = var.KAFKA_ADVERTISED_LISTENERS
    KAFKA_BROKER_ID                                = var.KAFKA_BROKER_ID
    KAFKA_LISTENER_SECURITY_PROTOCOL_MAP           = var.KAFKA_LISTENER_SECURITY_PROTOCOL_MAP
    KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR         = var.KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR
    KAFKA_TRANSACTION_STATE_LOG_MIN_ISR            = var.KAFKA_TRANSACTION_STATE_LOG_MIN_ISR
    KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR = var.KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR
    KAFKA_ZOOKEEPER_CONNECT                        = var.KAFKA_ZOOKEEPER_CONNECT
    ZOOKEEPER_CLIENT_PORT                          = var.ZOOKEEPER_CLIENT_PORT
    ZOOKEEPER_TICK_TIME                            = var.ZOOKEEPER_TICK_TIME
    JUDGE_SERVICE_URL                              = var.JUDGE_SERVICE_URL
    QUESTION_SERVICE_URL                           = var.QUESTION_SERVICE_URL
    KAFKA_GROUP_LEETCODE_SERVICE                   = var.KAFKA_GROUP_LEETCODE_SERVICE
    LEETCODE_FETCH_LIMIT                           = var.LEETCODE_FETCH_LIMIT
  }
}

