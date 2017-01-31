Received: from eggs.gnu.org ([2001:4830:134:3::10]:58018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cYPhT-00087X-Rz
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 23:05:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cYPhQ-0005wt-Ox
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 23:05:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:51503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cYPhQ-0005wf-JQ
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 23:05:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cYPhP-0002T6-GL
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 04:05:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 77F1E2E80C1
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 04:05:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 31 Jan 2017 03:58:30 -0000
From: Ziyue Yang <1656710@bugs.launchpad.net>
Reply-To: Bug 1656710 <1656710@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170115231359.21186.42325.malonedeb@gac.canonical.com>
Message-Id: <20170131035830.9153.40157.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1656710] Re: Please support Ctrl-Alt-= to zoom in
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
       Status: New =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1656710

Title:
  Please support Ctrl-Alt-=3D to zoom in

Status in QEMU:
  In Progress

Bug description:
  With the GTK3 interface, qemu-system supports pressing Ctrl-Alt-plus
  to zoom in and Ctrl-Alt-minus to zoom out.  However, unlike many
  programs that support similar zoom hotkeys, qemu-system actually
  requires using '+', making the hotkey Ctrl-Alt-Shift-=3D .  Most programs
  with similar zoom hotkeys allow Ctrl-Alt-=3D as a synonym.

  Please consider accepting Ctrl-Alt-=3D as an additional zoom-in hotkey.

  (Observed in QEMU 2.8)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1656710/+subscriptions
