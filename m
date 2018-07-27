Received: from eggs.gnu.org ([2001:4830:134:3::10]:46262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4i5-0005Wg-Lu
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4i2-0007cd-It
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:31:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35558 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fj4i2-0007bj-Dm
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:31:14 -0400
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-8-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <25d65d93-2784-fe16-841c-8a13716644cb@redhat.com>
Date: Fri, 27 Jul 2018 10:31:12 -0500
MIME-Version: 1.0
In-Reply-To: <20180727151359.29061-8-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/23] libqtest: Simplify qmp_fd_vsend()
 a bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org

On 07/27/2018 10:13 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   tests/libqtest.c | 18 +++++++-----------
>   1 file changed, 7 insertions(+), 11 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
