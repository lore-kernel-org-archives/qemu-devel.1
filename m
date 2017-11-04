Received: from eggs.gnu.org ([2001:4830:134:3::10]:33430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eB3v1-0000JU-4i
	for qemu-devel@nongnu.org; Sat, 04 Nov 2017 15:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eB3uy-0001S0-0C
	for qemu-devel@nongnu.org; Sat, 04 Nov 2017 15:15:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:58926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eB3ux-0001RK-Q3
	for qemu-devel@nongnu.org; Sat, 04 Nov 2017 15:15:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eB3uv-0006PH-Va
	for <qemu-devel@nongnu.org>; Sat, 04 Nov 2017 19:15:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EC0F72E80C3
	for <qemu-devel@nongnu.org>; Sat,  4 Nov 2017 19:15:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Nov 2017 19:03:01 -0000
From: Michal Rus <1730101@bugs.launchpad.net>
Reply-To: Bug 1730101 <1730101@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150982218219.20484.11681642745420352739.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1730101] [NEW] The guest is only starting after
 its SDL window gets focus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

I=E2=80=99m using i3wm and have workspace assigning rules that make QEMU=E2=
=80=99s SDL
window be assigned to a workspace I don=E2=80=99t really switch to.

When I run start a guest machine, its SDL window is moved to that
workspace (I never see it); but the machine freezes after displaying
that black window. It only starts booting after I switch to the
workspace and view the window.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1730101

Title:
  The guest is only starting after its SDL window gets focus

Status in QEMU:
  New

Bug description:
  I=E2=80=99m using i3wm and have workspace assigning rules that make QEMU=
=E2=80=99s SDL
  window be assigned to a workspace I don=E2=80=99t really switch to.

  When I run start a guest machine, its SDL window is moved to that
  workspace (I never see it); but the machine freezes after displaying
  that black window. It only starts booting after I switch to the
  workspace and view the window.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1730101/+subscriptions
