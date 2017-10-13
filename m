Received: from eggs.gnu.org ([2001:4830:134:3::10]:36032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e2vny-0007Y1-OC
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e2vnu-0003w1-Sc
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:58:54 -0400
References: <20171013085355.7563-1-famz@redhat.com>
	<20171013085355.7563-3-famz@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <00b58d8d-11d2-894a-6e87-f65585435a0b@redhat.com>
Date: Fri, 13 Oct 2017 10:58:45 +0200
MIME-Version: 1.0
In-Reply-To: <20171013085355.7563-3-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] MAINTAINERS: Fix Sun4v file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>

On 13.10.2017 10:53, Fam Zheng wrote:
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 18ddaf4070..3938ccbf8a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -778,7 +778,7 @@ F: pc-bios/openbios-sparc64
>  Sun4v
>  M: Artyom Tarasenko <atar4qemu@gmail.com>
>  S: Maintained
> -F: hw/sparc64/sun4v.c
> +F: hw/sparc64/niagara.c
>  F: hw/timer/sun4v-rtc.c
>  F: include/hw/timer/sun4v-rtc.h
>  
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
