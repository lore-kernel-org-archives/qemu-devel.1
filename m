Received: from eggs.gnu.org ([2001:4830:134:3::10]:41094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4UlW-0005vA-6n
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4UlT-0004Y1-IN
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:30:50 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171017001209.32276-1-f4bug@amsat.org>
	<20171017001209.32276-3-f4bug@amsat.org>
	<50725210-1e77-a987-b9fc-6185597b5c57@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ff89ea97-0528-20d8-f6b2-595e015ec94e@amsat.org>
Date: Tue, 17 Oct 2017 13:30:43 -0300
MIME-Version: 1.0
In-Reply-To: <50725210-1e77-a987-b9fc-6185597b5c57@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 02/39] MAINTAINERS: add entries for
 dma/i82374
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>

On 10/17/2017 03:59 AM, Thomas Huth wrote:
> On 17.10.2017 02:11, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  MAINTAINERS | 2 ++
[...]
>>  sPAPR
>> @@ -854,6 +855,7 @@ F: hw/misc/pc-testdev.c
>>  F: hw/timer/hpet*
>>  F: hw/timer/i8254*
>>  F: hw/timer/mc146818rtc*
>> +F: include/hw/dma/i8257_dma.h
> 
> Does not match $subject. And the file does not exist yet (you just
> create it in patch 39). And I think you should CC: the corresponding
> maintainers so that they have a chance to say yes or no.

Oops... fair enough ;)
