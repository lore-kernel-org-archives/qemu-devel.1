Received: from eggs.gnu.org ([2001:4830:134:3::10]:46107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eqiaU-0005BV-U8
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:58:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eqiaQ-0005xJ-8Q
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:58:46 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:39820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eqiaP-0005wP-NJ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:58:41 -0500
Received: by mail-wm0-x244.google.com with SMTP id 191so25135514wmm.4
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 08:58:41 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <7bb690382e3370aa1c1e047a84e36603c787ec0e.1519749987.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8399dd57-0283-31e9-5bd9-dc3249e22763@amsat.org>
Date: Tue, 27 Feb 2018 13:58:39 -0300
MIME-Version: 1.0
In-Reply-To: <7bb690382e3370aa1c1e047a84e36603c787ec0e.1519749987.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] MAINTAINERS: Update my email address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com

On 02/27/2018 01:47 PM, Alistair Francis wrote:
> I am leaving Xilinx, so to avoid having an email address that bouunces

bounces

> update my maintainer address to point to my personal email address.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> 
>  MAINTAINERS | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a334a25e5d..a76044bee2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -556,7 +556,7 @@ F: hw/misc/arm_sysctl.c
>  
>  Xilinx Zynq
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> -M: Alistair Francis <alistair.francis@xilinx.com>
> +M: Alistair Francis <alistair@alistair23.me>
>  L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/*/xilinx_*
> @@ -566,7 +566,7 @@ F: include/hw/misc/zynq*
>  X: hw/ssi/xilinx_*
>  
>  Xilinx ZynqMP
> -M: Alistair Francis <alistair.francis@xilinx.com>
> +M: Alistair Francis <alistair@alistair23.me>
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>  L: qemu-arm@nongnu.org
>  S: Maintained
> @@ -1075,7 +1075,7 @@ T: git git://github.com/bonzini/qemu.git scsi-next
>  
>  SSI
>  M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> -M: Alistair Francis <alistair.francis@xilinx.com>
> +M: Alistair Francis <alistair@alistair23.me>
>  S: Maintained
>  F: hw/ssi/*
>  F: hw/block/m25p80.c
> @@ -1084,7 +1084,7 @@ X: hw/ssi/xilinx_*
>  F: tests/m25p80-test.c
>  
>  Xilinx SPI
> -M: Alistair Francis <alistair.francis@xilinx.com>
> +M: Alistair Francis <alistair@alistair23.me>
>  M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
>  S: Maintained
>  F: hw/ssi/xilinx_*
> @@ -1254,7 +1254,7 @@ S: Maintained
>  F: hw/net/eepro100.c
>  
>  Generic Loader
> -M: Alistair Francis <alistair.francis@xilinx.com>
> +M: Alistair Francis <alistair@alistair23.me>
>  S: Maintained
>  F: hw/core/generic-loader.c
>  F: include/hw/core/generic-loader.h
> @@ -1600,7 +1600,7 @@ F: tests/qmp-test.c
>  T: git git://repo.or.cz/qemu/armbru.git qapi-next
>  
>  Register API
> -M: Alistair Francis <alistair.francis@xilinx.com>
> +M: Alistair Francis <alistair@alistair23.me>
>  S: Maintained
>  F: hw/core/register.c
>  F: include/hw/register.h
> 
