Received: from eggs.gnu.org ([2001:4830:134:3::10]:49530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRDd1-0002QV-Jy
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 04:56:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRDd1-0005m7-0F
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 04:56:31 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-20-philmd@redhat.com>
Date: Mon, 26 Nov 2018 10:56:26 +0100
In-Reply-To: <20181125205000.10324-20-philmd@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Sun,
	25 Nov 2018 21:49:54 +0100")
Message-ID: <87k1l0novp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1 19/25] MAINTAINERS: Add a missing
 entry to the QMP section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ac5d25491f..c73dde10a5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1887,6 +1887,7 @@ S: Supported
>  F: qmp.c
>  F: monitor.c
>  F: docs/devel/*qmp-*
> +F: docs/interop/*qmp-*
>  F: scripts/qmp/
>  F: tests/qmp-test.c
>  F: tests/qmp-cmd-test.c

Reviewed-by: Markus Armbruster <armbru@redhat.com>
