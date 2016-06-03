module FrontHelper

  def scan_eng_run_tree_options_for_select(scan_eng_runs, options = {})
    s = ''
    scan_eng_runs.each do |scan_eng_run|
      tag_options = {:value => scan_eng_run.id}
      if scan_eng_run == options[:selected] || (options[:selected].respond_to?(:include?) && options[:selected].include?(scan_eng_run))
        tag_options[:selected] = 'selected'
      else
        tag_options[:selected] = nil
      end
      tag_options.merge!(yield(scan_eng_run)) if block_given?
      s << content_tag('option', h(scan_eng_run), tag_options)
    end
    s.html_safe
  end

end
