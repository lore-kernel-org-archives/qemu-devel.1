Received: from eggs.gnu.org ([2001:4830:134:3::10]:52323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e1uG1-00070N-NE
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e1uFv-0004Lg-St
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:07:37 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:4116
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e1uFv-0004I7-Gn
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:07:31 -0400
References: <20171005203638.19255-1-ehabkost@redhat.com>
	<CAFEAcA-jBzTXWNrRCB8GXm2FcZdT3pPFZiGT6O6Oc8qpfSK_jA@mail.gmail.com>
	<20171006152751.GR4015@localhost.localdomain>
	<CAFEAcA94pKm22fX1kCr72-SsM06Z2AMUZ65a7zJ_UPrarkBg1w@mail.gmail.com>
	<4479e30f-801d-0d8e-712d-06f2dd987528@cn.fujitsu.com>
	<20171010125231.GD4015@localhost.localdomain>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <a2d9228a-1ef5-c08c-21bf-a5b97f06fc73@cn.fujitsu.com>
Date: Tue, 10 Oct 2017 21:07:06 +0800
MIME-Version: 1.0
In-Reply-To: <20171010125231.GD4015@localhost.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/9] x86 and machine queue, 2017-10-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi Eduardo,

At 10/10/2017 08:52 PM, Eduardo Habkost wrote:
> This shouldn't happen if CONFIG_IASL is not defined.  Did you run
> configure again after removing iasl?

Oops, Yes, the result above is in CONFIG_IASL = iasl.  :-(
I have been aware of this problem.

I am waiting the result of the test with './configure --iasl="" '

Thanks,
	dou.
