Received: from eggs.gnu.org ([2001:4830:134:3::10]:41599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1emu4Z-0001QS-Os
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 23:26:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1emu4Y-00064q-Qc
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 23:26:03 -0500
Received: from indium.canonical.com ([91.189.90.7]:44828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1emu4Y-00061E-L1
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 23:26:02 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1emu4V-0002Qn-7b
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 04:25:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4AB312E81D5
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 04:25:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Feb 2018 04:17:25 -0000
From: Launchpad Bug Tracker <1721187@bugs.launchpad.net>
Reply-To: Bug 1721187 <1721187@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150709842178.2640.16899221192910481679.malonedeb@chaenomeles.canonical.com>
Message-Id: <151884104588.16257.8978291386252183311.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1721187] Re: install Centos7 or fedora27 on qemu
 on windows8.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1721187

Title:
  install Centos7 or fedora27 on qemu on windows8.1

Status in QEMU:
  Expired

Bug description:
  Hello,
  I have tried to install CentOs or Fedora27 on my Windows8 using QEMU. I w=
ork on notepad with 4GB.
  Unfortunatly, my touchpad nor my usb-mouse are not recognise on the graph=
ical installation of CentOs and Fedora installation. So, I cannot install t=
hem.
  Here are the commands I use for installation :

  qemu-img create -f qcow2 fedora27b2_hd.qcow2 80G

  qemu-system-x86_64 -k fr -hda fedora27b2_hd.qcow2 -cdrom Fedora-
  Workstation-Live-x86_64-27_Beta-1.5.iso -m 512 -boot d

  I have tried to add the option : -device usb-mouse  but, I got the
  error message that no 'usb-bus' found for the usb-mouse device.

  What is wrong ?  QEMU or my installation command ?

  Thank, BRgds,
  Laurent

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1721187/+subscriptions
