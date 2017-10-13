Received: from eggs.gnu.org ([2001:4830:134:3::10]:51866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e2v1C-00023T-0H
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:08:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e2v18-0008HK-0c
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:08:29 -0400
References: <20171013012455.10737-1-famz@redhat.com>
	<20171013012455.10737-3-famz@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7e611573-e25e-65cc-2222-f7d2429bf924@redhat.com>
Date: Fri, 13 Oct 2017 10:08:20 +0200
MIME-Version: 1.0
In-Reply-To: <20171013012455.10737-3-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] MAINTAINERS: Drop Sun4v nonexistent
 file
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

On 13.10.2017 03:24, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index da3c78df47..731c5c7ec2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -778,7 +778,6 @@ F: pc-bios/openbios-sparc64
>  Sun4v
>  M: Artyom Tarasenko <atar4qemu@gmail.com>
>  S: Maintained
> -F: hw/sparc64/sun4v.c

I guess you should rather replace that one with:

hw/sparc64/niagara.c

Artyom, is that right?

 Thomas
