Received: from eggs.gnu.org ([209.51.188.92]:40659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gsSVy-0007e5-C1
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 08:17:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gsSVx-0005zs-KU
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 08:17:50 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:59124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gsSVx-0005z7-DZ
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 08:17:49 -0500
Date: Sat, 9 Feb 2019 14:17:47 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190209131747.vy4sc34f6kbkvio2@function>
References: <20190208181226.24052-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190208181226.24052-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] RFC: net/slirp: link with libslirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Paolo Bonzini <pbonzini@redhat.com>

Marc-Andr=C3=A9 Lureau, le ven. 08 f=C3=A9vr. 2019 19:12:26 +0100, a ecri=
t:
> Once libslirp has received its first release, we can link with the
> external libslirp library.
>=20
> The migration data should be compatible with current and older qemu
> versions (same compatibility as today). See "slirp: add state
> saving/loading" patch. However, the content should be treated as a
> blob, as the format may change eventually in the future.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Thanks so much for all this work :)
