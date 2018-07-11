Received: from eggs.gnu.org ([2001:4830:134:3::10]:43921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fd9VU-0007Lu-6O
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 03:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fd9VQ-0006FI-6b
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 03:25:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:49444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fd9VQ-0006EJ-01
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 03:25:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fd9VP-0002Pe-1I
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 07:25:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 069492E80CB
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 07:25:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jul 2018 07:13:03 -0000
From: Thomas Huth <1476800@bugs.launchpad.net>
Reply-To: Bug 1476800 <1476800@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150721190344.30370.48553.malonedeb@gac.canonical.com>
Message-Id: <153129318326.4037.10677046485168968061.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1476800] Re: Instant runtime error (Host: Windows
 8.1 VM: WinXP ISO)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets... which version of QEMU did you use
here? Can you still reproduce this issue with the latest version of
QEMU? Or could we close this ticket nowadays?


** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1476800

Title:
  Instant runtime error (Host: Windows 8.1 VM: WinXP ISO)

Status in QEMU:
  Incomplete

Bug description:
  I have Qemu Manager on my Windows 8.1 laptop and have a WXP iso and a
  blank disk image (from here
  http://www.mediafire.com/download/rtec86bwwmee00s/Blank_Disk.zip ) and
  as soon as I try to open it I get a Runtime Error (
  http://i.gyazo.com/bfebf7e1e7a670f8e52cc95c5923a67e.png )

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1476800/+subscriptions
