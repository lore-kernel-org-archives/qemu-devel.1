Received: from eggs.gnu.org ([2001:4830:134:3::10]:49472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ehxbG-0002WK-Fm
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 08:11:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ehxbB-0002T8-UV
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 08:11:22 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:40530)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ehxbB-0002Ss-QG
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 08:11:17 -0500
Received: by mail-qk0-f193.google.com with SMTP id d18so27377689qke.7
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 05:11:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1517582668-10923-4-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1517582668-10923-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1517582668-10923-4-git-send-email-stefanb@linux.vnet.ibm.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Sat, 3 Feb 2018 14:11:17 +0100
Message-ID: <CAMxuvaxakVpy_D3xsvcLgmO5d9ru7XFAzgww3+bsNGMJzC0PDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] MAINTAINERS: add pointer to tpm-next
 repository
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, marcandre <marcandre.lureau@redhat.com>

On Fri, Feb 2, 2018 at 3:44 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f8deaf6..d352d16 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1593,6 +1593,7 @@ F: include/hw/acpi/tpm.h
>  F: include/sysemu/tpm*
>  F: qapi/tpm.json
>  F: backends/tpm.c
> +T: git git://github.com/stefanberger/qemu-tpm.git tpm-next
>
>  Checkpatch
>  S: Odd Fixes
> --
> 2.5.5
>
