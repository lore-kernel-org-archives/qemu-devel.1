Received: from eggs.gnu.org ([2001:4830:134:3::10]:41891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gWPAQ-0006Jt-1M
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:16:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gWPAM-0002id-P0
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:16:25 -0500
Date: Mon, 10 Dec 2018 17:16:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181210171617.GR20272@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181207170733.129532-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181207170733.129532-1-eblake@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] maint: Grammar fix to mailmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Fri, Dec 07, 2018 at 11:07:33AM -0600, Eric Blake wrote:
> Make the sentence read better.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  .mailmap | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


>=20
> diff --git a/.mailmap b/.mailmap
> index ed8faa57192..b8e08297c90 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -34,6 +34,6 @@ Justin Terry (VM) <juterry@microsoft.com> Justin Terr=
y (VM) via Qemu-devel <qemu
>=20
>=20
>  # Also list preferred name forms where people have changed their
> -# git author config, or having utf8/latin1 encoding issues.
> +# git author config, or had utf8/latin1 encoding issues.
>  Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>  Reimar D=C3=B6ffinger <Reimar.Doeffinger@gmx.de>
> --=20
> 2.17.2
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
