Received: from eggs.gnu.org ([2001:4830:134:3::10]:60673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHYC4-0007As-FI
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHYC0-0004C2-Ab
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:52:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHYBz-0004Au-Sz
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:52:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id i17-v6so13554519wre.7
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 10:52:39 -0700 (PDT)
References: <20181030174356.16915-1-palmer@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dc417db4-7add-0870-b6b7-6a3e4ae92305@redhat.com>
Date: Tue, 30 Oct 2018 18:52:36 +0100
MIME-Version: 1.0
In-Reply-To: <20181030174356.16915-1-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] Add qemu-riscv@nongnu.org as the RISC-V
 list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org, qemu-devel@nongnu.org

On 30/10/18 18:43, Palmer Dabbelt wrote:
> We now have a RISC-V specific QEMU development list.
> 
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d550fd8b809c..10983bd52d64 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -244,6 +244,7 @@ M: Palmer Dabbelt <palmer@sifive.com>
>   M: Alistair Francis <Alistair.Francis@wdc.com>
>   M: Sagar Karandikar <sagark@eecs.berkeley.edu>
>   M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> +L: qemu-riscv@nongnu.org
>   S: Maintained
>   F: target/riscv/
>   F: hw/riscv/
> 
