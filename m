Received: from eggs.gnu.org ([2001:4830:134:3::10]:50249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1eoASG-00075B-Nn
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:07:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1eoASD-0001hm-Fn
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:07:44 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:46938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1eoASD-0001hU-8b
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:07:41 -0500
References: <20180215042900.16078-1-f4bug@amsat.org>
	<20180215042900.16078-18-f4bug@amsat.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <5bbf3a23-7ec6-0092-fd31-b548f84bfdea@mail.uni-paderborn.de>
Date: Tue, 20 Feb 2018 17:04:52 +0100
MIME-Version: 1.0
In-Reply-To: <20180215042900.16078-18-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 17/30] hw/tricore: use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On 02/15/2018 05:28 AM, Philippe Mathieu-Daudé wrote:
> It ease code review, unit is explicit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/tricore/tricore_testboard.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Acked-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian
