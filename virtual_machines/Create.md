## Creating Virtual Machines 

> This documentation is about how to create a virtual machine on a server using virt-manager

## Tools

 - A server / computer
 - Virtual machines manager
 - Your attention

## Installation and setup steps
 1. Check if your server supports virtualization

  ```
  egrep -c '(vmx|svm)' /proc/cpuinfo
  ```

 2. Install QEMU/KVM, libvirt, bridge-utils, libvirt-clients,  -
     - Qemu is the actual emulator/virtualizer that runs VMS. Qemu emulates hardware platforms (CPU, memory, disk, etc.)
     -  KVM(Kernel-based virtual machine) is a hardware-assisted virtualization technology built into the Linux kernel, enables hardware accelartion, making Vms much faster. 
     - Libvirt	Manages VMs, networks, and storage for QEMU/KVM.
     - Libvirt-daemon-system ensures libvirtd is running properly as a service
     - Libvirt-clients - includes client-side command-line tools to interact with the libvirtd daemon
     - Bridge utils - a package that provides the commands to create and manage network bridges.

  ``` apt-get install qemu-kvm bridge-utils libvirt-daemon-system libvirt-clients ``` 
 
  ``` kvm-ok ```
 
 If you see this:
 
 ``` INFO: /dev/kvm exists ```
 
 ```KVM acceleration can be used```
 
 You're good to continue

 3. Start and enable libvirtd service - This will start libvirtd service on system reboot
   
    ```sudo systemctl start libvirtd```
   
    ```sudo systemctl enable libvirtd```

 4. Add your user to the libvirt group
   
    ```sudo usermod -aG libvirt $(whoami)```

 5. Log out and log back in

 6. Install virt-manager(virtual machines manager) - This si a hraphical user interface for managing virtual machines using libvirt. It connect to libvirtd adn gives you a visual way to create, delete and manage Vms run this on your command line
    
    ``` apt-get install virt-manager ```

 7. Launch virt-manager
    
    ```virt-manager```

## Creating and managing virtual machines.

 1. Open the virtual machines manager.

 2. Right click on QEMU/KVM. A pop up window till appear. Click on new.

 3. A new popup window will appear that will display the first process in creating a new virtual machine which is the options you want to choose to install the operating system.

 4. Choose local install media (ISO image or CDROM) if you have a bootable drive connected to your host(computer or server) that has the ISO image or if you have the ISO image in your computer/server installed. Choose network install if you want to download and install the OS directly from on online mirror. Choose Import existing disk image if you want to use a pre-installed virtual disk(e.g from another VM or cloud image), a virtual disk is a file that acts like a physical hard drive for a virtual machine (VM), It’s a file stored on your real computer that the VM sees as its own hard disk.. Choose manual install to create the vm and install the os later (e.g attach the media manually). This documentation will assume you picked the Local install media
 
 5. The next step would be to choose the ISO media and choose the operating system you are installing. When you choose the ISO media virt-manager will automatically choose the operating system if you check the "Automatically detect from the installation media/source, if not, you can search for it manually.

 6. The next step is choosing memory and cpu settings. Choose these carefully according to your details. Be keen on the margin differnces between gbs and gibs.

 7. The next step is configuring the storage prefences for your vm. Again bet careful with the difference between GiB and gbs. Check the 'Enable storage for this virtual macine' option. Choose the create a disk image for the virtual machine if you do not have a storage pool allocated beforehand for this new vm and select tthe storage capacity you want your vm to have. The vm disk image will be stored in the default path of libvirt which is '/var/lib/libvirt/images/'. Choose 'Select or create a custom storage for your vm' if you don't want your vm disk to be stored in the default path. With this option selected you can create or select a location in your host computer (can be another partition) where you want your vm disk image(hard disk, volumes) to be stored. This is documentation followed the 'Select or create a custom storage'

 8. Click on manage to choose the path. Create a pool for the path where your disks will be stored virt-manager will save this if you would like to use it again. A pool is a path to where you would want your disks to be stored(Not the default one). You can create one for the iso images as well. Click on the green + button on your bottom left. give your pool a name. I gave my disks because this pool is specifically for disks. Select the target path. Mine was a directory /QEMU/KVM/disks. Click finish. A new pool should appear in the left panel.

 9. Create a volume, this is like your vm hard disk. Click on a green + button next to Volumes in the center panel. Give your volume a name. Allocate the storage capactiy. Check the 'Allocate entire volume now'. Click finish. Seelct the volume you created and click Choose volume. Click forward

 10. The next step is validating and choosing a name for your vm. Select the Customize configuration before install option. On network selection leave it a virtual network 'default : NAT for now. Click finish

 ## Installation process

 1. I am assuming you have seen a new pop up window. Relax. This window is for validation and other changes you wish to change before you begin the installation process. If you make any changes in the tab click apply on your bottom right before moving to the next tab

 2. Confirm the basic details and add more if you wish to. Jump to the OS information tab to the OS information. Go to the CPU tab and validate the cpus you allocated. Head to the memory tab and validate. Fast and forward to the Boot options tab and check the 'Start virtual machine on host boot up' option. Click apply on you bottom right.  Move to the VirtIO Disk 1 and validate. Do this for all tabs upto the NIC tab.

 3. In the NIC tab, we will make some changes, if you're using a computer and your host is connected to wireless network (WIFI), you can get the mac address shown registered in your company's network then  move to the next tab which we will work on, the Display Spice. If you server/computer/host is connected via ethernet or wired connection (direct connection) you must use a bridge to connect to the LAN network. A network bridge connects the vm to the host's network. Network bridging is a method used to connect two or more separate network interfaces at the data link layer (Layer 2 of the OSI model), making them act as if they are part of the same physical network. It's commonly used in virtualization to give virtual machines (VMs) direct access to the host’s network.

 4. To create a network bridge in ubuntu navigate to 
 
 ``` /etc/netplan``` 
 
  and modify the main yaml file. A sample configuration of a bridge

```
#This is the network config written by 'subiquity' network:
        version: 2
        renderer: networkd
        ethernets:
                eno1np0:
                        dhcp4: false
                        dhcp6: false
        bridges:
                br0:
                        # dhcp4: no
                        # dhcp6: no
                        interfaces: [eno1np0]
                        addresses: [172.28.71.18/24]
                        gateway4: 172.28.0.254
                        nameservers:
                                addresses: [172.28.0.38, 172.28.0.37, 172.28.0.24, 172.28.0.128]  
```
Finally run 

```sudo netplan apply```

5. Get your mac address registered in your company's network to prevent and restrictions. Click apply and head on to the Display spice

6. In the display spice server select the Spice server in the type dropdown. Select address in the listen type drop down. Select the All interfaces in the address drop down. Click apply and you can begin the installation by clicking the Begin installation on you top left..

## Ubuntu installation Process.

1. A page will show up asking you to choose your preferred os language, press enter to choose and move to the next part which is keyboard configuration choose your preffered layout and variant.

2. The next part is the base for the installation, i went with ubuntu server. After that move the network configuration, click done (you can modify the IP after the os has installed). Proxy Configuration is the next step, click done. The next step is the mirror configuration, i went with the defaul one

3. Next is a guided storage configuration. I selected 'Use an entire disk' and moved on. A filesystem summary will show up. Unmount the root (/) mount point to have full free space. Delete any avaliable device that is taking up space to have full free space (full storage capacity of your vm). You should have free space and ubuntu-vg(new) or another device with the same space. 

4. Next step is creating your logical volume. Click on the free space and select create logical volume. Name can be changed or left as the default. Prioritise creating a logical volume for the root(/) first the mount should be /, format should be ext4, and the space you wish to allocate the roo. Click create and do the same to the free space for the partitions you wish to have. For data 1, at the mount section, select other and save it as data1/ . Click done to move on to the next section

5. Next is profile configuration, this is self explanatory. Here you will configure the server name and the username of your first user and the password of the user. Next step is SSH configuration, select Install OpenSSH server.

6. The next section is rebooting and you should be good to go




