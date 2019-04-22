Received: from eggs.gnu.org ([209.51.188.92]:47085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hIcN9-0006Av-6O
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 13:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hIcN8-0005Ma-8P
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 13:04:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:34342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hIcN6-0005K2-Bj
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 13:04:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hIcN4-0005Dm-1v
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 17:04:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 063602E800F
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 17:04:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Apr 2019 16:53:03 -0000
From: Bug Report <1615079@bugs.launchpad.net>
Reply-To: Bug 1615079 <1615079@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160819182404.11358.22174.malonedeb@soybean.canonical.com>
Message-Id: <155595198337.16887.16029173689703845818.malone@soybean.canonical.com>
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

VTE is required for this to work?

if yes, the configure script should have info about the dependency

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1615079

Title:
  GTK+ UI virtual consoles scrolling broken

Status in QEMU:
  New

Bug description:
  "In the virtual consoles, you can use Ctrl-Up, Ctrl-Down, Ctrl-PageUp
  and Ctrl-PageDown to move in the back log."

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1615079/+subscriptions
