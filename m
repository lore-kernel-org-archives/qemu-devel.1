Received: from eggs.gnu.org ([209.51.188.92]:55608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1hIwyX-0008AO-AO
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1hIwyW-0005iw-Dr
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:04:49 -0400
References: <20190423102145.14812-1-f4bug@amsat.org>
	<20190423102145.14812-3-f4bug@amsat.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <aeea5139-ae69-e7d7-ea0e-7f7855f6ab24@mail.uni-paderborn.de>
Date: Tue, 23 Apr 2019 17:04:35 +0200
MIME-Version: 1.0
In-Reply-To: <20190423102145.14812-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH 2/2] target/tricore: Use tcg_gen_abs_tl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>


On 4/23/19 12:21 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   target/tricore/translate.c | 27 +++++----------------------
>   1 file changed, 5 insertions(+), 22 deletions(-)

Reviewed-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>

Cheers,

Bastian
