Received: from eggs.gnu.org ([209.51.188.92]:60751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gre49-0000aI-0r
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 02:25:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gre45-0004tn-4B
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 02:25:43 -0500
Received: from indium.canonical.com ([91.189.90.7]:46068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gre43-0004rX-Il
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 02:25:40 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gre40-0001iv-N6
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 07:25:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A41012E80C7
	for <qemu-devel@nongnu.org>; Thu,  7 Feb 2019 07:25:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Feb 2019 07:18:48 -0000
From: Frantisek Novak <1815009@bugs.launchpad.net>
Reply-To: Bug 1815009 <1815009@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154952392807.22205.13838145528944162860.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1815009] [NEW] Qemu evdev multiple guests/host
 switch
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

Hello,

Qemu up to version 3.1

it would be nice if passed through evdev can be switched (using lctrl +
rctrl) through all running guests configured for evdev passthrough and
the host. Currently, only the last started guest and host can be
switched only so the previously started guests can't be controlled.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: evdev

** Description changed:

  Hello,
  =

  Qemu up to version 3.1
  =

  it would be nice if passed through evdev can be switched (using lctrl +
- rctrl) through all running guests configured for evdev and the host.
- Currently, only the last started guest and host can be switched only so
- the previously started guests can't be controlled.
+ rctrl) through all running guests configured for evdev passthrough and
+ the host. Currently, only the last started guest and host can be
+ switched only so the previously started guests can't be controlled.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1815009

Title:
  Qemu evdev multiple guests/host switch

Status in QEMU:
  New

Bug description:
  Hello,

  Qemu up to version 3.1

  it would be nice if passed through evdev can be switched (using lctrl
  + rctrl) through all running guests configured for evdev passthrough
  and the host. Currently, only the last started guest and host can be
  switched only so the previously started guests can't be controlled.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1815009/+subscriptions
