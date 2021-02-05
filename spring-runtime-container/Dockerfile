# build
FROM mvn-build:pilot
WORKDIR /usr/src/app
COPY pom.xml .
RUN mvn -B -e -C -T 1C org.apache.maven.plugins:maven-dependency-plugin:3.1.1:go-offline
COPY . .
RUN mvn -B -e -o -T 1C verify

# package without maven
FROM amazoncorretto:11
COPY --from=0 /usr/src/app/target/*.jar ./app.jar
ENTRYPOINT ["java","-jar","/app.jar"]