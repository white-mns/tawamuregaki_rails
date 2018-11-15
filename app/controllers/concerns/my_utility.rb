module MyUtility
  # 検索文字列を分割し、Ransackが参照する配列に割り当てる
  def reference_word_assign(param_adr, data_name, param_key, match_suffix)
    if(!param_adr[param_key]) then
        return
    end

    texts = (param_adr[param_key].match(/ /)) ? param_adr[param_key].split(" ") : [param_adr[param_key].dup]

    if texts.is_a?(Array) then
        suffixes = ["_cont_all", "_cont_any", "_not_cont_all", "_eq_all", "_eq_any","_not_eq_all"]
        for suffix in suffixes do
            param_adr[:q][data_name + suffix] = Array.new
        end

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

  # 文字列の除外と完全一致を判定し、Ransackが参照する配列に割り当てる
  def reference_word_set(param_adr, data_name, text, match_suffix, operator_suffix)
      not_suffix = ""
      if(text[0] == "-") then
          # 除外検索用に添字を変更 「_not_cont_all」か「not_eq_all」になる
          text.slice!(0,1)
          not_suffix = "not_"
          operator_suffix = "all"
      end
      
      if(text[0] == "\"" && text[-1] == "\"") then
          # 完全一致に添字を変更
          text.slice!(0,1)
          text.slice!(-1,1)
          match_suffix = "eq"
      end
      
      param_adr[:q][data_name + "_" + not_suffix + match_suffix + "_" + operator_suffix].push(text)

  end
  
  # 文字列の文字列を分割し、部分一致の条件でRansackが参照する配列に割り当てる
  def reference_text_assign(param_adr, data_name, param_key)
    reference_word_assign(param_adr, data_name, param_key, "cont")
  end

  # 数値の文字列を分割し、Ransackが参照する配列に割り当てる
  def reference_number_assign(param_adr, data_name, param_key)
    if(!param_adr[param_key]) then
        return
    end

    texts = (param_adr[param_key].match("/")) ? param_adr[param_key].split("/") : [param_adr[param_key].dup]

    if texts.is_a?(Array) then
        suffixes = ["_lteq_any", "_gteq_any", "_eq_any"]
        for suffix in suffixes do
            param_adr[:q][data_name + suffix] = Array.new
        end

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
      
      if(text[0] == "!") then
          # マイナス符号への置換
          text.sub!(/!/, '-')
      end
      
      param_adr[:q][data_name + "_" + match_suffix + "_any"].push(text)

  end
  
  # メインキャラ、サブキャラの指定情報の割当
  def sub_no_set(param_adr, show_param_adr)
    show_param_adr["show_main"] = param_adr["show_main"]
    show_param_adr["show_sub"] = param_adr["show_sub"]

    param_adr[:q]["sub_no_eq_any"]  = param_adr[:q]["sub_no_eq_any"] ? param_adr[:q]["sub_no_eq_any"] : []

    if param_adr["show_main"] == "on" then param_adr[:q]["sub_no_eq_any"].push(0) end
    if param_adr["show_sub"] == "on" then
        param_adr[:q]["sub_no_eq_any"].push(1)
        param_adr[:q]["sub_no_eq_any"].push(2)
        param_adr[:q]["sub_no_eq_any"].push(3)
    end
    
    if param_adr[:q]["sub_no_eq_any"].size == 0 then 
        show_param_adr["show_main"] = "on"
        param_adr[:q]["sub_no_eq_any"].push(0)
    end
  end

  private

end
