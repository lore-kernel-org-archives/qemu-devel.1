Received: from eggs.gnu.org ([2001:4830:134:3::10]:59615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dX71h-0004BN-IZ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:29:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dX71g-0001Ma-Lx
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:29:33 -0400
Date: Mon, 17 Jul 2017 16:29:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170717142922.GI5301@noname.redhat.com>
References: <20170715132841.9865-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170715132841.9865-1-hpoussin@reactos.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] vvfat: some fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 15.07.2017 um 15:28 hat Herv=E9 Poussineau geschrieben:
> Hi,
>=20
> This patchset is a follow-up for patch series sent here:
> http://lists.gnu.org/archive/html/qemu-devel/2017-05/msg05017.html
>=20
> Patches 1 and 2 define and use some constants to make the code more cle=
ar.
> Patch 3 make read-write mode work when using non-ASCII filenames.
> Patch 4 fixes the last problem reported by MS Scandisk.
>=20
> Herv=E9

Thanks, applied to the block branch.

Kevin
