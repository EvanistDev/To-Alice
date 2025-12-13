function InterfaceManager() constructor {
    self.texts = {};
    
    self.load_json = function(json_string) {
        self.texts = json_parse(json_string);
    };
    
    // Método auxiliar para pegar texto com fallback
    self.get_text = function(category, key) {
        if (variable_struct_exists(self.texts, category)) {
            if (variable_struct_exists(self.texts[$ category], key)) {
                return self.texts[$ category][$ key];
            }
        }
        return "MISSING: " + category + "." + key;
    };
}