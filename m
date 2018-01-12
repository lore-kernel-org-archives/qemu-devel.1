Received: from eggs.gnu.org ([2001:4830:134:3::10]:35133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1eZtjO-0005fx-Lf
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 02:26:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1eZtjL-00081E-Hq
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 02:26:26 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:25550
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1eZtjL-00080e-6q
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 02:26:23 -0500
References: <20171214040855.22231-1-douly.fnst@cn.fujitsu.com>
	<20171218220901.GE5209@localhost.localdomain>
	<f5057cbf-c699-847a-d219-78a0ba6bff63@cn.fujitsu.com>
	<20171220213820.GF24025@localhost.localdomain>
	<20171222202434.2e749e99@igors-macbook-pro.local>
	<20171222213027-mutt-send-email-mst@kernel.org>
	<3d7e0c5a-9079-9975-6e5e-ec30accff191@cn.fujitsu.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <b9f0f7e1-d526-ff33-ed48-8564a4650408@cn.fujitsu.com>
Date: Fri, 12 Jan 2018 15:26:12 +0800
MIME-Version: 1.0
In-Reply-To: <3d7e0c5a-9079-9975-6e5e-ec30accff191@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RESEND PATCH for-2.12 0/2] ACPI/unit-test: Add a
 testcase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, peter.maydell@linaro.org, qemu-devel@nongnu.org, indou.takao@jp.fujitsu.com



At 01/12/2018 03:23 PM, Dou Liyang wrote:
> [...]
>>>>>
>>>>> BTW, I used "make TEST_ACPI_REBUILD_AML=1 check" to create the DSDT
>>>>> file. Is it correct?
>>>>
>>>> This sounds correct to me.  Igor, can you confirm?
>>> It's will rebuild/update reference tables.
>>>
>>> I'm for merging it early and tracking/fixing issue Peter saw during 
>>> this dev cycle.
>>>
>>>
>>
>> Send an ack then?
>>
> Hi Michael,
> 
> I saw Igor gave the Reviewed-by at 21 Dec 2017
                                      ^^ Oops! Sorry, it's 27 Dec.
> 
> What is the state of this patchset?
> 
> I rebase and retest it again, Do I need to send it again?
> 
> Thanks,
>      dou
>>
>>
