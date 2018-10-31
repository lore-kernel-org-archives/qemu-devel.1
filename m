Received: from eggs.gnu.org ([2001:4830:134:3::10]:60563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gHnGb-0007tC-Dy
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gHnGL-0007zd-46
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:58:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gHnGK-0007vg-St
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:58:09 -0400
Date: Wed, 31 Oct 2018 09:57:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181031095755.GD9625@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181031084309.9227-1-stefanha@redhat.com>
	<20181031084309.9227-4-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181031084309.9227-4-stefanha@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] MAINTAINERS: use 'https://' instead of
 'git://' for GitHub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Wed, Oct 31, 2018 at 08:43:08AM +0000, Stefan Hajnoczi wrote:
> When you clone the repository without previous commit history, 'git://'
> doesn't protect from man-in-the-middle attacks.  HTTPS is more secure
> since the client verifies the server certificate.
>=20
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  MAINTAINERS | 74 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 37 insertions(+), 37 deletions(-)

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
