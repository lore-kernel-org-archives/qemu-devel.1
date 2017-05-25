Received: from eggs.gnu.org ([2001:4830:134:3::10]:34163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dDn22-0008Dd-7X
	for qemu-devel@nongnu.org; Thu, 25 May 2017 03:18:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dDn1y-0008Og-8N
	for qemu-devel@nongnu.org; Thu, 25 May 2017 03:18:02 -0400
Received: from chuckie.co.uk ([82.165.15.123]:44134
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dDn1y-0007vZ-0M
	for qemu-devel@nongnu.org; Thu, 25 May 2017 03:17:58 -0400
References: <20170429104937.31341-1-zxq_yx_007@163.com>
	<9bf6a5a4-e8d7-b3b3-029d-baad2e3b507e@amsat.org>
	<C2B7E73D-27BA-40BE-927B-EC047A4BF5BA@163.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <e928c836-9bb0-b4bb-7d2e-a7805253a54c@ilande.co.uk>
Date: Thu, 25 May 2017 08:17:27 +0100
MIME-Version: 1.0
In-Reply-To: <C2B7E73D-27BA-40BE-927B-EC047A4BF5BA@163.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/9] QOM'ify work for sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?6LW15bCP5by6?= <zxq_yx_007@163.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, peter.maydell@linaro.org, pbonzini@redhat.com, atar4qemu@gmail.com, david@gibson.dropbear.id.au

On 20/05/17 01:28, 赵小强 wrote:

> 在 2017年5月20日，08:09，Philippe Mathieu-Daudé <f4bug@amsat.org> 写道：
> 
>>>
>>> changes since v1:
>>> * rebased on the latest master
>>>
>>> xiaoqiang zhao (9):
>>>  hw/misc: QOM'ify eccmemctl.c
>>>  hw/dma: QOM'ify sparc32_dma.c
>>>  hw/dma: QOM'ify sun4m_iommu.c
>>>  hw/misc: QOM'ify slavio_misc.c
>>>  hw/timer: QOM'ify m48txx_sysbus (pass 1)
>>>  hw/timer: QOM'ify m48txx_sysbus (pass 2)
>>
>> I think you can squash those 2. Any particular reason you did pass 2 in another commit?
> 
> No，squash is ok.

Okay no further comments so I'll assume everyone else is happy. Can you
send your v3 patchset rebased onto master and I'll apply it to my queue
right away.


ATB,

Mark.
