Received: from eggs.gnu.org ([2001:4830:134:3::10]:34715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cJTS1-0000HT-Oh
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:04:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cJTRw-00052I-Kd
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:04:05 -0500
Received: from hera.aquilenet.fr ([141.255.128.1]:59442)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cJTRw-00051f-EB
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:04:00 -0500
Date: Wed, 21 Dec 2016 00:03:57 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20161220230357.GQ3258@var.home>
References: <1479757549-18672-1-git-send-email-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1479757549-18672-1-git-send-email-hpoussin@reactos.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: support dynamic block size for TFTP
 transfers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, hpa@zytor.com, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

Herv=E9 Poussineau, on Mon 21 Nov 2016 20:45:49 +0100, wrote:
> The blocksize option is defined in RFC 1783.
> We now support block sizes between 1 and 1432 bytes, instead of 512 onl=
y.
>=20
> Signed-off-by: Herv=E9 Poussineau <hpoussin@reactos.org>

I fixed a couple of trivial things and commited to my tree, thanks!

Samuel
