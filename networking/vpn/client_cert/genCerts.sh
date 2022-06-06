
# Generate certificate for Client VPN

certificate-name="$(1)"
certificate-dir="$(2)"
current-dir="$(pwd)"

rm -rf "${current-dir}/${certificate-dir}"
mkdir "${current-dir}/${certificate-dir}"

cd easy-rsa || exit
rm -rf pki
./easyrsa init-pki
./easyrsa build-ca nopass
./easyrsa build-client-full client."${certificate-name}" nopass
./easyrsa build-server-full "${certificate-name}" nopass
cp pki/issued/* "${current-dir}/${certificate-dir}"
cp pki/ca.crt "${current-dir}/${certificate-dir}"
cp pki/private/* "${current-dir}/${certificate-dir}"
