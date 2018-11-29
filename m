Received: from eggs.gnu.org ([2001:4830:134:3::10]:41441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gSMsG-0001q8-TD
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:01:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gSMs5-0003mC-4B
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:01:00 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gSMs4-0003XQ-TF
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:00:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id k198so2348472wmd.3
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 06:00:46 -0800 (PST)
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-18-paul.durrant@citrix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a247dae0-a766-7f97-c16d-07a32572f35d@redhat.com>
Date: Thu, 29 Nov 2018 15:00:43 +0100
MIME-Version: 1.0
In-Reply-To: <20181121151211.15997-18-paul.durrant@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/18] MAINTAINERS: add myself as a Xen
 maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

On 21/11/18 16:12, Paul Durrant wrote:
> I have made many significant contributions to the Xen code in QEMU,
> particularly the recent patches introducing a new PV device framework.
> I intend to make further significant contributions, porting other PV back-
> ends to the new framework with the intent of eventually removing the
> legacy code. It therefore seems reasonable that I become a maintiner of

"a maintainer of"

> the Xen code.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5871f035c3..0b668dd205 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -382,6 +382,7 @@ Guest CPU Cores (Xen):
>  X86
>  M: Stefano Stabellini <sstabellini@kernel.org>
>  M: Anthony Perard <anthony.perard@citrix.com>
> +M: Paul Durrant <paul.durrant@citrix.com>
>  L: xen-devel@lists.xenproject.org
>  S: Supported
>  F: */xen*
> 
