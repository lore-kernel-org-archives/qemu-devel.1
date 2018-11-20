Received: from eggs.gnu.org ([2001:4830:134:3::10]:47941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gOuRp-0001bd-UJ
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 20:03:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gOuRm-0000Bn-QH
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 20:03:25 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:46322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gOuRm-00008o-JL
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 20:03:22 -0500
Date: Tue, 20 Nov 2018 02:03:20 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181120010320.jrkq4ttaaersytuu@function>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-21-marcandre.lureau@redhat.com>
	<20181114135129.GY19298@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114135129.GY19298@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 20/41] slirp: remove
 HAVE_SYS_IOCTL_H
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it

Daniel P. Berrang=C3=A9, le mer. 14 nov. 2018 13:51:29 +0000, a ecrit:
> On Wed, Nov 14, 2018 at 04:36:22PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  slirp/slirp.h        | 2 +-
> >  slirp/slirp_config.h | 6 ------
> >  2 files changed, 1 insertion(+), 7 deletions(-)
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Applied to my tree, thanks!
