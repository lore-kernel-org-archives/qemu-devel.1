Received: from eggs.gnu.org ([2001:4830:134:3::10]:55862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eIB2e-0000YD-VR
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:17:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eIB2b-000244-2v
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:17:04 -0500
References: <1511516626-21178-1-git-send-email-eric.auger@redhat.com>
	<CAFEAcA-Fjpg+KC4eUzupLFf7fAco2GDmZG8nWNqSARnn9vypxA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <20a7f496-5f85-f3c9-646e-aab32bdfad0f@redhat.com>
Date: Fri, 24 Nov 2017 11:16:53 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Fjpg+KC4eUzupLFf7fAco2GDmZG8nWNqSARnn9vypxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 2.11] hw/arm/virt: Add 2.11 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jones <drjones@redhat.com>

Hi Peter,

On 24/11/17 11:11, Peter Maydell wrote:
> On 24 November 2017 at 09:43, Eric Auger <eric.auger@redhat.com> wrote:
>> Add virt-2.11 machine type.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
> 
> Argh, did we forget this again?

Yes we did, please apologize for that.

 I think we should just
> make a rule that we have to bump all the versioned machine
> types when the dev tree reopens...

I can take this in charge in the future.

Thanks

Eric
I wonder if there's a
> way to catch this automatically?
> 
> thanks
> -- PMM
> 
