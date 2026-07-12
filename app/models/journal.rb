class Journal
  
  def memos
    @memos ||= Memo.all#.order(&:updated_at).group_by{|m| Time.at(m.updated_at).strftime("%Y-%m-%d")}
  end
  
  def events
    @events ||= Event.all#.order(&:created_at).group_by{|m| Time.at(m.created_at).strftime("%Y-%m-%d")}
  end
  
  def entries
    @entries = (memos.to_a + events.to_a).sort{|a,b| (a.respond_to?(:updated_at) ? a.updated_at : a.created_at) <=> (b.respond_to?(:updated_at) ? b.updated_at : b.created_at) }.group_by{|entry| (entry.respond_to?(:updated_at) ? entry.updated_at : entry.created_at).strftime("%B %e, %Y")}
  end
  
end
