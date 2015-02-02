{"filter":false,"title":"contacts_controller.rb","tooltip":"/app/controllers/contacts_controller.rb","undoManager":{"mark":27,"position":27,"stack":[[{"group":"doc","deltas":[{"start":{"row":200,"column":0},"end":{"row":201,"column":0},"action":"insert","lines":["",""]}]}],[{"group":"doc","deltas":[{"start":{"row":201,"column":0},"end":{"row":202,"column":0},"action":"insert","lines":["",""]}]}],[{"group":"doc","deltas":[{"start":{"row":202,"column":0},"end":{"row":209,"column":0},"action":"insert","lines":["  attr_accessible :first_name, :middle_name, :last_name, :function, ","                  :telephone_business, :telephone_private, :telephone_mobile,","                  :email, :facebook, :twitter, :linkedin, :salutation, :gender, ","                  :background, :title, :birth_date, :fax, :relation_id, ","                  :custom_label_1, :custom_field_1, :custom_label_2, :custom_field_2, ","                  :custom_label_3, :custom_field_3, :has_boss","",""]}]}],[{"group":"doc","deltas":[{"start":{"row":198,"column":0},"end":{"row":199,"column":0},"action":"insert","lines":["",""]}]}],[{"group":"doc","deltas":[{"start":{"row":199,"column":0},"end":{"row":204,"column":0},"action":"insert","lines":["  private","  ","  def branch_params","    params.require(:branch).permit(:branch, :sector_id, :company_id)","  end",""]}]}],[{"group":"doc","deltas":[{"start":{"row":201,"column":6},"end":{"row":201,"column":12},"action":"remove","lines":["branch"]},{"start":{"row":201,"column":6},"end":{"row":201,"column":7},"action":"insert","lines":["c"]}]}],[{"group":"doc","deltas":[{"start":{"row":201,"column":7},"end":{"row":201,"column":8},"action":"insert","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":201,"column":8},"end":{"row":201,"column":9},"action":"insert","lines":["n"]}]}],[{"group":"doc","deltas":[{"start":{"row":201,"column":9},"end":{"row":201,"column":10},"action":"insert","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":201,"column":10},"end":{"row":201,"column":11},"action":"insert","lines":["r"]}]}],[{"group":"doc","deltas":[{"start":{"row":201,"column":11},"end":{"row":201,"column":12},"action":"insert","lines":["a"]}]}],[{"group":"doc","deltas":[{"start":{"row":201,"column":12},"end":{"row":201,"column":13},"action":"insert","lines":["c"]}]}],[{"group":"doc","deltas":[{"start":{"row":201,"column":13},"end":{"row":201,"column":14},"action":"insert","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":202,"column":20},"end":{"row":202,"column":26},"action":"remove","lines":["branch"]},{"start":{"row":202,"column":20},"end":{"row":202,"column":21},"action":"insert","lines":["c"]}]}],[{"group":"doc","deltas":[{"start":{"row":202,"column":21},"end":{"row":202,"column":22},"action":"insert","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":202,"column":22},"end":{"row":202,"column":23},"action":"insert","lines":["n"]}]}],[{"group":"doc","deltas":[{"start":{"row":202,"column":23},"end":{"row":202,"column":24},"action":"insert","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":202,"column":24},"end":{"row":202,"column":25},"action":"insert","lines":["r"]}]}],[{"group":"doc","deltas":[{"start":{"row":202,"column":25},"end":{"row":202,"column":26},"action":"insert","lines":["a"]}]}],[{"group":"doc","deltas":[{"start":{"row":202,"column":26},"end":{"row":202,"column":27},"action":"insert","lines":["c"]}]}],[{"group":"doc","deltas":[{"start":{"row":202,"column":27},"end":{"row":202,"column":28},"action":"insert","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":208,"column":18},"end":{"row":213,"column":61},"action":"remove","lines":[":first_name, :middle_name, :last_name, :function, ","                  :telephone_business, :telephone_private, :telephone_mobile,","                  :email, :facebook, :twitter, :linkedin, :salutation, :gender, ","                  :background, :title, :birth_date, :fax, :relation_id, ","                  :custom_label_1, :custom_field_1, :custom_label_2, :custom_field_2, ","                  :custom_label_3, :custom_field_3, :has_boss"]}]}],[{"group":"doc","deltas":[{"start":{"row":202,"column":37},"end":{"row":202,"column":69},"action":"remove","lines":[":branch, :sector_id, :company_id"]},{"start":{"row":202,"column":37},"end":{"row":207,"column":61},"action":"insert","lines":[":first_name, :middle_name, :last_name, :function, ","                  :telephone_business, :telephone_private, :telephone_mobile,","                  :email, :facebook, :twitter, :linkedin, :salutation, :gender, ","                  :background, :title, :birth_date, :fax, :relation_id, ","                  :custom_label_1, :custom_field_1, :custom_label_2, :custom_field_2, ","                  :custom_label_3, :custom_field_3, :has_boss"]}]}],[{"group":"doc","deltas":[{"start":{"row":211,"column":0},"end":{"row":214,"column":0},"action":"remove","lines":["","","  attr_accessible ",""]}]}],[{"group":"doc","deltas":[{"start":{"row":136,"column":34},"end":{"row":136,"column":49},"action":"remove","lines":["params[:contact"]}]}],[{"group":"doc","deltas":[{"start":{"row":136,"column":34},"end":{"row":136,"column":35},"action":"remove","lines":["]"]}]}],[{"group":"doc","deltas":[{"start":{"row":136,"column":34},"end":{"row":136,"column":49},"action":"insert","lines":["contract_params"]}]}],[{"group":"doc","deltas":[{"start":{"row":112,"column":27},"end":{"row":112,"column":43},"action":"remove","lines":["params[:contact]"]},{"start":{"row":112,"column":27},"end":{"row":112,"column":42},"action":"insert","lines":["contract_params"]}]}]]},"ace":{"folds":[],"scrolltop":0,"scrollleft":0,"selection":{"start":{"row":112,"column":42},"end":{"row":112,"column":42},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":0},"timestamp":1422356009070,"hash":"7c9b9cdd87b0a6542697eeb8b6885f24d92cfeac"}