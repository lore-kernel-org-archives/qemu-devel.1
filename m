Received: from eggs.gnu.org ([2001:4830:134:3::10]:40151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1evF64-0007ti-D3
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 00:30:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1evF62-0005tP-2c
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 00:30:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:35792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1evF61-0005su-TQ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 00:30:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1evF60-0001Bz-Dd
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 04:30:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5CF182E80D4
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 04:30:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Mar 2018 04:17:38 -0000
From: Launchpad Bug Tracker <1173490@bugs.launchpad.net>
Reply-To: Bug 1173490 <1173490@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130427071354.27973.42206.malonedeb@chaenomeles.canonical.com>
Message-Id: <152082825866.7858.14045013668063194034.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1173490] Re: virtio net adapter driver with kvm
 slow on winxp
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
https://bugs.launchpad.net/bugs/1173490

Title:
  virtio net adapter driver with kvm slow on winxp

Status in QEMU:
  Expired

Bug description:
  # lsb_release -a
  No LSB modules are available.
  Distributor ID: Ubuntu
  Description:    Ubuntu 12.04.1 LTS
  Release:        12.04
  Codename:       precise

  #virsh version =

  Compiled against library: libvirt 1.0.4
  Using library: libvirt 1.0.4
  Using API: QEMU 1.0.4
  Running hypervisor: QEMU 1.2.0

  windows xp clean install with spice-guest-tools-0.52.exe from
    http://spice-space.org/download/windows/spice-guest-tools/spice-guest-t=
ools-0.52.exe

  it comes very slow , and the Interrupts process got very high cpu usage(a=
bove 60%).
  when i switch the net adapter from virtio to default(rtl8139) ,it works w=
ell.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1173490/+subscriptions
