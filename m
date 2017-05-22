Received: from eggs.gnu.org ([2001:4830:134:3::10]:36497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dCpry-0002ST-0J
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dCprx-00078A-6X
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:07:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:54883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dCprx-00076f-1A
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:07:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dCpru-0006rE-EI
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 16:07:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F04272E80E7
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 16:07:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 May 2017 15:45:42 -0000
From: Thomas Huth <1300021@bugs.launchpad.net>
Reply-To: Bug 1300021 <1300021@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140331055853.6092.52126.malonedeb@chaenomeles.canonical.com>
Message-Id: <149546794244.11717.9557155370199460096.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1300021] Re: after loadvm the system clock isn't
 current time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... Which version of QEMU did you use here? Can
you still reproduce the problem with the latest version of QEMU? How did
you start QEMU? Did you specify the -rtc parameter?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1300021

Title:
  after loadvm the system clock isn't current time

Status in QEMU:
  Incomplete

Bug description:
  hi,
  when i load a  snapshot of month ago using "loadvm  name"command, the vm =
system time is past time,not recover current time.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1300021/+subscriptions
