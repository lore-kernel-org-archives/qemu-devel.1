Received: from eggs.gnu.org ([2001:4830:134:3::10]:33690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1clafz-0007Yu-RR
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 07:26:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1clafw-0004Et-OT
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 07:26:43 -0500
References: <1488975205-26312-1-git-send-email-thuth@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <1ab2599d-2ef2-5a2e-85e2-44620f436488@redhat.com>
Date: Wed, 8 Mar 2017 13:26:36 +0100
MIME-Version: 1.0
In-Reply-To: <1488975205-26312-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] qemu-doc: Fix broken URLs
 of amnhltm.zip and dosidle210.zip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 08/03/2017 13:13, Thomas Huth wrote:
> There are some broken URLs in the qemu-doc which reference tools that
> are not available at their original location anymore. Fortunately, they
> have been mirrored to archive.org, so point to that location instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

> ---
>  qemu-doc.texi | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 794ab4a..50411bc 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -1878,8 +1878,8 @@ resolution modes which the Cirrus Logic BIOS does not support (i.e. >=
>  Windows 9x does not correctly use the CPU HLT
>  instruction. The result is that it takes host CPU cycles even when
>  idle. You can install the utility from
> -@url{http://www.user.cityline.ru/~maxamn/amnhltm.zip} to solve this
> -problem. Note that no such tool is needed for NT, 2000 or XP.
> +@url{http://web.archive.org/web/20060212132151/http://www.user.cityline.ru/~maxamn/amnhltm.zip}
> +to solve this problem. Note that no such tool is needed for NT, 2000 or XP.
>  
>  @subsubsection Windows 2000 disk full problem
>  
> @@ -1927,9 +1927,9 @@ vvfat block device ("-hdb fat:directory_which_holds_the_SP").
>  @subsubsection CPU usage reduction
>  
>  DOS does not correctly use the CPU HLT instruction. The result is that
> -it takes host CPU cycles even when idle. You can install the utility
> -from @url{http://www.vmware.com/software/dosidle210.zip} to solve this
> -problem.
> +it takes host CPU cycles even when idle. You can install the utility from
> +@url{http://web.archive.org/web/20051222085335/http://www.vmware.com/software/dosidle210.zip}
> +to solve this problem.
>  
>  @node QEMU System emulator for non PC targets
>  @chapter QEMU System emulator for non PC targets
> 
