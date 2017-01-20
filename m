Received: from eggs.gnu.org ([2001:4830:134:3::10]:43247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUdtV-0006Dh-QQ
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUdtR-00035p-Sa
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:26:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:48260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUdtR-00035K-NM
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:26:33 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUdtQ-0006St-Fq
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 18:26:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 58E132E80C2
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 18:26:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Jan 2017 18:14:58 -0000
From: Thomas Huth <903365@bugs.launchpad.net>
Reply-To: Bug 903365 <903365@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111212200001.27381.35693.malonedeb@gac.canonical.com>
Message-Id: <20170120181501.21508.24600.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 903365] Re: [feature request] bind nat (-net
 user) to other interface (like eth0:2)
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
https://bugs.launchpad.net/bugs/903365

Title:
  [feature request] bind nat (-net user) to other interface (like
  eth0:2)

Status in QEMU:
  New

Bug description:
  -net user mode is very nice because it does not require any changes in
  host system. However if host system has muplitple IPs You cant use it,
  or even switch to another. Qemu should be able to "bind" to eth0:1
  eth0:2 so that outgoing traffic uses this interface and thus other IP.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/903365/+subscriptions
