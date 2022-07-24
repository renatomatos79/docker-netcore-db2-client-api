FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /src
COPY ["CoreDockerApi.csproj", "."]
RUN dotnet restore CoreDockerApi.csproj
COPY . .
RUN dotnet build "CoreDockerApi.csproj" -c Release -o /app/build

FROM build-env AS publish
RUN dotnet publish "CoreDockerApi.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app

ENV DB2_CLI_DRIVER_INSTALL_PATH="/app/clidriver" \
    LD_LIBRARY_PATH="/app/clidriver/lib" \
    LIBPATH="/app/clidriver/lib" \
    PATH=$PATH:"/app/clidriver/bin:/app/clidriver/lib"

RUN apt-get -y update && apt-get install -y libxml2

COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "CoreDockerApi.dll"]