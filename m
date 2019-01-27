Received: from eggs.gnu.org ([209.51.188.92]:49074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gniyt-0002p3-Lh
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 06:52:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gniuU-0004f2-Kx
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 06:47:35 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:42946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gniuP-0004D7-9O
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 06:47:32 -0500
Date: Sun, 27 Jan 2019 12:47:20 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190127114720.aqnvvbp7lvjxu46g@function>
References: <20190127015113.1599-1-samuel.thibault@ens-lyon.org>
	<20190127015509.ngofhbiduuwwbf7r@function>
	<CAJ+F1CKYNEVXNbmN2ppvPOtN_2nMyzTX612aZ9twnYc0+Rgg_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKYNEVXNbmN2ppvPOtN_2nMyzTX612aZ9twnYc0+Rgg_Q@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: Replace QEMU_BUILD_BUG_ON with own
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

Marc-Andr=C3=A9 Lureau, le dim. 27 janv. 2019 15:37:38 +0400, a ecrit:
> On Sun, Jan 27, 2019 at 5:55 AM Samuel Thibault <samuel.thibault@gnu.or=
g> wrote:
> >
> > (Which I'll fold as appropriate within Marc-Andr=C3=A9's patch series=
)
>=20
> Did you try using G_STATIC_ASSERT* instead?

Ah, right, that can be used instead, sent refined patch.

Samuel
