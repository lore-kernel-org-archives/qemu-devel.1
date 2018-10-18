Received: from eggs.gnu.org ([2001:4830:134:3::10]:49781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gD8Xk-0005IW-RP
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gD8Xh-00080G-Mm
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:40:52 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gD8Xh-0007zU-DU
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:40:49 -0400
Received: by mail-wr1-x444.google.com with SMTP id l6-v6so33345031wrt.1
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 06:40:49 -0700 (PDT)
References: <20181011161820.38794-1-liq3ea@163.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <9df25d36-4150-29d4-8d68-3da5dfb89468@gmail.com>
Date: Thu, 18 Oct 2018 16:41:43 +0300
MIME-Version: 1.0
In-Reply-To: <20181011161820.38794-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2] piix_pci: change the i440fx data sheet
 link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, mst@redhat.com
Cc: qemu-devel@nongnu.org, philmd@redhat.com



On 10/11/18 7:18 PM, Li Qiang wrote:
> Seems the intel link is unavailable, change it to qemu site.
>
> Signed-off-by: Li Qiang <liq3ea@163.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>   hw/pci-host/piix.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index 0e608347c1..56a42055f1 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -40,7 +40,7 @@
>   
>   /*
>    * I440FX chipset data sheet.
> - * http://download.intel.com/design/chipsets/datashts/29054901.pdf
> + * https://wiki.qemu.org/File:29054901.pdf
>    */
>   

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel

>   #define I440FX_PCI_HOST_BRIDGE(obj) \
