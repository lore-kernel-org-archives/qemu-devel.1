Received: from eggs.gnu.org ([2001:4830:134:3::10]:34880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cnlDT-0008IS-Jl
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cnlDQ-0007Vq-Fh
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:06:15 -0400
Received: from indium.canonical.com ([91.189.90.7]:47019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cnlDQ-0007VF-9I
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:06:12 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cnlDN-0002BI-Kh
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 12:06:09 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9A5DC2E807D
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 12:06:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Mar 2017 11:51:00 -0000
From: Kirill Tkhai <tkhai@yandex.ru>
Reply-To: Bug 1131757 <1131757@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130222143343.3624.57532.malonedeb@soybean.canonical.com>
Message-Id: <1149481353.20170314145100@yandex.ru>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1131757] pleasant news
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hey!

I've just read the latest news and I was pleasantly surprised, please
read it here http://ideal.fatitalianchef.com/5657


Yours truly, tkhai

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1131757

Title:
  QEMU 1.4.0 fails to boot sparc64 linux image

Status in QEMU:
  Incomplete

Bug description:
  Hi!

  I tried to boot sparc64 linux image
  (http://packages.debian.org/sid/sparc64/linux-
  image-2.6-sparc64-smp/download) with qemu and received the  error.

  host:~$qemu-system-sparc64 -nographic -kernel vmlinuz-3.2.0-4-sparc64-smp
  OpenBIOS for Sparc64
  Configuration device id QEMU version tion device id QEMUkernel addr n dev=
ice id QEMUkernel cmdline =

  CPUs:  cmdline =

   x SUNW,UltraSPARC-IIi
  UUID: 00UltraSPARC-IIi
  Welcome to OpenBIOS v1.0 built on Aug 19 2012 13:06
    Type 'help' for detailed information
  [sparc64] Kernel already loaded
  Unhandled Exception 0x0000000000000020
  PC =3D 0x0000000000404000 NPC =3D 0x0000000000404004
  Stopping execution

  Also, I tried to follow instruction from Artyom Tarasenko blog
  (http://tyom.blogspot.ru/2012/05/booting-linuxsparc64-on-todays-
  openbios.html), but it's still impossible to boot linux.

  Regards,
  Kirill

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1131757/+subscriptions
