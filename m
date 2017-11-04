Received: from eggs.gnu.org ([2001:4830:134:3::10]:60279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eB3lR-0006r5-AI
	for qemu-devel@nongnu.org; Sat, 04 Nov 2017 15:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eB3lO-0004NE-5p
	for qemu-devel@nongnu.org; Sat, 04 Nov 2017 15:05:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:58542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eB3lN-0004LS-W3
	for qemu-devel@nongnu.org; Sat, 04 Nov 2017 15:05:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eB3lK-0004Ue-O3
	for <qemu-devel@nongnu.org>; Sat, 04 Nov 2017 19:05:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B04DC2E8033
	for <qemu-devel@nongnu.org>; Sat,  4 Nov 2017 19:05:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Nov 2017 18:58:06 -0000
From: Michal Rus <1730099@bugs.launchpad.net>
Reply-To: Bug 1730099 <1730099@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150982188718.19907.10916894947386280270.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1730099] [NEW] Sometimes,
 when not touching the SDL window, the guest freezes
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

I often just run some development guest machine, and leave its SDL
window on a workspace I don=E2=80=99t touch, and only interact with it via =
TCP.

And sometimes, the guest just freezes.

After it gets the focus back, it comes back to life (starts responding
via network).

QEMU release version: 2.8.1.1

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1730099

Title:
  Sometimes, when not touching the SDL window, the guest freezes

Status in QEMU:
  New

Bug description:
  I often just run some development guest machine, and leave its SDL
  window on a workspace I don=E2=80=99t touch, and only interact with it via
  TCP.

  And sometimes, the guest just freezes.

  After it gets the focus back, it comes back to life (starts responding
  via network).

  QEMU release version: 2.8.1.1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1730099/+subscriptions
