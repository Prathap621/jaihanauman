
My apologies for the confusion. Thank you for pointing that out. Here's the corrected script with separate checks for tree and acl:

bash
Copy code
#!/bin/bash
set -e

# Function to check if a package is installed
is_package_installed() {
    local package_name="$1"
    if dpkg -l | grep -q "ii  $package_name "; then
        return 0 # Package is installed
    else
        return 1 # Package is not installed
    fi
}

# Function to install dos2unix
install_dos2unix() {
    echo "Installing dos2unix..."
    sudo apt install dos2unix -y
}

# Function to install tree
install_tree() {
    echo "Installing tree..."
    sudo apt install tree -y
}

# Function to install acl
install_acl() {
    echo "Installing acl..."
    sudo apt install acl -y
}

# Main script
main() {
    if ! is_package_installed "dos2unix"; then
        install_dos2unix
    else
        echo "dos2unix is already installed."
    fi

    if ! is_package_installed "tree"; then
        install_tree
    else
        echo "tree is already installed."
    fi

    if ! is_package_installed "acl"; then
        install_acl
    else
        echo "acl is already installed."
    fi

    echo "Installation completed."
}

# Run the main function
main
