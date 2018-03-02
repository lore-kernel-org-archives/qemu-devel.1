Received: from eggs.gnu.org ([2001:4830:134:3::10]:54787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1erf9R-0004Me-7u
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 02:30:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1erf9N-0007mE-A7
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 02:30:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:34302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1erf9N-0007kZ-3N
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 02:30:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1erf9L-0001Wi-E8
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 07:30:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 691CC2E80CB
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 07:30:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Mar 2018 07:23:01 -0000
From: yabi <1751422@bugs.launchpad.net>
Reply-To: Bug 1751422 <1751422@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151945759115.32735.10228929932246006018.malonedeb@chaenomeles.canonical.com>
	<151955167572.5890.18128556928250429154.malone@soybean.canonical.com>
Message-Id: <4f7bdec6.6a7e.161e597b923.Coremail.zzxy332@126.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1751422] Re: some instructions translate
 error in x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The patch is In this mail attachments, which is patch for version 2.11.1   =
target/i386/translate.c.
The patch is created by diff.
my English is so poor to explain how the error come, but you can see the pa=
tch result to get  it.





At 2018-02-25 17:41:15, "Thomas Huth" <1751422@bugs.launchpad.net> wrote:
>Could you please provide some more information about the problem? What's
>exactly the error? If you've already got a patch, please have a look at
>https://wiki.qemu.org/Contribute/SubmitAPatch to get some information
>how to submit it.
>
>** Changed in: qemu
>       Status: New =3D> Incomplete
>
>-- =

>You received this bug notification because you are subscribed to the bug
>report.
>https://bugs.launchpad.net/bugs/1751422
>
>Title:
>  some instructions translate error in x86
>
>Status in QEMU:
>  Incomplete
>
>Bug description:
>  There is some instructions translation error on target i386 in many vers=
ions, such as 2.11.1, 2.10.2, 2.7.1 and so on.
>  The error translation instructions include les, lds. I has got a patch, =
but I have no idea how to apply it.
>
>To manage notifications about this bug go to:
>https://bugs.launchpad.net/qemu/+bug/1751422/+subscriptions


** Attachment added: "translate.patch"
   https://bugs.launchpad.net/bugs/1751422/+attachment/5066685/+files/trans=
late.patch

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1751422

Title:
  some instructions translate error in x86

Status in QEMU:
  Incomplete

Bug description:
  There is some instructions translation error on target i386 in many versi=
ons, such as 2.11.1, 2.10.2, 2.7.1 and so on.
  The error translation instructions include les, lds. I has got a patch, b=
ut I have no idea how to apply it.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1751422/+subscriptions
