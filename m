Received: from eggs.gnu.org ([2001:4830:134:3::10]:34991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1epsx3-0005FU-AS
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 04:50:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1epsx0-0004Qm-7o
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 04:50:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:51148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1epsx0-0004Q9-15
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 04:50:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1epswy-0005HQ-Tk
	for <qemu-devel@nongnu.org>; Sun, 25 Feb 2018 09:50:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DFCE72E80CB
	for <qemu-devel@nongnu.org>; Sun, 25 Feb 2018 09:50:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Feb 2018 09:41:15 -0000
From: Thomas Huth <1751422@bugs.launchpad.net>
Reply-To: Bug 1751422 <1751422@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151945759115.32735.10228929932246006018.malonedeb@chaenomeles.canonical.com>
Message-Id: <151955167572.5890.18128556928250429154.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1751422] Re: some instructions translate error in
 x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Could you please provide some more information about the problem? What's
exactly the error? If you've already got a patch, please have a look at
https://wiki.qemu.org/Contribute/SubmitAPatch to get some information
how to submit it.

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1751422

Title:
  some instructions translate error in x86

Status in QEMU:
  Incomplete

Bug description:
  There is some instructions translation error on target i386 in many versi=
ons, such as 2.11.1, 2.10.2, 2.7.1 and so on.
  The error translation instructions include les, lds. I has got a patch, b=
ut I have no idea how to apply it.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1751422/+subscriptions
