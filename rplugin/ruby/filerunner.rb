require 'neovim'
require 'tempfile'
module FileRunner
    require 'childprocess'
    Filetypes=[]
    class Filetype
        attr_reader :filetype, :exec, :interactive
        def initialize(filetype:,exec:nil,interactive:nil)
            @filetype,@exec,@interactive=filetype,exec,interactive
            FileRunner::Filetypes << self
        end
    end
    class FileRunnerException < Exception
    end
    class UnknownFiletypeException < FileRunnerException
    end
    class MultipleFiletypeException < FileRunnerException
    end
    class NoInteractiveCommandException < FileRunnerException
    end
    class NoExecCommandException < FileRunnerException
    end
    class Process < BasicObject
        def initialize(*args)
            @process=::ChildProcess.build(*args)
        end
        def method_missing(*args)
            @process.__send__(*args)
        end
    end
    class Buffer
        def initialize(client)
            @client=client
            client.command ":enew"
            client.current.buffer.set_option('buftype','nofile')
            client.current.buffer.set_option('bufhidden','wipe')
            client.current.buffer.set_option('swapfile',false)
            client.current.buffer.set_option('buflisted',true)
            client.command ":map <buffer><Return> :bdelete<CR>"
            client.command ":map <buffer><Esc> :bdelete<CR>"
        end
        def write_array(s)
            @client.current.buffer.lines=s
        end
    end
    class DuplexProcess < Process
        attr_reader :r,:w
        def initialize(*args,&block)
            @r,@w=::IO.pipe
            super(*args)
            @process.duplex=true
            @process.io.stdout = @process.io.stderr = @w
            @process.start
            block.call(@process.io.stdin)
            @process.io.stdin.close
            @w.close
            @process.poll_for_exit(30)
        end
        def output
            @r.each_line.map{|line|line.chomp}.to_a
        end
    end
    class Terminal
        def initialize(client,command,fn)
            temp=Tempfile.new(['',fn])
            args=command.map{|s|"\"#{s.gsub("%s",temp.path)}\""}
            client.command ':new'
            client.command(":exec termopen([#{args.join(',')}])")
            client.command ':startinsert'
        end
    end
    def self.run_file(ft,nvim)
        client=nvim
        buffer=nvim.current.buffer
        match = Filetypes.select{|o|o.filetype == ft}
        raise UnknownFiletypeException unless match.size > 0
        raise MultipleFiletypeException if match.size > 1
        raise NoExecCommandException if match.first.exec.nil?
        process=DuplexProcess.new(*(match.first.exec)) do |io|
            buffer.lines.each do |line|
                io.puts line
            end
        end
        Buffer.new(client).write_array(process.output)
        ""
    end
    def self.interactive_run_file(ft,nvim,fn)
        client=nvim
        match = Filetypes.select{|o|o.filetype == ft}
        raise UnknownFiletypeException unless match.size > 0
        raise MultipleFiletypeException if match.size > 1
        raise NoInteractiveCommandException if match.first.interactive.nil?
        Terminal.new(client,match.first.interactive,fn)
        ""
    end

    Filetype.new(
        exec: [ "bash", "-s" ],
        filetype: "sh")

    Filetype.new(
        exec: [ "env",  "ruby", "-", "--" ],
        interactive: ["env","irb","-r","%s"],
        filetype: "ruby")

    Filetype.new(
            exec: [ "php", "--" ],
            filetype: "php")


end
Neovim.plugin do |plugin|
    plugin.function(:RunFile, nargs: 1, sync: true) do |nvim,ft|
        FileRunner::run_file ft,nvim
    end
    plugin.function(:InteractiveRunFile, nargs: 1, sync: true, eval: 'expand("%:t")') do |nvim,ft,fn|
        FileRunner::interactive_run_file ft,nvim,fn
    end
end
