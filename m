Received: from eggs.gnu.org ([2001:4830:134:3::10]:59383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVJZv-0007zN-Gv
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:06:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVJZp-0007Fv-6v
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:06:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gVJZo-0007B7-Ue
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:06:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4163B30642AD
	for <qemu-devel@nongnu.org>; Fri,  7 Dec 2018 17:06:05 +0000 (UTC)
References: <20181207165250.17043-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a6e63d34-a8f3-90d6-5d0c-84df345ac09f@redhat.com>
Date: Fri, 7 Dec 2018 11:06:03 -0600
MIME-Version: 1.0
In-Reply-To: <20181207165250.17043-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add a .mailmap file for preferred
 name spellings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On 12/7/18 10:52 AM, Daniel P. Berrang=C3=A9 wrote:
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   .mailmap | 3 +++
>   1 file changed, 3 insertions(+)
>   create mode 100644 .mailmap
>=20
> diff --git a/.mailmap b/.mailmap
> new file mode 100644
> index 0000000..fa8ab68
> --- /dev/null
> +++ b/.mailmap
> @@ -0,0 +1,3 @@
> +# Preferred name forms where people have changed their
> +# git author config, or having utf8/latin1 encoding issues.

Tenses don't line up - but that's copied from qemu.git/.mailmap so we=20
should fix it there too.  I suggest s/having/had/

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
