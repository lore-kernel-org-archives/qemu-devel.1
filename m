Received: from eggs.gnu.org ([2001:4830:134:3::10]:50248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1dvREF-0003Wr-Sk
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1dvREB-00073J-VF
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:55:03 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:38709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1dvREB-00072S-QD
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:54:59 -0400
Received: by mail-io0-x244.google.com with SMTP id e9so50823iod.5
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 09:54:58 -0700 (PDT)
Received: from [192.168.27.3] ([47.184.168.85])
	by smtp.gmail.com with ESMTPSA id o2sm424921oia.18.2017.09.22.09.54.55
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 22 Sep 2017 09:54:55 -0700 (PDT)
Reply-To: minyard@acm.org
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922154014.29350-3-f4bug@amsat.org>
	<CAFEAcA8oovA56LwFtKoY1c-P93zxGoyH+vKAXF+hAK6r9bHxvg@mail.gmail.com>
From: Corey Minyard <tcminyard@gmail.com>
Message-ID: <2cc24c36-6a4b-4291-00f1-6dbe07f1bf61@gmail.com>
Date: Fri, 22 Sep 2017 11:54:54 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8oovA56LwFtKoY1c-P93zxGoyH+vKAXF+hAK6r9bHxvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH 02/34] hw: remove "qemu/osdep.h" from
 header files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 09/22/2017 11:07 AM, Peter Maydell wrote:
> On 22 September 2017 at 16:39, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> while here, add entries for ppc4xx_i2c in MAINTAINERS
>>
>> applied using ./scripts/clean-includes
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
> This is doing two things at once and would ideally be
> two patches. Still,

I agree.

> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I applied this series and did some basic testing, so

Reviewed-by: Corey Minyard <cminyard@mvista.com>
Tested-by: Corey Minyard <cminyard@mvista.com>

> thanks
> -- PMM
>
