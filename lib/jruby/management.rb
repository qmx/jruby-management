require "jruby"
require "jmx4r"
require "jruby/management/version"
require "jruby/management/profiler_mbean"

module JRuby
  module Management
    import java.lang.management.ManagementFactory
    import javax.management.ObjectName

    def register_mbean(clazz)
      object_name = ObjectName.new("org.jruby.management:name=#{clazz.mbean_name}")
      ManagementFactory.platform_mbean_server.register_mbean(clazz.new, object_name)
    end

    module_function :register_mbean
  end
end

JRuby::Management.register_mbean(JRuby::Management::ProfilerMBean)
