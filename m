Received: from eggs.gnu.org ([2001:4830:134:3::10]:59465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdiFb-0000ds-MH
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 13:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdiFW-0000Vl-Qk
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 13:54:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:58842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cdiFW-0000VO-L3
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 13:54:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cdiFV-0004Qb-61
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 18:54:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D2B5A2E80CE
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 18:54:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Feb 2017 18:44:27 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 764252 <764252@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110418053344.23556.39759.malonedeb@wampee.canonical.com>
Message-Id: <20170214184428.5677.23976.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 764252] Re: wishlist: kirkwood support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

My offer from comment #3 to review code if anybody wants to submit it
still stands, but given the amount of work required to implement a model
of a new SoC in QEMU I'm not surprised nobody's ever taken me up on it.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/764252

Title:
  wishlist: kirkwood support

Status in QEMU:
  Won't Fix

Bug description:
  This is a feature request for qemu to emulate the Marvell Kirkwood
  chipset. It is used by Sheevaplug, Guruplug, and many NAS devices.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/764252/+subscriptions
