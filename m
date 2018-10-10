Received: from eggs.gnu.org ([2001:4830:134:3::10]:49672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gALqg-0003QK-Bh
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 17:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gALqc-0003Iw-Or
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 17:16:54 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gALqc-0003Hy-HH
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 17:16:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id 63-v6so7286866wra.11
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 14:16:50 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180930214744.27580-1-f4bug@amsat.org>
	<20180930214744.27580-5-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8d33dbf2-56eb-efeb-fd40-a13bc124fa46@amsat.org>
Date: Wed, 10 Oct 2018 23:16:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180930214744.27580-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 4/4] MAINTAINERS: Voluntary to review
 hobbyist MIPS contributions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: qemu-devel@nongnu.org

Eric corrected s/Voluntary/Volunteer/ in the subject line.

On 9/30/18 11:47 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ce7c351afa..2708745bf7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -188,6 +188,7 @@ F: disas/microblaze.c
>  MIPS
>  M: Aurelien Jarno <aurelien@aurel32.net>
>  M: Aleksandar Markovic <amarkovic@wavecomp.com>
> +R: Philippe Mathieu-Daudé <f4bug@amsat.org>
>  S: Maintained
>  F: target/mips/
>  F: hw/mips/
> @@ -1948,6 +1949,7 @@ F: disas/i386.c
>  
>  MIPS target
>  M: Aurelien Jarno <aurelien@aurel32.net>
> +R: Philippe Mathieu-Daudé <f4bug@amsat.org>
>  S: Maintained
>  F: tcg/mips/
>  F: disas/mips.c
> 
