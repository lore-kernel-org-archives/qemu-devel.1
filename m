Received: from eggs.gnu.org ([2001:4830:134:3::10]:45378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cJeKa-0007HS-Rk
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 05:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cJeKW-0003S9-Cq
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 05:41:08 -0500
References: <1478833368-25917-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<585A2156.6000700@cn.fujitsu.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <de55d157-d5a3-e6a9-e079-b89cea3ed754@redhat.com>
Date: Wed, 21 Dec 2016 12:40:58 +0200
MIME-Version: 1.0
In-Reply-To: <585A2156.6000700@cn.fujitsu.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] pcie: fix typo in comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: mst@redhat.com

On 12/21/2016 08:29 AM, Cao jin wrote:
> ping
>

No need for an r-b for this patch ,Michael or the qemu-trivial maintainer will take that.

Thanks,
Marce;

> On 11/11/2016 11:02 AM, Cao jin wrote:
>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>> ---
>>  hw/pci/pcie.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
>> index 99cfb45..39b10b8 100644
>> --- a/hw/pci/pcie.c
>> +++ b/hw/pci/pcie.c
>> @@ -656,7 +656,7 @@ static void pcie_ext_cap_set_next(PCIDevice *dev, uint16_t pos, uint16_t next)
>>  }
>>
>>  /*
>> - * caller must supply valid (offset, size) * such that the range shouldn't
>> + * Caller must supply valid (offset, size) such that the range wouldn't
>>   * overlap with other capability or other registers.
>>   * This function doesn't check it.
>>   */
>>
>
