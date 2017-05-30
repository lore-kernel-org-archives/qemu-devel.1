Received: from eggs.gnu.org ([2001:4830:134:3::10]:55079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dFjc7-0002gS-4N
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dFjc6-0006Zk-EM
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:03:19 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <CAFEAcA9mo3HgVxG3OGAcMQLa4iwsHKofQ8CA8mZik5J2fm6jgQ@mail.gmail.com>
References: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA9mo3HgVxG3OGAcMQLa4iwsHKofQ8CA8mZik5J2fm6jgQ@mail.gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 30 May 2017 09:02:45 -0700
Message-ID: <CAKmqyKOfvGUi74Kg9E28qKu=sJh0BvhBYSbTjgYWr317coRUAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 00/13] armv7m: Implement MPU
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Alistair Francis <alistair.francis@xilinx.com>

On Tue, May 30, 2017 at 7:05 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 25 April 2017 at 13:06, Peter Maydell <peter.maydell@linaro.org> wrote:
>> This patchset implements support for the MPU in our v7M cores.
>> Support is on the same level as that for the R profile MPU: it works,
>> but regions smaller than 1K in size are not supported. It likely
>> has some missing corner-case features.
>
>> I wanted to get this patchset out to the list before I go off
>> on my break; I will come back and follow up on review comments
>> when I get back in June.
>
> The patchset has had review for about half the patches, and
> no this-needs-fixing comments on the others, so I propose to
> put it into target-arm.next.
>
> Let me know if anybody would prefer me to hold off so they
> can review the remaining patches in the set (2, 3, 9, 11, 12, 13).

All good from me, I'm happy if it's just applied.

Thanks,
Alistair

>
> thanks
> -- PMM
>
