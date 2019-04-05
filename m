Received: from eggs.gnu.org ([209.51.188.92]:42603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hCJhp-0005ne-MI
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hCJho-0005yb-EK
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:56:09 -0400
Received: from indium.canonical.com ([91.189.90.7]:52416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hCJho-0005vB-6g
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:56:08 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hCJhk-0003O1-SX
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 07:56:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 01A0E2E8181
	for <qemu-devel@nongnu.org>; Fri,  5 Apr 2019 07:56:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Apr 2019 07:44:30 -0000
From: Robert Uomini <1823169@bugs.launchpad.net>
Reply-To: Bug 1823169 <1823169@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155437966834.20937.13725906067731199360.malonedeb@chaenomeles.canonical.com>
	<155444394987.21192.3332237882695030786.malone@soybean.canonical.com>
Message-Id: <CAB6aw5F4t7d2fqJCcXWAuAXBKmZFPa2vpeF906OZViFSn7KrzA@mail.gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1823169] Re: qemu displays message "Setup
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

On Fri, Apr 5, 2019 at 8:05 AM Christian Ehrhardt =EE=83=BF <
1823169@bugs.launchpad.net> wrote:

> I agree to Thomas, and in that case referring to your comment #2 - qemu
> versions in Ubuntu are associated with the base Ubuntu version - so Ubuntu
> 16.04 will stick to qemu 2.5 + fixes.
> Ubuntu 19.10 released next week has qemu 3.1 btw, see [1]
>
Awesome!

>
> And vice versa for an upstream report (which is often helpful for deep
> technical discussions) you'll want to try with the latest version anyway
> - which for just a few days is 3.1 still, then it will be 4.0 :-)
>
Even better!

>
> [1]: https://launchpad.net/ubuntu/+source/qemu
> [2]: https://wiki.qemu.org/Planning/4.0
>
> --
> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1823169
>
> Title:
>   qemu displays message "Setup failed, please check external storage is
>   available and has enough room."
>
> Status in QEMU:
>   Invalid
>
> Bug description:
>   I tried to launch the Android app PokerStarsFR, and after it began
>   initialization, the launch failed with the above error. I'm running
>   qemu on a Dell XPS 13 (9370) laptop running Ubuntu 16.04 LTS. The
>   standard apps launch OK, but this one does not. I had downloaded it
>   from the PokerStars site
>   https://www.pokerstars.fr/en/poker/download/android/.
>
>   I am running qemu version 2.5.0
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1823169/+subscriptions
>

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
