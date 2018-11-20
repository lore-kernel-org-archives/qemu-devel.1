Received: from eggs.gnu.org ([2001:4830:134:3::10]:52874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gOuhC-0003RP-DS
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 20:19:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gOuh7-0004Lr-Nd
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 20:19:18 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:46674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gOuh7-0004Jt-8p
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 20:19:13 -0500
Date: Tue, 20 Nov 2018 02:19:10 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181120011910.zshx7oeujnrs2ob7@function>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-30-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114123643.24091-30-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 29/41] slirp: improve a bit the
 debug macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it

Marc-Andr=C3=A9 Lureau, le mer. 14 nov. 2018 16:36:31 +0400, a ecrit:
> Let them accept multiple arguments. Simplify the inner argument
> handling of DEBUG_ARGS/DEBUG_MISC_DEBUG_ERROR.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Applied to my tree, thanks!
