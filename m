Received: from eggs.gnu.org ([2001:4830:134:3::10]:55820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fezyy-0007dO-UP
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:39:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fezyv-0002yG-QE
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:39:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55010 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fezyv-0002xf-Jx
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:39:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C203A402333A
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 09:39:48 +0000 (UTC)
Date: Mon, 16 Jul 2018 10:39:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180716093944.GL5616@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180716073226.21127-1-armbru@redhat.com>
	<20180716073226.21127-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180716073226.21127-3-armbru@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] MAINTAINERS: New section "Incompatible
 changes", copy libvir-list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, thuth@redhat.com, cohuck@redhat.com, pkrempa@redhat.com

On Mon, Jul 16, 2018 at 09:32:26AM +0200, Markus Armbruster wrote:
> Libvirt developers would like to be copied on patches to qemu-doc
> appendix "Deprecated features".  Do them the favor.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 20eef3cb61..666e936812 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2194,6 +2194,10 @@ M: Daniel P. Berrange <berrange@redhat.com>
>  S: Odd Fixes
>  F: docs/devel/build-system.txt
> =20
> +Incompatible changes
> +R: libvir-list@redhat.com
> +F: qemu-deprecated.texi
> +
>  Build System
>  ------------
>  GIT submodules

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Note, that libvir-list requires senders to be subscribed before mails are
delivered, otherwise they go into moderation queue. My normal approach. a=
s
the person moderating, is to whitelist all human senders who get moderate=
d,
so it is only a one-time pain point per person.

Thankyou spammers :-(

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
