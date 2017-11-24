Received: from eggs.gnu.org ([2001:4830:134:3::10]:43421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eIFg7-0002Tg-Us
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:14:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eIFg7-0008VT-5m
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:14:07 -0500
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:33230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eIFg7-0008Uz-1h
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:14:07 -0500
Received: by mail-oi0-x231.google.com with SMTP id f135so15276432oib.0
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 07:14:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20a7f496-5f85-f3c9-646e-aab32bdfad0f@redhat.com>
References: <1511516626-21178-1-git-send-email-eric.auger@redhat.com>
	<CAFEAcA-Fjpg+KC4eUzupLFf7fAco2GDmZG8nWNqSARnn9vypxA@mail.gmail.com>
	<20a7f496-5f85-f3c9-646e-aab32bdfad0f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Nov 2017 15:13:46 +0000
Message-ID: <CAFEAcA_4GcxNkWzZ=P1znV9Vv+ssnUo0hO9dqUHaKqkWLP6naA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for 2.11] hw/arm/virt: Add 2.11 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jones <drjones@redhat.com>

On 24 November 2017 at 10:16, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Peter,
>
> On 24/11/17 11:11, Peter Maydell wrote:
>> On 24 November 2017 at 09:43, Eric Auger <eric.auger@redhat.com> wrote:
>>> Add virt-2.11 machine type.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>
>>> ---
>>
>> Argh, did we forget this again?
>
> Yes we did, please apologize for that.

Sorry :-)

I've now applied this to master.

-- PMM
