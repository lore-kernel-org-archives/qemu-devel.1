Received: from eggs.gnu.org ([2001:4830:134:3::10]:53799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMvWM-0007TZ-9w
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:47:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMvWJ-000130-37
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:47:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:17542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gMvWF-0000pE-6j
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:47:50 -0500
Date: Wed, 14 Nov 2018 13:47:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181114134732.GR19298@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-14-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114123643.24091-14-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 13/41] slirp: remove
 HAVE_SYS_SIGNAL_H
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it

On Wed, Nov 14, 2018 at 04:36:15PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  slirp/slirp.h        | 3 ---
>  slirp/slirp_config.h | 3 ---
>  2 files changed, 6 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
