Received: from eggs.gnu.org ([2001:4830:134:3::10]:57508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fb6sX-00081h-6N
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fb6sS-0007CP-Qv
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:13:09 -0400
References: <20180705155811.20366-1-f4bug@amsat.org>
	<20180705155811.20366-5-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <af8abd7f-d72d-0445-298c-4ff91fccdb5e@redhat.com>
Date: Thu, 5 Jul 2018 11:13:01 -0500
MIME-Version: 1.0
In-Reply-To: <20180705155811.20366-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/7] tests/bios-tables-test: Remove an
 useless cast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

On 07/05/2018 10:58 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Patch created mechanically by rerunning:

In the subject: s/an useless/a useless/

(English is weird; we use "a" when the 'u' is pronounced hard as in=20
"unicorn", and "an" when the 'u' is soft as in "umbrella")

>=20
>    $  spatch --sp-file scripts/coccinelle/typecast.cocci \
>              --macro-file scripts/cocci-macro-file.h \
>              --dir . --in-place
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
