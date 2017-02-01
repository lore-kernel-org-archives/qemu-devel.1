Received: from eggs.gnu.org ([2001:4830:134:3::10]:43235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cYrKV-0008Jc-1W
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:35:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cYrKR-0003W4-55
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:35:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:49428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cYrKQ-0003Uy-VZ
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:35:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cYrKO-0005V0-Iz
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 09:35:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8DD0D2E80C3
	for <qemu-devel@nongnu.org>; Wed,  1 Feb 2017 09:35:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Feb 2017 09:18:25 -0000
From: Thomas Huth <1252010@bugs.launchpad.net>
Reply-To: Bug 1252010 <1252010@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131117135926.19947.91012.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170201091825.9014.2843.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1252010] Re: can't assign enough RAM to the VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Could we close this bug now - I think most people are using 64-bit host
systems nowadays?

** Changed in: qemu
       Status: Confirmed =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1252010

Title:
  can't assign enough RAM to the VM

Status in QEMU:
  Incomplete

Bug description:
  QEMU version: 1.6.90.0 from 2013 11 16
  Host OS: Windows XP SP3 x86
  Host machine: 3.2 GHz AMD Athlon 64 dual core processor, 4 GB DDR II (3.2=
 seen by the OS) memory
  Guest OS: Grub4Dos boot manager menu
  Problem: you can't assign more than 880 MB memory to the VM, although wit=
h 0.15.1.0 version you can assign up to 1179 MB.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1252010/+subscriptions
