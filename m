Received: from eggs.gnu.org ([2001:4830:134:3::10]:38519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDAXj-0001H2-L6
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 11:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDAXf-0002FI-73
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 11:48:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDAXf-0002DP-06
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 11:48:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id 189-v6so781185wmw.2
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 08:48:54 -0700 (PDT)
References: <20181011161820.38794-1-liq3ea@163.com>
	<9df25d36-4150-29d4-8d68-3da5dfb89468@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fb96b9ed-e4a7-1ee0-58e1-7d40f2c14baa@redhat.com>
Date: Thu, 18 Oct 2018 17:48:51 +0200
MIME-Version: 1.0
In-Reply-To: <9df25d36-4150-29d4-8d68-3da5dfb89468@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Li Qiang <liq3ea@163.com>, mst@redhat.com
Cc: qemu-devel@nongnu.org

On 18/10/2018 15:41, Marcel Apfelbaum wrote:
> 
> 
> On 10/11/18 7:18 PM, Li Qiang wrote:
>> Seems the intel link is unavailable, change it to qemu site.
>>
>> Signed-off-by: Li Qiang <liq3ea@163.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>   hw/pci-host/piix.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
>> index 0e608347c1..56a42055f1 100644
>> --- a/hw/pci-host/piix.c
>> +++ b/hw/pci-host/piix.c
>> @@ -40,7 +40,7 @@
>>     /*
>>    * I440FX chipset data sheet.
>> - * http://download.intel.com/design/chipsets/datashts/29054901.pdf
>> + * https://wiki.qemu.org/File:29054901.pdf
>>    */
>>   
> 
> Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Perhaps the maintainer can add a space before your email.

> 
> Thanks,
> Marcel
> 
>>   #define I440FX_PCI_HOST_BRIDGE(obj) \
> 
