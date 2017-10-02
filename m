Received: from eggs.gnu.org ([2001:4830:134:3::10]:39191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1G6-0003rQ-Jo
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1G3-0002Fj-DH
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:59:46 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1504815384-8490-1-git-send-email-stefanb@linux.vnet.ibm.com>
Date: Mon, 02 Oct 2017 15:59:39 +0200
In-Reply-To: <1504815384-8490-1-git-send-email-stefanb@linux.vnet.ibm.com>
	(Stefan Berger's message of "Thu, 7 Sep 2017 16:16:24 -0400")
Message-ID: <877ewdfy5w.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] Add myself as maintainer for TPM code
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org, f4bug@amsat.org
List-ID: <qemu-devel.nongnu.org>

Copying qemu-trivial.

Stefan Berger <stefanb@linux.vnet.ibm.com> writes:

> Also add backends/tpm.c to the list of files.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
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
