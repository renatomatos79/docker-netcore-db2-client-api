FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /src
COPY ["CoreDockerApi.csproj", "."]
RUN dotnet restore CoreDockerApi.csproj
COPY . .
RUN dotnet build "CoreDockerApi.csproj" -c Release -o /app/build

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=build-env /app/build .
ENV PATH=$PATH:"/app/clidriver/bin:/app/clidriver/lib"
ENV LD_LIBRARY_PATH="/app/bin/clidriver/lib:/app/bin/clidriver/lib/libdb2.so"
ENTRYPOINT ["dotnet", "CoreDockerApi.dll"]