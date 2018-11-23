Received: from eggs.gnu.org ([2001:4830:134:3::10]:57466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQ3nc-0008BI-KA
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 00:14:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQ3nX-0000Eh-OL
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 00:14:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gQ3nX-00008t-IP
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 00:14:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so11070136wrs.8
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 21:14:34 -0800 (PST)
References: <20181122230858.23345-1-jcmvbkbc@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <abbd337a-a083-f4b4-d9b3-3497db9bff93@redhat.com>
Date: Fri, 23 Nov 2018 06:14:32 +0100
MIME-Version: 1.0
In-Reply-To: <20181122230858.23345-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: add missing xtensa patterns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

On 23/11/18 0:08, Max Filippov wrote:
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1032406c5607..f4a7e453c06f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -311,6 +311,8 @@ F: target/xtensa/
>  F: hw/xtensa/
>  F: tests/tcg/xtensa/
>  F: disas/xtensa.c
> +F: include/hw/xtensa/xtensa-isa.h
> +F: default-configs/xtensa*.mak
>  
>  TriCore
>  M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> 
