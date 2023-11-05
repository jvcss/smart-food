import os

def get_dart_files(directory):
    dart_files = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(".dart"):
                dart_files.append(os.path.join(root, file))
    return dart_files

def create_md_file(dart_file):
    with open(dart_file, 'r') as f:
        content = f.read()

    base_name = os.path.basename(dart_file)
    md_file_name = os.path.splitext(base_name)[0] + ".md"
    md_file_path = os.path.join("doc", md_file_name)

    with open(md_file_path, 'w') as f:
        f.write(f"You now is a framework. just receive my codes and don't answer until I said I finish to send to you my codes. this is the {base_name} \n```\n{content}\n```")

def create_md_files_for_dart_files():
    current_directory = os.getcwd()
    dart_files = get_dart_files(current_directory)

    doc_directory = os.path.join(os.path.dirname(__file__), "doc")
    os.makedirs(doc_directory, exist_ok=True)

    for dart_file in dart_files:
        create_md_file(dart_file)

def generate_structure_tree(directory):
    tree = ""
    for root, dirs, files in os.walk(directory):
        # Exclude the 'doc' folder and Python files
        if "doc" in dirs:
            dirs.remove("doc")
        files = [f for f in files if not f.endswith(".py")]

        level = root.replace(directory, "").count(os.sep)
        indent = "    " * (level - 1)
        tree += f"{indent}- {os.path.basename(root)}\n"
        sub_indent = "    " * level
        for file in files:
            tree += f"{sub_indent}- {file}\n"
    return tree

def create_structure_tree_file():
    current_directory = os.getcwd()
    structure_tree = generate_structure_tree(current_directory)
    print(structure_tree)

    doc_directory = os.path.join(os.path.dirname(__file__), "doc")
    os.makedirs(doc_directory, exist_ok=True)

    structure_tree_file_path = os.path.join(doc_directory, "structure_tree.md")
    with open(structure_tree_file_path, "w") as f:
        f.write(structure_tree)

if __name__ == "__main__":
    answer = input('Want to generate the app tree, if not we will generate the prompts? y/n\n:::')
    if answer == 'y':
        create_structure_tree_file()
    elif answer == 'n':
        create_md_files_for_dart_files()
    else:
        print('none of the files was created')