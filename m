Received: from eggs.gnu.org ([2001:4830:134:3::10]:54775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cyIMH-0000Yh-Ip
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cyIMD-0005L4-KP
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:30:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:34107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cyIMD-0005Kl-EA
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:30:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cyIMB-0005cy-9B
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 13:30:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 258FE2E80CE
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 13:30:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Apr 2017 13:22:10 -0000
From: shan0923 <1682128@bugs.launchpad.net>
Reply-To: Bug 1682128 <1682128@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170412132210.31027.40009.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1682128] [NEW] solaris can't power off
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

I have created solaris 10 VM on KVM. Everything in VM is running OK, but
finally I use shell command =E2=80=98poweroff=E2=80=99 or =E2=80=98init 5=
=E2=80=99, the solaris VM
system could=E2=80=99t be poweroff but with promoting me the message: perss=
 any
key to reboot =E2=80=A6..

but on Xen, solaris can be powerofff

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: acpi

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1682128

Title:
  solaris can't power off

Status in QEMU:
  New

Bug description:
  I have created solaris 10 VM on KVM. Everything in VM is running OK,
  but finally I use shell command =E2=80=98poweroff=E2=80=99 or =E2=80=98in=
it 5=E2=80=99, the solaris VM
  system could=E2=80=99t be poweroff but with promoting me the message: per=
ss
  any key to reboot =E2=80=A6..

  but on Xen, solaris can be powerofff

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1682128/+subscriptions
