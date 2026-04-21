# Original encoded sequence
encoded_flag = "N3D3R_RC_RRNDØ3MØ_44M{1M4T7M4NML143L33TV5!L__33T}"

# Dictionary for substitutions
substitutions = {
    "3": "E",
    "Ø": "O",
    "4": "A",
    "7": "T",
    "5": "S",
    "1": "I",
    "_": " ",  # Replace underscores with spaces
}

# Function to decode the sequence
def decode_sequence(sequence, subs):
    for key, value in subs.items():
        sequence = sequence.replace(key, value)
    return sequence

# Apply substitutions
decoded_flag = decode_sequence(encoded_flag, substitutions)

# Manual refinements or guesses for readability
decoded_flag = decoded_flag.replace("  ", " ").strip()  # Adjust spacing
decoded_flag = decoded_flag.replace("RRNDOEMO", "RANDOMO")  # Contextual guess
decoded_flag = decoded_flag.replace("IMATTMAN", "IMATT MAN")  # Contextual guess
decoded_flag = decoded_flag.replace("NMLIAELEETVS", "NAME LEETVS")  # Contextual guess

# Print final flag
print(decoded_flag)
