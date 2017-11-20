Received: from eggs.gnu.org ([2001:4830:134:3::10]:60421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eGunV-0005cI-31
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:44:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eGunR-0000N0-U3
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:44:13 -0500
Received: from chuckie.co.uk ([82.165.15.123]:44689
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eGunR-0000AC-O9
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:44:09 -0500
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1510926167-23326-15-git-send-email-mark.cave-ayland@ilande.co.uk>
	<f7bfe57e-c70f-8150-3289-50441c061f73@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <d62f51ba-c2ea-3233-c8b4-8025da24fa0d@ilande.co.uk>
Date: Mon, 20 Nov 2017 22:43:51 +0000
MIME-Version: 1.0
In-Reply-To: <f7bfe57e-c70f-8150-3289-50441c061f73@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 14/15] sparc64: introduce trace-events for
 hw/sparc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 19/11/17 15:14, Philippe Mathieu-Daudé wrote:

> Hi Mark,
> 
> On 11/17/2017 10:42 AM, Mark Cave-Ayland wrote:
>> This is in preparation for switching code in hw/sparc64 from DPRINTF over to
>> trace events.
> 
> This could be squashed with next commit,
> 
> Either way:
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Thanks for the review! I'd prefer to keep this separate as it touches an
area which is outside SPARC just in case anyone wants to handle this
separately.


ATB,

Mark.
