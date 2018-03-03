Received: from eggs.gnu.org ([2001:4830:134:3::10]:35357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1es5zF-00020h-Aj
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 07:10:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1es5zA-00024P-Jx
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 07:10:01 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:42512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1es5zA-00024C-CV
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 07:09:56 -0500
Received: by mail-wr0-x242.google.com with SMTP id k9so12612949wre.9
	for <qemu-devel@nongnu.org>; Sat, 03 Mar 2018 04:09:56 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180215220540.6556-1-f4bug@amsat.org>
	<20180215220540.6556-10-f4bug@amsat.org>
	<CAFEAcA8YipVxDHsKHYE=8kN+Nrsvs1Cp7OavYL2Am=6gozh_AA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <09d874b7-ad7d-06cd-7d04-ff57265cb2fd@amsat.org>
Date: Sat, 3 Mar 2018 09:09:50 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8YipVxDHsKHYE=8kN+Nrsvs1Cp7OavYL2Am=6gozh_AA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 09/11] sdcard: display protocol used
 when tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

On 02/22/2018 10:02 AM, Peter Maydell wrote:
> On 15 February 2018 at 22:05, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> put the function in sdmmc-common.c since we will reuse it in hw/sd/core.c
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Commit message talks about a function but the patch doesn't
> add any new functions ? (Also, sentences should start with

I suppose I mistaken the commit message when I rebased, this message
belongs to the previous commit.

> a capital letter and end with a full stop, please.)

Got it!

> Otherwise
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thanks!
