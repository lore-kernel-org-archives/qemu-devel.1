Received: from eggs.gnu.org ([2001:4830:134:3::10]:39158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dQXvV-0002KJ-I7
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dQXvR-0002kO-BE
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:48:01 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dQXvR-0002jx-4M
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:47:57 -0400
Received: by mail-wr0-x241.google.com with SMTP id z45so36673188wrb.2
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 04:47:55 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170629010300.2848-1-f4bug@amsat.org>
	<20170629010300.2848-4-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9230ab87-c1a0-52f8-d88f-9620c1986342@redhat.com>
Date: Thu, 29 Jun 2017 13:47:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170629010300.2848-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/8] MAINTAINERS: update Xen entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Stefan Weil <sw@weilnetz.de>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Anthony Xu <anthony.xu@intel.com>



On 29/06/2017 03:02, Philippe Mathieu-Daudé wrote:
> moved in 56e2cd24..28b99f47 to accel/

Actually to hw/.

I can certainly queue patches 1-4 immediately, thanks.

Paolo

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 86a08c5aac..530293044b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -323,7 +323,6 @@ M: Stefano Stabellini <sstabellini@kernel.org>
>  M: Anthony Perard <anthony.perard@citrix.com>
>  L: xen-devel@lists.xenproject.org
>  S: Supported
> -F: xen-*
>  F: */xen*
>  F: hw/9pfs/xen-9p-backend.c
>  F: hw/char/xen_console.c
> 
