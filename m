Received: from eggs.gnu.org ([2001:4830:134:3::10]:50602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTZmH-0004io-0x
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:50:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTZmD-0006Mz-0o
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:50:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:59935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTZmC-0006Mq-Lo
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:50:40 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTZmB-00055r-0o
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 19:50:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 046D92E80C4
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 19:50:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jan 2017 19:40:25 -0000
From: Thomas Huth <1655764@bugs.launchpad.net>
Reply-To: Bug 1655764 <1655764@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170111212721.20360.4397.malonedeb@wampee.canonical.com>
Message-Id: <20170117194025.21721.24740.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1655764] Re: qemu-img convert -c compression
 can't decompress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Which version of QEMU (or rather qemu-img) are you using?

** Information type changed from Private to Public

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1655764

Title:
  qemu-img convert -c compression can't decompress

Status in QEMU:
  New

Bug description:
  Used -c compression option of qemu-img convert to compress qcow2,
  then libvirt mount for compressed image don't work as well as decompressi=
on also
  not working, tried zlib-flate to decompress

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1655764/+subscriptions
