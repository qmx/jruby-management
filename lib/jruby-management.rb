require "jruby-management/version"
require "jruby"
require "jmx4r"

module JRuby
  module Management
    class ProfilerMBean < JMX::DynamicMBean
      class << JRuby.runtime
        field_reader :config
      end

      operation "enables profiler"
      returns :void
      def enable_profiling
        JRuby.runtime.config.profiling_mode = org.jruby.RubyInstanceConfig::ProfilingMode::GRAPH
        JRuby.reference(JRuby.runtime.kernel).invalidate_cache_descendants
      end

      operation "dumps profiler info to specified file"
      parameter :string, "path", "path to write profiling results"
      returns :void
      def dump_profile_info(path)
        runtime = JRuby.runtime
        file = open(path, 'w+')
        runtime.thread_service.ruby_thread_map.each do |t, rubythread|
          file.puts("\n#{t} profile results:")
          context = JRuby.reference(rubythread).context
          profile_data = context.profile_data
          printer = runtime.instance_config.make_default_profile_printer(profile_data)
          printer.printProfile(file)
        end
        file.close
      end

      def self.mbean_name
        "ProfilerMBean"
      end
    end

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
