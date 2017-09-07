Received: from eggs.gnu.org ([2001:4830:134:3::10]:53408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dq1s9-0007v0-JF
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dq1s4-000862-SI
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:49:53 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dq1s4-00085C-Og
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:49:48 -0400
Received: by mail-qt0-x241.google.com with SMTP id p55so339265qtc.2
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 11:49:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1504809698-30479-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <12a7fe74-27a7-18e2-afaf-6c0859b1b0bf@amsat.org>
Date: Thu, 7 Sep 2017 15:49:43 -0300
MIME-Version: 1.0
In-Reply-To: <1504809698-30479-1-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] Add myself as maintainer for TPM code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

Hi Stefan,

On 09/07/2017 03:41 PM, Stefan Berger wrote:
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index caf7e8a..1d5ea97 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1487,7 +1487,8 @@ F: docs/tracing.txt
>   T: git git://github.com/stefanha/qemu.git tracing
>   
>   TPM
> -S: Orphan
> +M: Stefan Berger <stefanb@linux.vnet.ibm.com>
> +S: Maintained

:)

>   F: tpm.c
>   F: hw/tpm/*
>   F: include/hw/acpi/tpm.h
> 

While here are you OK to add this file too?

F: backends/tpm.c

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Regards,

Phil.
