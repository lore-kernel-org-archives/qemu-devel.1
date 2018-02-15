Received: from eggs.gnu.org ([2001:4830:134:3::10]:41446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emKlc-0002L3-Lq
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:44:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emKlb-00065K-IH
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:44:08 -0500
References: <20180215042900.16078-1-f4bug@amsat.org>
	<20180215042900.16078-17-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e86b9596-56a5-a41e-452b-7923d3d74bcf@redhat.com>
Date: Thu, 15 Feb 2018 08:43:58 -0600
MIME-Version: 1.0
In-Reply-To: <20180215042900.16078-17-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 16/30] hw/sh4: use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>, Max Reitz <mreitz@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 02/14/2018 10:28 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> It ease code review, unit is explicit.

I noticed it here, then see it occurs throughout the series:
s/ease/eases/ in the commit message.

>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   hw/block/tc58128.c | 2 +-
>   hw/sh4/r2d.c       | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
