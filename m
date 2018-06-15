Received: from eggs.gnu.org ([2001:4830:134:3::10]:32948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fTr7h-0006Si-9M
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:58:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fTr7e-00038A-89
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:58:49 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:37900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fTr7e-00037R-1E
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:58:46 -0400
Received: by mail-pf0-x22e.google.com with SMTP id b74-v6so5073003pfl.5
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 08:58:45 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180611125633.32755-1-peter.maydell@linaro.org>
	<CAFEAcA88FD2pEM_GmPy6QtRVwd2f41Y9V84pvcpNtt_vu7LKeg@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e5002904-053b-c76f-aa22-2e106b403129@twiddle.net>
Date: Fri, 15 Jun 2018 05:58:40 -1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA88FD2pEM_GmPy6QtRVwd2f41Y9V84pvcpNtt_vu7LKeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] cputlb: document iotlb.addr,
 fix txfail physaddr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 06/15/2018 12:13 AM, Peter Maydell wrote:
>> Peter Maydell (2):
>>   cpu-defs.h: Document CPUIOTLBEntry 'addr' field
>>   cputlb: Pass cpu_transaction_failed() the correct physaddr
> 
> I'll put these in via target-arm.next (with the ramaddr_t/ram_addr_t
> typo fixed), unless anybody would prefer them to go via another route.

Perfect, thanks.


r~
