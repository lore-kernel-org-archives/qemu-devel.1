Received: from eggs.gnu.org ([2001:4830:134:3::10]:43246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cffbu-0005L9-Ni
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 23:30:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cffbq-0006K5-P2
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 23:30:02 -0500
Received: from indium.canonical.com ([91.189.90.7]:44799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cffbq-0006Ja-Ix
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 23:29:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cffbn-0000MP-W3
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:29:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B7CC92E8193
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:29:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Feb 2017 04:17:28 -0000
From: Launchpad Bug Tracker <696530@bugs.launchpad.net>
Reply-To: Bug 696530 <696530@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110102153123.20075.24776.malonedeb@soybean.canonical.com>
Message-Id: <20170220041729.27201.83030.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 696530] Re: qemu-0.13.0-r2 special keys different
 when using -alt-grab
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
https://bugs.launchpad.net/bugs/696530

Title:
  qemu-0.13.0-r2 special keys different when using -alt-grab

Status in QEMU:
  Expired

Bug description:
  I use -alt-grab with qemu-0.13.0-r2 and special keys like Ctrl-Alt-f
  for full screen did not work for me with a windows guest. They work
  normally when omitting the -alt-grab startup parameter.

  After quite a long time, I found out that I have to add the shift key
  to the keys from the documentation when I use the -alt-grab option.

  Probably -ctrl-grab behaves similarly. It would be really nice to have
  this documented in the default documentation in the man page as has
  not been documented there yet.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/696530/+subscriptions
