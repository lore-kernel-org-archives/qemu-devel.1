Received: from eggs.gnu.org ([2001:4830:134:3::10]:42541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDSut-0004Zi-F1
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDSus-00070u-By
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:26:07 -0400
Date: Fri, 19 Oct 2018 12:25:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181019112554.GA19770@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180321153124.5357-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180321153124.5357-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] block: drop moderated sheepdog mailing
 list from MAINTAINERS file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, Jeff Cody <jcody@redhat.com>

Paolo, I think this is a patch for your misc patches queue.

On Wed, Mar 21, 2018 at 03:31:24PM +0000, Daniel P. Berrang=C3=A9 wrote:
> The sheepdog mailing list is setup to stop and queue messages from
> non-subscribers, pending moderator approval. Unfortunately it seems
> that the moderation queue is not actively dealt with. Even when message=
s
> are approved, the sender is never added to the whitelist, so every
> future mail the same sender continues to get stopped for moderation.
>=20
> MAINTAINERS entries should be responsive and not uneccessarily block
> mails from QEMU contributors, so drop the sheepdog mailing list.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 354a18ce49..7eea869dcd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1871,7 +1871,6 @@ M: Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>
>  M: Liu Yuan <namei.unix@gmail.com>
>  M: Jeff Cody <jcody@redhat.com>
>  L: qemu-block@nongnu.org
> -L: sheepdog@lists.wpkg.org
>  S: Supported
>  F: block/sheepdog.c
>  T: git git://github.com/codyprime/qemu-kvm-jtc.git block
> --=20
> 2.14.3
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
