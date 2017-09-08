Received: from eggs.gnu.org ([2001:4830:134:3::10]:55139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dqIxp-0002WZ-EA
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dqIxl-0005xx-Fo
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:04:53 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dqIxl-0005xa-BF
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:04:49 -0400
Received: by mail-qt0-x243.google.com with SMTP id h21so1506798qth.4
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 06:04:49 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170830215523.25278-1-f4bug@amsat.org>
	<20170830215523.25278-7-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3cd1d667-e29a-d182-54ef-f8676ca3d81c@amsat.org>
Date: Fri, 8 Sep 2017 10:04:45 -0300
MIME-Version: 1.0
In-Reply-To: <20170830215523.25278-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 06/17] MAINTAINERS: add missing Guest
 Agent entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, Eric Blake <eblake@redhat.com>, Tomoki Sekiyama <tomoki.sekiyama.qu@hitachi.com>
Cc: qemu-devel@nongnu.org

ping?

Michael, you told me this looks OK on IRC, can I respin with your Acked-by?

On 08/30/2017 06:55 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   MAINTAINERS | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa185c1edd..f4e07173c8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1434,6 +1434,10 @@ QEMU Guest Agent
>   M: Michael Roth <mdroth@linux.vnet.ibm.com>
>   S: Maintained
>   F: qga/
> +F: qemu-ga.texi
> +F: scripts/qemu-guest-agent/

I'm not sure you want to maintain this one...

> +F: tests/test-qga.c
> +F: docs/interop/qemu-ga-ref.texi
>   T: git git://github.com/mdroth/qemu.git qga
>   
>   QOM
> 
