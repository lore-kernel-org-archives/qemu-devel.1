Received: from eggs.gnu.org ([2001:4830:134:3::10]:41642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cYHi9-00035L-Ta
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 14:34:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cYHi3-00028K-W9
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 14:33:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cYHi3-00028D-Q1
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 14:33:51 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F0E2F8EB35
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 19:33:51 +0000 (UTC)
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
	<20170130133954.31353-2-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9b5fd0c5-e432-ea68-92c0-fac44197227b@redhat.com>
Date: Mon, 30 Jan 2017 14:33:50 -0500
MIME-Version: 1.0
In-Reply-To: <20170130133954.31353-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/41] MAINTAINERS: add myself to
 qemu-char.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org



On 30/01/2017 08:39, Marc-Andr=C3=A9 Lureau wrote:
> I consider to have enough experience with qemu-char to propose myself a=
s
> maintainer. This will allow me to send pull request without waiting for
> Paolo.

With pleasure. :)

Paolo

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e0be7bc0d4..5efd8cc671 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1194,6 +1194,7 @@ T: git git://github.com/jnsnow/qemu.git bitmaps
> =20
>  Character device backends
>  M: Paolo Bonzini <pbonzini@redhat.com>
> +M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>  S: Maintained
>  F: qemu-char.c
>  F: backends/msmouse.c
>=20
