module PagesHelper
    def party_members(members)
        if !members then
            return
        end

        members.each do |member|
          haml_concat member.pc_name.nickname if member.pc_name
          haml_concat "(" + sprintf("%d", member.e_no) + ")"
          haml_tag :br
        end
    end

    def enemy_members(members)
        if !members then
            return
        end

        members.each do |member|
          haml_concat member.enemy.name if member.enemy
          haml_concat member.suffix.name if member.enemy
          haml_tag :br
        end
    end
end
