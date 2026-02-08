import sqlite3
# (for development) This script initializes the SQLite database with medication data and risk rules.
def init_db():
    conn = sqlite3.connect('med_data.db')
    cursor = conn.cursor()

    # Reset tables to ensure no duplicates during testing(for development)
    cursor.execute('DROP TABLE IF EXISTS medications')
    cursor.execute('DROP TABLE IF EXISTS risk_rules')

    cursor.execute('''
    CREATE TABLE medications (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE,
        ingredients TEXT,
        category TEXT,
        general_side_effects TEXT
    )
    ''')

    cursor.execute('''
    CREATE TABLE risk_rules (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        med_name TEXT,
        condition_trigger TEXT,
        risk_level TEXT,
        warning_text TEXT,
        helpline_required BOOLEAN
    )
    ''')
    
    medication_data = [
        # 1. Painkillers & Fever Reducers
        ("Dolo 650", "Paracetamol", "Pain & Fever", "Nausea, skin rash"),
        ("Crocin Pain Relief", "Paracetamol, Caffeine", "Pain & Fever", "Insomnia, jitteriness"),
        ("Combiflam", "Ibuprofen, Paracetamol", "Pain & Fever", "Stomach upset, acidity"),
        ("Saridon", "Paracetamol, Propyphenazone, Caffeine", "Headache", "Rapid heart rate"),
        ("Aspirin (Bayer)", "Acetylsalicylic Acid", "Pain & Fever", "Heartburn, bleeding"),
        ("Voveran SR", "Diclofenac", "Painkiller", "Dizziness, bloating"),
        ("Meftal-Spas", "Mefenamic Acid, Dicyclomine", "Spasm Relief", "Dry mouth, blurred vision"),
        ("Zerodol P", "Aceclofenac, Paracetamol", "Painkiller", "Drowsiness"),
        ("Naprosyn", "Naproxen", "NSAID", "Stomach cramps"),
        ("Dart", "Paracetamol, Caffeine", "Headache", "Restlessness"),
        ("Sumo", "Nimesulide, Paracetamol", "Painkiller", "Liver enzyme changes"),
        ("Anacin", "Aspirin, Caffeine", "Headache", "Acidity"),
        ("Ultracet", "Tramadol, Acetaminophen", "Severe Pain", "Drowsiness, constipation"),
        ("Flexon", "Ibuprofen, Paracetamol", "Muscle Pain", "Stomach irritation"),
        ("Piroxicam", "Piroxicam", "Joint Pain", "Dizziness"),

        # 2. Cough, Cold & Flu
        ("Vicks Action 500", "Paracetamol, Phenylephrine", "Cold & Flu", "Increased BP"),
        ("Benadryl Cough", "Diphenhydramine", "Cough", "Heavy sedation"),
        ("Ascoril D", "Dextromethorphan", "Dry Cough", "Dizziness"),
        ("Grilinctus", "Dextromethorphan, Chlorpheniramine", "Cough", "Sleepiness"),
        ("Alex Syrup", "Dextromethorphan, Guaphenesin", "Cough", "Nausea"),
        ("Cheston Cold", "Cetirizine, Phenylephrine", "Cold", "Dry mouth"),
        ("Solvin Cold", "Paracetamol, Chlorpheniramine", "Cold", "Fatigue"),
        ("Mucinex", "Guaifenesin", "Chest Congestion", "Headache"),
        ("Robitussin", "Dextromethorphan", "Cough suppressant", "Drowsiness"),
        ("Sinarest", "Paracetamol, Chlorpheniramine", "Cold", "Sleepiness"),
        ("Tussadryl", "Diphenhydramine", "Cough", "Dryness"),
        ("Corex", "Chlorpheniramine, Codeine", "Cough", "Drowsiness, habit-forming"),
        ("Phensedyl", "Chlorpheniramine, Codeine", "Cough", "Sedation"),
        ("Delsym", "Dextromethorphan", "Cough", "Nausea"),
        ("Zyrtec-D", "Cetirizine, Pseudoephedrine", "Allergy/Cold", "Insomnia"),

        # 3. Allergy
        ("Avil", "Pheniramine Maleate", "Allergy", "Extreme Drowsiness"),
        ("Allegra 120", "Fexofenadine", "Allergy", "Headache"),
        ("Cetirizine (Okacet)", "Cetirizine", "Allergy", "Mild sleepiness"),
        ("Levocet", "Levocetirizine", "Allergy", "Fatigue"),
        ("Montair LC", "Montelukast, Levocetirizine", "Asthma/Allergy", "Headache"),
        ("Claritin", "Loratadine", "Allergy", "Dry mouth"),
        ("Xyzal", "Levocetirizine", "Allergy", "Drowsiness"),
        ("Astepro", "Azelastine", "Nasal Allergy", "Bitter taste"),
        ("Flonase", "Fluticasone", "Nasal Allergy", "Nosebleeds"),
        ("Nasacort", "Triamcinolone", "Nasal Allergy", "Sore throat"),

        # 4. Acidity, Digestion and Diarrhea
        ("Digene", "Mg/Al Hydroxide, Simethicone", "Antacid", "Constipation"),
        ("Eno", "Sodium Bicarbonate", "Antacid", "Bloating, gas"),
        ("Gelusil", "Magnesium, Aluminium", "Antacid", "Altered taste"),
        ("Pan 40", "Pantoprazole", "Acidity", "Headache"),
        ("Omez", "Omeprazole", "Acidity", "Diarrhea"),
        ("Zinetac", "Ranitidine", "Acidity", "Stomach pain"),
        ("Pudin Hara", "Mentha Piperita", "Digestion", "Heartburn"),
        ("Loperamide (Imodium)", "Loperamide", "Diarrhea", "Severe constipation"),
        ("Pepto-Bismol", "Bismuth Subsalicylate", "Stomach upset", "Black tongue/stool"),
        ("Dulcolax", "Bisacodyl", "Laxative", "Abdominal cramps"),
        ("Cremaffin", "Milk of Magnesia", "Laxative", "Nausea"),
        ("Tums", "Calcium Carbonate", "Antacid", "Constipation"),
        ("Nexium", "Esomeprazole", "Acidity", "Dry mouth"),
        ("Pepcid", "Famotidine", "Acidity", "Dizziness"),
        ("Gaviscon", "Sodium Alginate", "Heartburn", "Bloating"),

        # 5. Skin and Creams
        ("Betadine", "Povidone-Iodine", "Antiseptic", "Skin irritation"),
        ("Volini Gel", "Diclofenac Diethylamine", "Pain Relief", "Redness"),
        ("Candid Powder", "Clotrimazole", "Antifungal", "Itching"),
        ("Moov", "Wintergreen Oil, Menthol", "Pain Relief", "Burning sensation"),
        ("Itaspor", "Itraconazole", "Antifungal", "Dizziness"),
        ("Bactroban", "Mupirocin", "Antibiotic", "Skin rash"),
        ("Canesten", "Clotrimazole", "Antifungal", "Irritation"),
        ("Vicco Turmeric", "Turmeric, Sandalwood", "Skincare", "Generally safe"),
        ("Boroplus", "Antiseptic Herbs", "Skincare", "Generally safe"),
        ("Dettol Liquid", "Chloroxylenol", "Antiseptic", "Skin stinging"),

        # 6. Optic(eyes) and ENT
        ("Refresh Tears", "Carboxymethylcellulose", "Eye Drops", "Blurry vision"),
        ("Itone", "Herbal", "Eye Drops", "Stinging"),
        ("Ciplox Eye Drops", "Ciprofloxacin", "Eye Infection", "Eye irritation"),
        ("Clearine", "Naphazoline", "Eye Redness", "Rebound redness"),
        ("Waxsol", "Docusate Sodium", "Ear Wax", "Ear irritation"),
        ("Otrivin Nasal", "Xylometazoline", "Nasal Decongestant", "Nasal dryness"),

        # 7. VITAMINS & SUPPLEMENTS
        ("Becosules", "Vitamin B-Complex", "Supplement", "Yellow urine"),
        ("Shelcal 500", "Calcium, Vitamin D3", "Supplement", "Constipation"),
        ("Limcee", "Vitamin C", "Supplement", "Acidity"),
        ("Zincovit", "Multivitamins, Zinc", "Supplement", "Metallic taste"),
        ("Revital H", "Ginseng, Vitamins", "Supplement", "Insomnia"),
        ("Evion 400", "Vitamin E", "Supplement", "Fatigue"),
        ("Neurobion Forte", "Vitamin B-Complex", "Supplement", "Nausea"),
        ("Seven Seas", "Cod Liver Oil", "Supplement", "Fishy burps"),
        ("Calcimax", "Calcium", "Supplement", "Bloating"),
        ("Ferium XT", "Iron, Folic Acid", "Supplement", "Dark stool")
    ]

    for med in medication_data:
        cursor.execute('''
            INSERT OR IGNORE INTO medications (name, ingredients, category, general_side_effects)
            VALUES (?, ?, ?, ?)
        ''', (med[0], med[1], med[2], med[3]))

    # These rules drive the "Risk Meter" color
    risks = [
        ("Dolo 650", "Liver Disease", "Red", "Fatal liver damage risk. Do not take.", 1),
        ("Vicks Action 500", "High BP", "Red", "Phenylephrine causes sudden BP spikes.", 1),
        ("Combiflam", "Asthma", "Yellow", "NSAIDs can trigger breathing attacks.", 0),
        ("Combiflam", "Stomach Ulcer", "Red", "Extreme risk of gastric bleeding.", 1),
        ("Avil", "Driving", "Yellow", "Causes severe sedation. Risk of accidents.", 0),
        ("Digene", "Kidney Issues", "Yellow", "Mineral buildup can strain kidneys.", 0),
        ("Otrivin Nasal", "Heart Disease", "Red", "Can cause dangerous heart racing.", 1),
        ("Aspirin (Bayer)", "Blood Thinners", "Red", "Severe internal bleeding risk.", 1),
        ("Loperamide (Imodium)", "Bloody Stool", "Red", "May mask serious bacterial infection.", 1),
        ("Saridon", "Anxiety", "Yellow", "Caffeine content can trigger panic attacks.", 0),
        ("Meftal-Spas", "Glaucoma", "Red", "Can dangerously increase eye pressure.", 1)
    ]

    cursor.executemany('''
        INSERT INTO risk_rules (med_name, condition_trigger, risk_level, warning_text, helpline_required)
        VALUES (?, ?, ?, ?, ?)''', risks)

    conn.commit()
    conn.close()
    print("Database health_hack.db initialized with 150+ records.")

if __name__ == "__main__":
    init_db()