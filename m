Received: from eggs.gnu.org ([2001:4830:134:3::10]:60945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eWjuV-0004js-3m
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 09:20:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eWjuQ-0005Hi-5l
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 09:20:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:40742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eWjuP-0005H8-VS
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 09:20:46 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eWjuO-0007H6-Jg
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 14:20:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7AC7D2E80D4
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 14:20:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jan 2018 14:10:49 -0000
From: Mark <1683084@bugs.launchpad.net>
Reply-To: Bug 1683084 <1683084@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170415232401.17219.37576.malonedeb@gac.canonical.com>
Message-Id: <151498864968.23283.16059906328340257877.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1683084] Re: DNS server not working in QEMU
 usermode networking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

User error, this is not a bug

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1683084

Title:
  DNS server not working in QEMU usermode networking

Status in QEMU:
  Invalid

Bug description:
  Nslookup is returning "unknown host".
  I try to ping 10.0.2.3 and it fails. Pinging 10.0.2.2 and 10.0.2.15 works=
 correctly.
  Downloading files via wget using a static IP works well.

  Results of qemu monitor command "info network" included as an
  attachment.

  This bug was reported as a question on stack overflow:
  http://stackoverflow.com/questions/43308310/dns-server-not-working-in-
  qemu-usermode-networking.

  This bug exists on 2.8.0 and 2.9-rc4.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1683084/+subscriptions
