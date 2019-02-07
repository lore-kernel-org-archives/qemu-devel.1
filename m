Received: from eggs.gnu.org ([209.51.188.92]:53595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1grrnC-0005fK-Sj
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 17:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1grrnB-0003YD-TO
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 17:05:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1grrnB-0003Xn-Mr
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 17:05:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id z5so1498494wmf.0
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 14:05:09 -0800 (PST)
References: <20190207181422.4907-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <208191a9-6229-bd07-0c1f-2be7d703787b@redhat.com>
Date: Thu, 7 Feb 2019 23:05:06 +0100
MIME-Version: 1.0
In-Reply-To: <20190207181422.4907-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Remove Peter Crosthwaite from
 various entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 2/7/19 7:14 PM, Peter Maydell wrote:
> Peter Crosthwaite hasn't had the bandwidth to do code review or
> other QEMU work for some time now -- remove his email address
> from MAINTAINERS file entries so we don't bombard him with
> patch emails.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Peter C asked me to remove him from MAINTAINERS for now,
> hence this patch.
> 
> Peter: Thanks for all your work in the past; if you ever
> find yourself doing QEMU work again in the future we'll
> be happy to welcome you back.

Thanks Peter!
I learned a lot looking at your patches.

> ---
>  MAINTAINERS | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9a76845581b..7e3b69b528a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -110,7 +110,6 @@ Guest CPU cores (TCG):
>  ----------------------
>  Overall
>  L: qemu-devel@nongnu.org
> -M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
>  M: Richard Henderson <rth@twiddle.net>
>  R: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
> @@ -1346,7 +1345,6 @@ F: tests/virtio-scsi-test.c
>  T: git https://github.com/bonzini/qemu.git scsi-next
>  
>  SSI
> -M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
>  M: Alistair Francis <alistair@alistair23.me>
>  S: Maintained
>  F: hw/ssi/*
> @@ -1357,7 +1355,6 @@ F: tests/m25p80-test.c
>  
>  Xilinx SPI
>  M: Alistair Francis <alistair@alistair23.me>
> -M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
>  S: Maintained
>  F: hw/ssi/xilinx_*
>  
> @@ -1767,7 +1764,6 @@ F: qom/cpu.c
>  F: include/qom/cpu.h
>  
>  Device Tree
> -M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
>  M: Alexander Graf <agraf@suse.de>
>  S: Maintained
>  F: device_tree.c
> 
