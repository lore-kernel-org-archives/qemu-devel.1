Received: from eggs.gnu.org ([209.51.188.92]:42659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gz2KO-0002mM-IO
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 11:45:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gz2KN-0000M4-MC
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 11:45:04 -0500
References: <20190227162035.18543-1-berrange@redhat.com>
	<20190227162035.18543-4-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <508b6cfc-8d19-9410-f0f1-91ab826bb226@redhat.com>
Date: Wed, 27 Feb 2019 10:44:38 -0600
MIME-Version: 1.0
In-Reply-To: <20190227162035.18543-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 3/3] nbd: fix outdated qapi docs syntax
 for tls-creds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 2/27/19 10:20 AM, Daniel P. Berrang=C3=A9 wrote:
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qapi/block.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/qapi/block.json b/qapi/block.json
> index 79623088e7..145c268bb6 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -224,7 +224,7 @@
>  # QEMU instance could refer to them as "nbd:HOST:PORT:exportname=3DNAM=
E".
>  #
>  # @addr: Address on which to listen.
> -# @tls-creds: (optional) ID of the TLS credentials object. Since 2.6
> +# @tls-creds: ID of the TLS credentials object (since 2.6).

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
