Received: from eggs.gnu.org ([2001:4830:134:3::10]:43829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dq4Ij-0006Pb-GE
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 17:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dq4Ie-0002sZ-Q7
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 17:25:29 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:36535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dq4Ie-0002rn-L1
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 17:25:24 -0400
Received: by mail-oi0-x241.google.com with SMTP id g15so597725oib.3
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 14:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <1504815384-8490-1-git-send-email-stefanb@linux.vnet.ibm.com>
In-Reply-To: <1504815384-8490-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 07 Sep 2017 21:25:10 +0000
Message-ID: <CAJ+F1CL6K6XTTf4AXdY8LAYUD+DEjTT5EUR2JrvQFQmAk6utzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] Add myself as maintainer for TPM code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, f4bug@amsat.org

On Thu, Sep 7, 2017 at 10:21 PM Stefan Berger <stefanb@linux.vnet.ibm.com>
wrote:

> Also add backends/tpm.c to the list of files.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>


Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

thanks


---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index caf7e8a..c434a09 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1487,12 +1487,14 @@ F: docs/tracing.txt
>  T: git git://github.com/stefanha/qemu.git tracing
>
>  TPM
> -S: Orphan
> +M: Stefan Berger <stefanb@linux.vnet.ibm.com>
> +S: Maintained
>  F: tpm.c
>  F: hw/tpm/*
>  F: include/hw/acpi/tpm.h
>  F: include/sysemu/tpm*
>  F: qapi/tpm.json
> +F: backends/tpm.c
>
>  Checkpatch
>  S: Odd Fixes
> --
> 2.5.5
>
>
> --
Marc-Andr=C3=A9 Lureau
