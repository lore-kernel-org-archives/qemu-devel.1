Received: from eggs.gnu.org ([209.51.188.92]:58001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hC1Ma-0003g5-Tz
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 08:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hC1MZ-0003nt-3b
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 08:21:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:46210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hC1MV-0003Qt-6H
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 08:20:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hC1MD-0006ig-EB
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 12:20:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 683ED2E805D
	for <qemu-devel@nongnu.org>; Thu,  4 Apr 2019 12:20:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Apr 2019 12:07:48 -0000
From: Robert Uomini <1823169@bugs.launchpad.net>
Reply-To: Bug 1823169 <1823169@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155437966834.20937.13725906067731199360.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1823169] [NEW] qemu displays message "Setup
 failed, please check external storage is available and has enough room."
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

I tried to launch the Android app PokerStarsFR, and after it began
initialization, the launch failed with the above error. I'm running qemu
on a Dell XPS 13 (9370) laptop running Ubuntu 16.04 LTS. The standard
apps launch OK, but this one does not. I had downloaded it from the
PokerStars site https://www.pokerstars.fr/en/poker/download/android/.

I am running qemu version 2.5.0

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1823169

Title:
  qemu displays message "Setup failed, please check external storage is
  available and has enough room."

Status in QEMU:
  New

Bug description:
  I tried to launch the Android app PokerStarsFR, and after it began
  initialization, the launch failed with the above error. I'm running
  qemu on a Dell XPS 13 (9370) laptop running Ubuntu 16.04 LTS. The
  standard apps launch OK, but this one does not. I had downloaded it
  from the PokerStars site
  https://www.pokerstars.fr/en/poker/download/android/.

  I am running qemu version 2.5.0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1823169/+subscriptions
