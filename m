Received: from eggs.gnu.org ([2001:4830:134:3::10]:46650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTU3G-0004uo-P4
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTU3C-0002Wr-P8
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:20:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:48834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fTU3C-0002WN-IR
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:20:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fTU3B-0000Jd-BN
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 15:20:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5417F2E8078
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 15:20:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Jun 2018 15:06:37 -0000
From: Waldemar Kozaczuk <1776920@bugs.launchpad.net>
Reply-To: Bug 1776920 <1776920@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152898515528.25954.5483198787570860596.malonedeb@soybean.canonical.com>
	<152898759936.1737.7382311952798444038.malone@chaenomeles.canonical.com>
Message-Id: <CAL9cFfOWGHoiPp-yAnmBGC2wCiEn_od94G7v287Me21cqj9JBw@mail.gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1776920] Re: qemu-img convert on Mac OSX
 creates corrupt images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I will provide all necessary info. Unfortunately the smallest image I can
provide is around 10M.

What is M1/M2/M3 L1/L2/L3 file?

Waldek

On Thu, Jun 14, 2018 at 10:46 AM, =EE=83=BF Christian Ehrhardt =EE=83=BF <
1776920@bugs.launchpad.net> wrote:

> Can this be done with like a 1M example file that you could copy off in
> all stages.
>
> Provide the commands you use like
> 1. create
> 2. do ??
> 3. convert
>
> Then for Mac and Linux you'd have M1/M2/M3 L1/L2/L3 files that can all
> be attached here to be evaluated for what might be broken.
>
> IMHO In the current state there is neither enough data for good
> debugging, not enough steps to reproduce what exactly you faced.
>
> --
> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1776920
>
> Title:
>   qemu-img convert on Mac OSX creates corrupt images
>
> Status in QEMU:
>   New
>
> Bug description:
>   An image created by qemu-img create, then modified by another program
>   is converted to bad/corrupt image when using convert sub command on
>   Mac OSX. The same convert works on Linux. The version of qemu-img is
>   2.12.
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1776920/+subscriptions
>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1776920

Title:
  qemu-img convert on Mac OSX creates corrupt images

Status in QEMU:
  New

Bug description:
  An image created by qemu-img create, then modified by another program
  is converted to bad/corrupt image when using convert sub command on
  Mac OSX. The same convert works on Linux. The version of qemu-img is
  2.12.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1776920/+subscriptions
