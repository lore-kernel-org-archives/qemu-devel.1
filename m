Received: from eggs.gnu.org ([2001:4830:134:3::10]:59375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fRIjG-0005EU-Ig
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fRIjB-0003Mf-K0
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:51:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:33232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fRIjB-0003Ln-D8
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:50:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fRIj8-0001k7-Os
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 14:50:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CA7652E88E8
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 14:50:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Jun 2018 14:37:30 -0000
From: Eduardo Habkost <ehabkost@redhat.com>
Reply-To: Bug 1708462 <1708462@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150176961654.13001.1653024142886908093.malonedeb@soybean.canonical.com>
Message-Id: <152846865008.19483.14418099684745492025.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1708462] Re: Support Python 3 to build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The series mentioned in comment #3 was merged in v2.12.0, see commit
c21965a0c8b979c306e927f158257e5b0fa3a1f9.

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1708462

Title:
  Support Python 3 to build

Status in QEMU:
  Fix Released

Bug description:
  Currently qemu's configure requires Python 2 to build.  As Python 2 is
  rapidly approaching its EOL, it should be possible to build qemu with
  Python 3.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1708462/+subscriptions
