Received: from eggs.gnu.org ([209.51.188.92]:40720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hIo9g-0007FF-QP
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 01:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hIo0J-0007ak-KJ
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 01:30:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:47716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hIo0H-0007Xb-UO
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 01:30:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hIo0F-0006XX-H6
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 05:29:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 782442E806D
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 05:29:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Apr 2019 05:15:47 -0000
From: Thomas Huth <1615079@bugs.launchpad.net>
Reply-To: Bug 1615079 <1615079@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160819182404.11358.22174.malonedeb@soybean.canonical.com>
Message-Id: <155599654722.16959.17041950424430486409.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1615079] Re: GTK+ UI virtual consoles scrolling
 broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Are you talking about serial console? Or graphical (VGA) console? Which
QEMU target (x86? ... and which machine?)? How did you start QEMU? ...
this bug report clearly lacks some more information...

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1615079

Title:
  GTK+ UI virtual consoles scrolling broken

Status in QEMU:
  Incomplete

Bug description:
  "In the virtual consoles, you can use Ctrl-Up, Ctrl-Down, Ctrl-PageUp
  and Ctrl-PageDown to move in the back log."

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1615079/+subscriptions
