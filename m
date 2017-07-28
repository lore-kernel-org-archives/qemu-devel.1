Received: from eggs.gnu.org ([2001:4830:134:3::10]:44574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dayhN-00017m-W4
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:24:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dayhK-0004I4-J5
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:24:33 -0400
Date: Fri, 28 Jul 2017 14:24:26 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170728062426.GQ5117@lemon.lan>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-47-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170728053610.15770-47-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 46/47] MAINTAINERS: add missing entries
 for Coccinelle scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com

On Fri, 07/28 02:36, Philippe Mathieu-Daud=E9 wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 224890643d..7854792765 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1537,6 +1537,12 @@ Checkpatch
>  S: Odd Fixes
>  F: scripts/checkpatch.pl
> =20
> +Coccinelle scripts
> +R: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> +S: Orphan

"Orphan" sounds like we don't care much anymore but I suppose this is not=
 the
case. But I don't have any better idea either.

Fam

> +F: scripts/cocci-macro-file.h
> +F: scripts/coccinelle/
> +
>  Migration
>  M: Juan Quintela <quintela@redhat.com>
>  M: Dr. David Alan Gilbert <dgilbert@redhat.com>
> @@ -1970,4 +1976,3 @@ Build system architecture
>  M: Daniel P. Berrange <berrange@redhat.com>
>  S: Odd Fixes
>  F: docs/devel/build-system.txt
