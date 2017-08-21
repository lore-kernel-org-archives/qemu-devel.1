Received: from eggs.gnu.org ([2001:4830:134:3::10]:34825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1djepg-0007lr-9q
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 01:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1djepd-0007uk-9b
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 01:01:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:34584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1djepd-0007uU-3e
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 01:00:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1djepb-0004gF-S6
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 05:00:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9E4E52E80CB
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 05:00:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Aug 2017 04:54:44 -0000
From: Thomas Huth <1711828@bugs.launchpad.net>
Reply-To: Bug 1711828 <1711828@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150314599227.11619.13522742205316684478.malonedeb@wampee.canonical.com>
Message-Id: <150329128414.8072.13458130413478779268.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1711828] Re: lock mov non generated #UD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Could you please add a proper description to this bug? Please also try
first whether your problem also occurs with the latest released version
of QEMU (version 2.9 or the 2.10 release candidate), to see whether it
has been fixed there already.

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1711828

Title:
  lock mov non generated #UD

Status in QEMU:
  Incomplete

Bug description:
  qemu 2.8.1 debian 9.1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1711828/+subscriptions
