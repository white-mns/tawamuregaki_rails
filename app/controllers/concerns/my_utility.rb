module MyUtility
  # 検索文字列を分割し、Ransackが参照する配列に割り当てる
  def reference_word_assign(param_adr, data_name, param_key, match_suffix)
    if(!param_adr[param_key]) then
        return
    end

    texts = (param_adr[param_key].match(/ /)) ? param_adr[param_key].split(" ") : [param_adr[param_key].dup]

    if texts.is_a?(Array) then
        for text in texts do
            if (text && text.match("/")) then
                texts_or = text.split("/")
                for text_or in texts_or do
                    reference_word_set(param_adr, data_name, text_or, match_suffix, "any") 
                end
            else
                reference_word_set(param_adr, data_name, text, match_suffix, "all") 
            end
        end
    end
  end

  def reference_text_assign(param_adr, data_name, param_key)
    reference_word_assign(param_adr, data_name, param_key, "cont")
  end

  # 文字列の除外と完全一致を判定し、Ransackが参照する配列に割り当てる
  def reference_word_set(param_adr, data_name, text, match_suffix, operator_suffix)
      not_suffix = ""
      if(text[0] == "-") then
          # 除外検索用に添字を変更 「_not_cont_all」か「not_eq_all」になる
          text.slice!(0,1)
          not_suffix = "not_"
          operator_suffix = "all"
          data_name = data_name.gsub(/_or_/, "_and_")
      end
      
      if(text[0] == "\"" && text[-1] == "\"") then
          # 完全一致に添字を変更
          text.slice!(0,1)
          text.slice!(-1,1)
          match_suffix = "eq"
      end
      
      param_push(param_adr, data_name + "_" + not_suffix + match_suffix + "_" + operator_suffix, text)

  end
  
  # 数値の文字列を分割し、Ransackが参照する配列に割り当てる
  def reference_number_assign(param_adr, data_name, param_key)
    if(!param_adr[param_key]) then
        return
    end

    texts = (param_adr[param_key].match("/")) ? param_adr[param_key].split("/") : [param_adr[param_key].dup]

    if texts.is_a?(Array) then
        for text in texts do
            if (text && text.match(/([\-\.\d]+)~([\-\.\d]+)/)) then
                text_match = text.match(/([\-\.\d]+)~([\-\.\d]+)/)
                reference_number_set(param_adr, data_name, text_match[0] + "~") 
                reference_number_set(param_adr, data_name, "~" + text_match[2]) 
            else
                reference_number_set(param_adr, data_name, text) 
            end
        end
    end
  end

  # 数値の文字列から以上・以下を判定し、Ransackが参照する配列に割り当てる
  def reference_number_set(param_adr, data_name, text)
      match_suffix = "eq"
      if(text[0] == "~") then
          text.slice!(0,1)
          match_suffix = "lteq"
      end
      
      if(text[-1] == "~") then
          text.slice!(-1,1)
          match_suffix = "gteq"
      end
      
      param_push(param_adr, data_name + "_" + match_suffix + "_any", text)
  end
 
  # Ransackの検索用パラメータに追加。配列がない場合は作成する 
  def param_push(param_adr, ransack_param, text)
      if !param_adr[:q][ransack_param].is_a?(Array) then
          param_adr[:q][ransack_param] = Array.new
      end

      param_adr[:q][ransack_param].push(text)
  end

  private

end
