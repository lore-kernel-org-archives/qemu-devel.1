Received: from eggs.gnu.org ([2001:4830:134:3::10]:48695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ctDqO-0002ld-DY
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ctDqK-0003c9-8i
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:41:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:47501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ctDqK-0003bq-3C
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:40:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ctDqH-00054b-Mo
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 13:40:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A30AE2E80C6
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 13:40:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Mar 2017 13:32:36 -0000
From: luigiburdo <intermediadc@hotmail.com>
Reply-To: Bug 1677247 <1677247@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170329133236.25783.88509.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1677247] [NEW] QEMU e500 kvm no video and kernel
 crashing in virtios modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Hi,
i been attached the log of my issue on Qoriq e5500
when i start qemu-system-ppc64  -cpu e5500 -M ppce500 --enable-kvm -device =
virtio-gpu-pci  --nodefaults -display gtk and so and so . i have crashes in=
 virtio modules in the VM and continue traces on the host machine.
If is needed more for investigating ask freely .

Note: i use my selfmade kernel this machine dont have a distro kenels
and official kernels.


Ciao =

Luigi

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "qemu.log"
   https://bugs.launchpad.net/bugs/1677247/+attachment/4849737/+files/qemu.=
log

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1677247

Title:
  QEMU e500 kvm no video and kernel crashing in virtios modules

Status in QEMU:
  New

Bug description:
  Hi,
  i been attached the log of my issue on Qoriq e5500
  when i start qemu-system-ppc64  -cpu e5500 -M ppce500 --enable-kvm -devic=
e virtio-gpu-pci  --nodefaults -display gtk and so and so . i have crashes =
in virtio modules in the VM and continue traces on the host machine.
  If is needed more for investigating ask freely .

  Note: i use my selfmade kernel this machine dont have a distro kenels
  and official kernels.

  =

  Ciao =

  Luigi

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1677247/+subscriptions
