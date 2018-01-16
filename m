Received: from eggs.gnu.org ([2001:4830:134:3::10]:41681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ebSzG-0002j0-Rq
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ebSzF-0004pK-UZ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:17:18 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8uJpwwVSAMWY+rFm1+3YFdtuShAyz6PB4yNto_YOVCbg@mail.gmail.com>
References: <20180116013709.13830-1-andrew.smirnov@gmail.com>
	<CAFEAcA8uJpwwVSAMWY+rFm1+3YFdtuShAyz6PB4yNto_YOVCbg@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 16 Jan 2018 07:17:02 -0800
Message-ID: <CAHQ1cqFbjTgrW7VF9_7npSqqx4qHpbB7=DGjzJ2O5ySBknJhAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 00/14] Initial i.MX7 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Tue, Jan 16, 2018 at 7:08 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 16 January 2018 at 01:36, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>> Hi everyone,
>>
>> This v4 of the patch series containing the work that I've done in
>> order to enable support for i.MX7 emulation in QEMU.
>>
>> *NOTE*: Patches 1 and 2 are provided for the sake of completness and
>>         are going to have to be adapted once Philippe's SD changes
>>         land in master. As such, they are NOT ready to be
>>         accepted/merged.
>
> I've just pushed a pullreq including Philippe's SD changes to master,
> so you should be able to do the final versions of these i.MX SD patches
> now. I've also I think now reviewed everything except the pci patch,
> which is a bit out of my competence area.

That's great news! I'll rebase on top of that as soon as I get a chance.

Thanks,
Andrey Smirnov
