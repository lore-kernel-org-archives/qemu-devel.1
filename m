Received: from eggs.gnu.org ([2001:4830:134:3::10]:54116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1db8R5-0004ql-Rh
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:48:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1db8R5-00035n-2R
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:48:23 -0400
MIME-Version: 1.0
In-Reply-To: <d35b1732-e970-8f52-b09d-9b9e004be39f@redhat.com>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-4-f4bug@amsat.org>
	<d35b1732-e970-8f52-b09d-9b9e004be39f@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jul 2017 09:47:49 -0700
Message-ID: <CAKmqyKPxJwBJ9kh1r3pEzectwjEmDV3LqFRqQRSetN2-J+=tfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/47] MAINTAINERS: add missing STM32 entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Alistair Francis <alistair@alistair23.me>, QEMU Trivial <qemu-trivial@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Thu, Jul 27, 2017 at 11:58 PM, Thomas Huth <thuth@redhat.com> wrote:
> On 28.07.2017 07:35, Philippe Mathieu-Daud=C3=A9 wrote:
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 795f89f709..f10252c292 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -556,6 +556,7 @@ F: hw/char/stm32f2xx_usart.c
>>  F: hw/timer/stm32f2xx_timer.c
>>  F: hw/adc/*
>>  F: hw/ssi/stm32f2xx_spi.c
>> +F: include/hw/*/stm32*.h
>>
>>  Netduino 2
>>  M: Alistair Francis <alistair@alistair23.me>
>>
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
