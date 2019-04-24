Received: from eggs.gnu.org ([209.51.188.92]:42775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAUb-0000qh-Gu
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAUa-0004ck-0u
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:30:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:36320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJAUZ-0004bR-Ou
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:30:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJAUY-0002xC-UL
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:30:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CF6252E80CB
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:30:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 05:24:17 -0000
From: Thomas Huth <1682128@bugs.launchpad.net>
Reply-To: Bug 1682128 <1682128@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170412132210.31027.40009.malonedeb@wampee.canonical.com>
Message-Id: <155608345871.13969.12932132132389971674.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1682128] Re: solaris can't power off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

*** This bug is a duplicate of bug 823733 ***
    https://bugs.launchpad.net/bugs/823733

** This bug has been marked a duplicate of bug 823733
   Soloaris can't be poweroff

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
