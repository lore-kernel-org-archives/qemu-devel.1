Received: from eggs.gnu.org ([2001:4830:134:3::10]:50928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben.hekster@foghorn.io>) id 1gZheS-00008x-EQ
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben.hekster@foghorn.io>) id 1gZheP-0003vh-5J
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:37:04 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:45873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben.hekster@foghorn.io>)
	id 1gZheL-0003rC-7e
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:36:58 -0500
Received: by mail-pf1-x42a.google.com with SMTP id g62so10265038pfd.12
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 11:36:56 -0800 (PST)
From: Ben Hekster <ben.hekster@foghorn.io>
Message-Id: <EC65CD28-C2F9-49D7-BDE1-9C3B5F68665E@foghorn.io>
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Date: Wed, 19 Dec 2018 11:36:51 -0800
In-Reply-To: <CAFEAcA9M73BdXs345vdqkuQE3sxT+GnS4PWZ2OPO8DWwNtRQ-A@mail.gmail.com>
References: <83206F6D-0BA5-4781-8635-84D48DD33A2A@foghorn.io>
	<CAFEAcA-PJadBG0sE43N9wEx9Qm3Nxu2am_0Zy2Zqtz66C9SJ-w@mail.gmail.com>
	<ECFBC025-CD7F-444B-BF7F-62E20954A85A@foghorn.io>
	<CAFEAcA9M73BdXs345vdqkuQE3sxT+GnS4PWZ2OPO8DWwNtRQ-A@mail.gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Booting Raspbian on RPi emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Checked out tag patchew/20181201123056.432-1-peter.maydell@linaro.org =
from https://github.com/patchew-project/qemu and verified the crash no =
longer occurs.  It does indeed appear that the crash previously happened =
right around the time where I can now see the window being resized.

I've attached a screenshot here for you; not sure if this will make it =
through to the mailing list...

Ben

> On Dec 19, 2018, at 10:43, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Wed, 19 Dec 2018 at 17:46, Ben Hekster <ben.hekster@foghorn.io> =
wrote:
>> probably a manifestation of =
https://bugs.launchpad.net/qemu/+bug/1802684
>=20
> Yep. If you could test the patchset at
> http://patchew.org/QEMU/20181201123056.432-1-peter.maydell@linaro.org/
> and confirm that it fixes the problem that would be great.
>=20
> thanks
> -- PMM
