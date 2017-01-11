Received: from eggs.gnu.org ([2001:4830:134:3::10]:34326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRD8W-0003kR-0C
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 02:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRD8R-0004VL-8Z
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 02:15:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:58940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRD8R-0004Uz-2w
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 02:15:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRD8Q-0008A8-5A
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 07:15:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0B2152E80C9
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 07:15:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jan 2017 06:58:49 -0000
From: Thomas Huth <1619438@bugs.launchpad.net>
Reply-To: Bug 1619438 <1619438@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160901192413.4567.75484.malonedeb@wampee.canonical.com>
Message-Id: <20170111065849.27406.91924.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1619438] Re: GTK+ UI,
 delete key deletes to the left in the monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Released with version 2.8

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1619438

Title:
  GTK+ UI, delete key deletes to the left in the monitor

Status in QEMU:
  Fix Released

Bug description:
  it must delete characters to the right, otherwise it is like having
  two backspaces

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1619438/+subscriptions
