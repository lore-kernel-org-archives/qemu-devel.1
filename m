Received: from eggs.gnu.org ([2001:4830:134:3::10]:36339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebKE1-0001yS-Ha
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 00:55:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebKDy-0003Ru-HT
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 00:55:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ebKDy-0003Re-Ax
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 00:55:54 -0500
References: <1516077852-7974-1-git-send-email-mst@redhat.com>
	<1516077852-7974-2-git-send-email-mst@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <47ce957a-460f-5f01-6859-cf89c49ec782@redhat.com>
Date: Tue, 16 Jan 2018 06:55:42 +0100
MIME-Version: 1.0
In-Reply-To: <1516077852-7974-2-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 01/33] MAINTAINERS: Add myself as maintainer
 to X86 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 16.01.2018 05:46, Michael S. Tsirkin wrote:
> From: Marcel Apfelbaum <marcel@redhat.com>
> 
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>

I think the second SoB rather be yours, Michael, instead of a second one
from Marcel.

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4770f10..753e799 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -852,6 +852,7 @@ X86 Machines
>  ------------
>  PC
>  M: Michael S. Tsirkin <mst@redhat.com>
> +M: Marcel Apfelbaum <marcel@redhat.com>
>  S: Supported
>  F: include/hw/i386/
>  F: hw/i386/
> 
