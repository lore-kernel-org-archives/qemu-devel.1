Received: from eggs.gnu.org ([2001:4830:134:3::10]:34721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cPidw-0002HC-1E
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 23:30:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cPids-0000oP-UW
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 23:30:12 -0500
Received: from indium.canonical.com ([91.189.90.7]:34514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cPids-0000mt-Ot
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 23:30:08 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cPidq-00008K-6t
	for <qemu-devel@nongnu.org>; Sat, 07 Jan 2017 04:30:06 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2A6552E80BF
	for <qemu-devel@nongnu.org>; Sat,  7 Jan 2017 04:30:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Jan 2017 04:17:29 -0000
From: Launchpad Bug Tracker <1500935@bugs.launchpad.net>
Reply-To: Bug 1500935 <1500935@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150929154008.23320.1415.malonedeb@gac.canonical.com>
Message-Id: <20170107041730.790.76321.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1500935] Re: Qemu / KVM always wants to be on top
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
https://bugs.launchpad.net/bugs/1500935

Title:
  Qemu / KVM always wants to be on top

Status in QEMU:
  Expired

Bug description:
  Whenever I pass with the mouse over the KVM (qemu) window, it automatical=
ly raises on top, obscuring other windows on the same desktop, which is rat=
her intrusive...
  No other application does this.

  > dpkg -l qemu-kvm
  Desired=3DUnknown/Install/Remove/Purge/Hold
  | Status=3DNot/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Tr=
ig-pend
  |/ Err?=3D(none)/Reinst-required (Status,Err: uppercase=3Dbad)
  ||/ Name           Version      Architecture Description
  +++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  ii  qemu-kvm       2.0.0+dfsg-2 amd64        QEMU Full virtualization

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1500935/+subscriptions
