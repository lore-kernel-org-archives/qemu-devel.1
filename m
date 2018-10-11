Received: from eggs.gnu.org ([2001:4830:134:3::10]:34940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gAPM7-00007B-KE
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 21:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gAPM3-00068u-VU
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 21:01:35 -0400
References: <20181010222944.29304-1-f4bug@amsat.org>
	<20181010222944.29304-3-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ffec53e7-9471-bb6f-d438-11a531e748dc@redhat.com>
Date: Wed, 10 Oct 2018 20:01:27 -0500
MIME-Version: 1.0
In-Reply-To: <20181010222944.29304-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] mailmap: Split 'prefered emails' from
 'original git import' section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 10/10/18 5:29 PM, Philippe Mathieu-Daud=C3=A9 wrote:

In the subject: s/prefered/preferred/

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   .mailmap | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
>=20

> +
> +# This section is to track prefered (or last up to date) email for peo=
ple

and again

> +# that uses (or had use) various emails.

that use (or have used)

> +# Example can be people changing from companies, or companies changing=
 their
> +# name.

Examples include people changing companies, or companies changing their=20
name.

> +Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@imgt=
ec.com>
> +Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.i=
bm.com>
> +James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
> +Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
> +Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
> +Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
> +
> +
>   # Next, translate a few commits where mailman rewrote the From: line =
due
>   # to strict SPF, although we prefer to avoid adding more entries like=
 that.
>   Ed Swierk <eswierk@skyportsystems.com> Ed Swierk via Qemu-devel <qemu=
-devel@nongnu.org>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
