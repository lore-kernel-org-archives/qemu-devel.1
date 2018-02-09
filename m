Received: from eggs.gnu.org ([2001:4830:134:3::10]:60126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ekBTS-0002rA-Qg
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:24:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ekBTL-00043v-SO
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:24:28 -0500
Received: from indium.canonical.com ([91.189.90.7]:57212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ekBTL-00043V-LF
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:24:23 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ekBTK-0001gs-M5
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 16:24:22 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 85BBC2E80D2
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 16:24:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Feb 2018 16:12:39 -0000
From: Thomas Huth <1379688@bugs.launchpad.net>
Reply-To: Bug 1379688 <1379688@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141010081105.4873.97725.malonedeb@wampee.canonical.com>
Message-Id: <151819275961.10002.4435332550182798629.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1379688] Re: qemu's monitor and parallel create
 huge window
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thanks for your answer! Closing now.

** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1379688

Title:
  qemu's monitor and parallel create huge window

Status in QEMU:
  Fix Released

Bug description:
  I have qemu 2.1. When I try to switch to monitor or parallel0, I get
  window which is 30 *thousand* pixels in height. It is only gray with
  no content. This did not happen with previous versions of qemu.

  Kwin crashes because it cannot handle such a huge window.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1379688/+subscriptions
