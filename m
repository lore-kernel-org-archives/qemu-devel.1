Received: from eggs.gnu.org ([2001:4830:134:3::10]:59134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fdHEo-0005iY-Fj
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fdHEj-000807-Ko
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:41:06 -0400
Received: from indium.canonical.com ([91.189.90.7]:51142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fdHEj-0007zv-EI
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:41:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fdHEi-0005lQ-4c
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 15:41:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 125322E80C9
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 15:41:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jul 2018 15:25:58 -0000
From: Dmitriy <fsmoke@mail.ru>
Reply-To: Bug 1781211 <1781211@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153131507336.32554.286859961070270937.malonedeb@wampee.canonical.com>
Message-Id: <153132275884.24134.6391832031332522655.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1781211] Re: HAXM acceleration does not work at
 all.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

After some time I decided it is haxm bug - so i created the same issue
on haxm project too

https://github.com/intel/haxm/issues/74

** Bug watch added: github.com/intel/haxm/issues #74
   https://github.com/intel/haxm/issues/74

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1781211

Title:
  HAXM acceleration does not work at all.

Status in QEMU:
  New

Bug description:
  I have qemu windows build 2.12.90, haxm 7.2.0. Ubuntu, nor arch linux doe=
s not works when i turn on hax acceleration. Permanent kernel panics, black=
 screen freezing and other crashes happens when i run qemu.
  Qemu crashed with hax - when i ran it from iso. It crashed on already ins=
talled system - it's not matters. =


  Versions:
  archlinux-2018.07.01-x86_64
  ubuntu-18.04-live-server-amd64.iso

  I run qemu-system-x86_64.exe binary.

  My CPU:
  core i7 2600k

  See screenshot

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1781211/+subscriptions
