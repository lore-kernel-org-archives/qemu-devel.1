Received: from eggs.gnu.org ([209.51.188.92]:59810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDUA-0001Ca-CI
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:39:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDU8-00005B-FB
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:39:14 -0500
References: <20190206202848.16999-1-eblake@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <bd64bbe7-68c3-146d-4a5d-04a3107c9efb@vivier.eu>
Date: Thu, 14 Feb 2019 10:38:38 +0100
MIME-Version: 1.0
In-Reply-To: <20190206202848.16999-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] qapi: Fix qcow2 encryption
 doc typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, berrange@redhat.com, armbru@redhat.com, mreitz@redhat.com

On 06/02/2019 21:28, Eric Blake wrote:
> Present since commit b25b387f (2.10).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qapi/block-core.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0f349d46033..ee1ab7a8a25 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2998,7 +2998,7 @@
> 
>  ##
>  # @BlockdevQcow2EncryptionFormat:
> -# @aes: AES-CBC with plain64 initialization venctors
> +# @aes: AES-CBC with plain64 initialization vectors
>  #
>  # Since: 2.10
>  ##
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
