Received: from eggs.gnu.org ([2001:4830:134:3::10]:55240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dqIy5-0002fu-Mv
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dqIy0-0006DC-5L
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:05:09 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170830215523.25278-1-f4bug@amsat.org>
	<20170830215523.25278-13-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9244c59c-569c-60b0-24e3-42a06f28d707@amsat.org>
Date: Fri, 8 Sep 2017 10:04:50 -0300
MIME-Version: 1.0
In-Reply-To: <20170830215523.25278-13-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 12/17] MAINTAINERS: add missing megasas
 test entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hannes Reinecke <hare@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

ping?

On 08/30/2017 06:55 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fa74b7254b..20d65dca73 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1118,6 +1118,7 @@ L: qemu-block@nongnu.org
>   S: Supported
>   F: hw/scsi/megasas.c
>   F: hw/scsi/mfi.h
> +F: tests/megasas-test.c
>   
>   Network packet abstractions
>   M: Dmitry Fleytman <dmitry@daynix.com>
> 
