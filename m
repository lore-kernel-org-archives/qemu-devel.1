Received: from eggs.gnu.org ([2001:4830:134:3::10]:52650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7GOF-0008Dy-0N
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 03:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7GOB-0000WV-TF
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 03:46:15 -0400
Received: from indium.canonical.com ([91.189.90.7]:51266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e7GOB-0000WE-NC
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 03:46:11 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e7GO8-0007k2-RK
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 07:46:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CDF012E80CD
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 07:46:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Oct 2017 07:30:55 -0000
From: Thomas Huth <1726910@bugs.launchpad.net>
Reply-To: Bug 1726910 <1726910@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150885852349.17651.9958840122130941388.malonedeb@wampee.canonical.com>
Message-Id: <150891665662.18248.4894232843458450944.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1726910] Re: UI request: add a function key
 toolbar (f1-f12)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
   Importance: Undecided =3D> Wishlist

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1726910

Title:
  UI request: add a function key toolbar (f1-f12)

Status in QEMU:
  New

Bug description:
  I run old DOS programs under FreeDOS using QEMU.

  It's common when running/testing DOS applications to use the function
  keys. Some of these (such as F10) are intercepted by the window
  system. For example, some DOS program installers use F10 to install
  the software, but F10 is intecepted by the window system.

  The standard solution is to jump to the QEMU console and use sendkey
  to send a specific function key to the QEMU guest (often needed for
  'sendkey f10'). But this does not seem to be very user friendly for
  new users. Nor is it very fast if you need to this often.

  I propose QEMU add a toolbar with the function keys.

  I've attached a mockup of one possible design, with a simple toolbar
  for F1-F12. A possible modification would be to add "modifier" buttons
  for Ctrl and Shift and Alt to make it easier for users to enter
  combinations like Ctrl-F12 or Alt-F10 or Shift-F1.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1726910/+subscriptions
