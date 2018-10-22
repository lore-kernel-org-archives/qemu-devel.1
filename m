Received: from eggs.gnu.org ([2001:4830:134:3::10]:48964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gEhTq-0004pn-HA
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 17:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gEhTn-0001or-0m
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 17:11:18 -0400
Received: from indium.canonical.com ([91.189.90.7]:41592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gEhTm-0001na-NO
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 17:11:14 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gEhTk-0001nn-4p
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 21:11:12 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 71A0C2E80DD
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 21:11:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Oct 2018 21:05:03 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Reply-To: Bug 1743441 <1743441@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151604323239.5020.7297818634644485125.malonedeb@wampee.canonical.com>
Message-Id: <154024230333.29390.14977751102894858721.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1743441] Re: OS/2 Warp 4.52 OS2LVM failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Is this a regression on previous behaviour or has never worked? What is
the command line you used to launch QEMU? What version have you tested
on?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1743441

Title:
  OS/2 Warp 4.52 OS2LVM failure

Status in QEMU:
  Incomplete

Bug description:
  When I try to boot OS/2 Warp 4.51 (Merlin), 4.52 (Aurora) or eCS 1.2.5, e=
tc. I always get an exception in OS2LVM (TRAP 000E). Tried both FAT and HPF=
S. You can reproduce the bug using this disk image: https://drive.google.co=
m/open?id=3D1zzjs9hTS0TK-Xb5hnon8SQ-2C1EmlYfy
  P.S. OS/2 Warp 4.0 boots OK (if installed on FAT, not HPFS)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1743441/+subscriptions
