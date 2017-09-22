Received: from eggs.gnu.org ([2001:4830:134:3::10]:47169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvSDl-0004Qc-Bp
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvSDk-00066H-L3
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:58:37 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922154014.29350-3-f4bug@amsat.org>
	<CAFEAcA8oovA56LwFtKoY1c-P93zxGoyH+vKAXF+hAK6r9bHxvg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6f5d2c42-21b0-6741-deb7-e154163fc0bb@amsat.org>
Date: Fri, 22 Sep 2017 14:58:24 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8oovA56LwFtKoY1c-P93zxGoyH+vKAXF+hAK6r9bHxvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Corey Minyard <minyard@acm.org>, Balaton Zoltan <balaton@eik.bme.hu>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 09/22/2017 01:07 PM, Peter Maydell wrote:
> On 22 September 2017 at 16:39, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> while here, add entries for ppc4xx_i2c in MAINTAINERS
>>
>> applied using ./scripts/clean-includes
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
> 
> This is doing two things at once and would ideally be
> two patches. Still,

OK I'll split "while here" patches.

> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thanks!
