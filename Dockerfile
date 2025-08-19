# # MapleStory v113 Server Dockerfile
# FROM openjdk:8-jdk-slim

# # 安裝必要的工具
# RUN apt-get update && apt-get install -y \
#     wget \
#     unzip \
#     git \
#     netcat-openbsd \
#     && rm -rf /var/lib/apt/lists/*

# # 設置工作目錄
# WORKDIR /maplestory

# # 複製項目文件
# COPY . .

# # 設置權限
# RUN chmod +x *.sh 2>/dev/null || true

# # 創建必要的目錄
# RUN mkdir -p logs

# # 確保 server.jar 存在 (根據你的項目結構調整)
# # 選項 1: 如果你有預編譯的 JAR 文件
# # COPY server.jar .

# # 選項 2: 如果你需要從其他 JAR 文件複製
# # RUN if [ -f "dist/TMS113.jar" ]; then cp dist/TMS113.jar server.jar; fi

# # 選項 3: 如果你需要編譯源代碼 (需要添加 maven 或其他構建工具)
# # RUN mvn clean package && cp target/*.jar server.jar

# # 驗證 server.jar 是否存在
# RUN ls -la && echo "Checking for server.jar:" && ls -la server.jar 2>/dev/null || echo "server.jar not found!"

# # 暴露端口 (通常 MapleStory 使用 8484 登入端口和 7575+ 遊戲端口)
# EXPOSE 8484 7575 7576 7577 7578

# # 啟動命令 - 這裡需要根據實際的啟動腳本調整
# CMD ["java", "-server", "-Xmx1024m", "-Xms512m", "-jar", "server.jar"]

# MapleStory v113 Server Dockerfile
FROM openjdk:8-jdk-slim

# 安裝必要的工具
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    git \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# 設置工作目錄
WORKDIR /maplestory

# 複製項目文件
COPY . .

# 設置權限
RUN chmod +x *.sh 2>/dev/null || true

# 創建必要的目錄
RUN mkdir -p logs lib

# 加入 MySQL Connector
# ADD https://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.49/mysql-connector-java-5.1.49.jar lib/mysql-connector-java.jar
# RUN wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.49/mysql-connector-java-5.1.49.jar -O mysql-connector-java.jar
# RUN wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.49/mysql-connector-java-5.1.49.jar -O lib/mysql-connector-java.jar
RUN wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.49/mysql-connector-java-5.1.49.jar \
    -O lib/mysql-connector-java.jar

RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    git \
    netcat-openbsd \
    default-mysql-client \
    && rm -rf /var/lib/apt/lists/*
# 驗證 server.jar 是否存在
RUN ls -la && echo "Checking for server.jar:" && ls -la server.jar 2>/dev/null || echo "server.jar not found!"
# COPY lib/ lib/
# COPY wz/ /maplestory/wz/
# 暴露端口
EXPOSE 8484 8586 8588 8587 8596

# 啟動命令 (注意：請確認 MainClass 名稱是否正確)
# CMD ["sh", "-c", "java -server -Xmx1024m -Xms512m -cp .:lib/*:JarLib/*:dist/lib/*:server.jar server.swing.WvsCenter"]

CMD ["java", "-server", "-Xmx1024m", "-Xms512m", "-cp", "server.jar:lib/*:.", "server.Start"]

