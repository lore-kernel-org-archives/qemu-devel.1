Received: from eggs.gnu.org ([2001:4830:134:3::10]:45880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR3OI-0005Fh-Q9
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 18:00:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR3OE-0000Pp-Pk
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 18:00:38 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gR3OE-0000Ol-JK
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 18:00:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so11384133wrr.0
	for <qemu-devel@nongnu.org>; Sun, 25 Nov 2018 15:00:34 -0800 (PST)
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-7-philmd@redhat.com>
	<CAFEAcA_ujDFu_X0cm5gVppESYeZ4KfNwjJkVKrsCNRgBeeQ1OA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c29d16dc-5d6a-19d2-d024-8c5877e21f36@redhat.com>
Date: Mon, 26 Nov 2018 00:00:31 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ujDFu_X0cm5gVppESYeZ4KfNwjJkVKrsCNRgBeeQ1OA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 06/25] MAINTAINERS: Add a missing
 entry for the Xilinx S3A-DSP 1800 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 25/11/18 23:50, Peter Maydell wrote:
> On Sun, 25 Nov 2018 at 20:51, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 4e396cbe71..aa17e9bbd3 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -822,6 +822,7 @@ petalogix_s3adsp1800
>>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>>  S: Maintained
>>  F: hw/microblaze/petalogix_s3adsp1800_mmu.c
>> +include/hw/char/xilinx_uartlite.h
> 
> Missing the leading "F: " ?

Argh... If there is no need to respin, maybe the maintainer taking those
patches is willing to fix this mistake... :)

Thanks btw!

> 
>>  petalogix_ml605
>>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> 
> thanks
> -- PMM
> 
