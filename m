Received: from eggs.gnu.org ([2001:4830:134:3::10]:42631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fR2BE-0007TV-PH
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 17:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fR2BD-0006Ab-SV
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 17:10:48 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180607171751.11510-1-mark.cave-ayland@ilande.co.uk>
	<8484d1a4-b9e4-3d69-090c-22c230878566@amsat.org>
	<CAFEAcA_qc-x0rnDRyJaoiZyL=G2BU6HoiiKbzV=_phRMwHo4zA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4905eb15-ee9e-c2b0-419b-4e60babd4061@amsat.org>
Date: Thu, 7 Jun 2018 18:10:39 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_qc-x0rnDRyJaoiZyL=G2BU6HoiiKbzV=_phRMwHo4zA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/4] cuda/mos6522 migration fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On 06/07/2018 05:17 PM, Peter Maydell wrote:
> On 7 June 2018 at 20:18, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> You forgot patch 5 "vmstate: Remove VMSTATE_TIMER_PTR_TEST" :)
> 
> It's a generic macro that might have utility in future,
> and it fits into a slot in the matrix of possible VMSTATE
> macros, so I wouldn't bother. (It's kind of irritating that we
> have an almost but not quite orthogonal set of VMSTATE
> macros.)

OK!
