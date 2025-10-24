# FORK ONLY MADE TO MATCH MY PERSONAL ENV.
# PASSWORD, HOSTS AND ETC ARE NOT USED IN REAL PROD.

# The Unoffical Postgre SQL adapter for the jellyfin server

This adds postgres SQL support via an plugin to the jellyfin server. There are several steps required to make this work and it is to be considered __HIGHLY__ experimental.

# How to use it

There is an docker container available for yourself to build that already sets everything up and attaches the plugin directly.

# Build

Checkout the Jellyfin submodule.
Use dotnet build to build the plugin.
Place the plugin in the plugin folder of the JF app.
Update the database.xml file to switch to the plugin as its database provider:

```xml
<?xml version="1.0" encoding="utf-8"?>
<DatabaseConfigurationOptions xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <DatabaseType>PLUGIN_PROVIDER</DatabaseType>
  <CustomProviderOptions>
    <PluginAssembly>../../../Jellyfin.Plugin.Pgsql/bin/debug/net9.0/Jellyfin.Plugin.Pgsql.dll</PluginAssembly>
    <PluginName>PostgreSQL</PluginName>
    <ConnectionString>CONNECTION_STRING_TO_LOCAL_PGSQL_SERVER</ConnectionString>
  </CustomProviderOptions>
  <LockingBehavior>NoLock</LockingBehavior>
</DatabaseConfigurationOptions>

```

launch your jellyfin server.

# Add migration
Run `dotnet ef migrations add {MIGRATION_NAME} --project "/workspaces/Jellyfin.Pgsql/Jellyfin.Plugin.Pgsql" -- --migration-provider Jellyfin-PgSql`
