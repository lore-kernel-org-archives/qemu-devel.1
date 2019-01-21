Received: from eggs.gnu.org ([209.51.188.92]:33300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1glchJ-0000Ao-WD
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 11:45:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1glcdC-0005Qt-DL
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 11:41:03 -0500
Received: from indium.canonical.com ([91.189.90.7]:43956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1glcdC-0005Q6-7y
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 11:41:02 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1glcdA-0001QG-O4
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 16:41:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B40FC2E80CE
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 16:41:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Jan 2019 16:25:51 -0000
From: CandyMan <1812694@bugs.launchpad.net>
Reply-To: Bug 1812694 <1812694@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154808795140.25200.13223693574023659013.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1812694] [NEW] qemu-system-x86_64 version 3.0+ is
 20 times slower than version 2.12
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

version 3.0+ is 20 times slower than version 2.12
I wrote a small 64-bit operating system (SIGMAOS) in which I use the lzma d=
ecoder. unpacking the file takes 20 times slower than in version 2.12.
You can download it from https://drive.google.com/drive/folders/0B_wEiYjzVk=
C0ZGtkbENENzF1Nms

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1812694

Title:
  qemu-system-x86_64 version 3.0+ is 20 times slower than version 2.12

Status in QEMU:
  New

Bug description:
  version 3.0+ is 20 times slower than version 2.12
  I wrote a small 64-bit operating system (SIGMAOS) in which I use the lzma=
 decoder. unpacking the file takes 20 times slower than in version 2.12.
  You can download it from https://drive.google.com/drive/folders/0B_wEiYjz=
VkC0ZGtkbENENzF1Nms

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1812694/+subscriptions
