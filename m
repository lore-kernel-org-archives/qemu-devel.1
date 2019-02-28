Received: from eggs.gnu.org ([209.51.188.92]:52289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzQck-0000rL-L8
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:41:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzQcj-0006ae-H7
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:41:38 -0500
References: <20190227162035.18543-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f84fc50a-110b-e2bf-0061-6ff17a98dbe6@redhat.com>
Date: Thu, 28 Feb 2019 12:41:29 -0600
MIME-Version: 1.0
In-Reply-To: <20190227162035.18543-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 0/3] nbd: support for authorization
 control on TLS connections
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
> This series provides the NBD parts of the authorization control series
> previously posted as:
>=20
>   v1: https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg04482.ht=
ml
>   v2: https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg05727.ht=
ml
>   v3: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01639.ht=
ml
>   v4: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg04319.ht=
ml
>=20
> Then separated for merge:
>=20
>   v5: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg07347.ht=
ml
>=20
> The core authz framework is now merged & these patches have all had
> positive review. Thus these NBD parts are ready to go into the NBD
> maintainer's tree, should the maintainer consider them acceptable.

Thanks; series is queued for my next pull request.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
