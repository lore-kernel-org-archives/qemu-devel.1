Received: from eggs.gnu.org ([209.51.188.92]:52082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hCHyu-0002tz-46
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hCHys-0004Cj-Sn
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:05:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:37464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hCHys-0004AQ-Kw
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:05:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hCHyq-0002iA-TF
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 06:05:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D724C2E8078
	for <qemu-devel@nongnu.org>; Fri,  5 Apr 2019 06:05:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Apr 2019 05:59:09 -0000
From: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF?= <1823169@bugs.launchpad.net>
Reply-To: Bug 1823169 <1823169@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155437966834.20937.13725906067731199360.malonedeb@chaenomeles.canonical.com>
Message-Id: <155444394987.21192.3332237882695030786.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1823169] Re: qemu displays message "Setup failed,
 please check external storage is available and has enough room."
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I agree to Thomas, and in that case referring to your comment #2 - qemu ver=
sions in Ubuntu are associated with the base Ubuntu version - so Ubuntu 16.=
04 will stick to qemu 2.5 + fixes.
Ubuntu 19.10 released next week has qemu 3.1 btw, see [1]

And vice versa for an upstream report (which is often helpful for deep
technical discussions) you'll want to try with the latest version anyway
- which for just a few days is 3.1 still, then it will be 4.0 :-)

[1]: https://launchpad.net/ubuntu/+source/qemu
[2]: https://wiki.qemu.org/Planning/4.0

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1823169

Title:
  qemu displays message "Setup failed, please check external storage is
  available and has enough room."

Status in QEMU:
  Invalid

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
