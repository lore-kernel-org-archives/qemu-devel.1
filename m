Received: from eggs.gnu.org ([2001:4830:134:3::10]:60160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eHx1q-0000BX-Dc
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 14:19:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eHx1l-0008Tw-NX
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 14:19:18 -0500
Received: from chuckie.co.uk ([82.165.15.123]:41413
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eHx1l-0008Le-H4
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 14:19:13 -0500
References: <151133401227.552.8898320019907165144@bafd83ae6430>
	<c30676aa-73f1-bf73-b453-f93f153f3a77@tribudubois.net>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <f8f86d7e-da76-a96a-08fa-57da0350d263@ilande.co.uk>
Date: Thu, 23 Nov 2017 19:18:37 +0000
MIME-Version: 1.0
In-Reply-To: <c30676aa-73f1-bf73-b453-f93f153f3a77@tribudubois.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Remove MemoryRegionSection check code from
 sparc_cpu_get_phys_page_debug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe DUBOIS <jcd@tribudubois.net>, qemu-devel@nongnu.org
Cc: famz@redhat.com, atar4qemu@gmail.com

On 22/11/17 19:20, Jean-Christophe DUBOIS wrote:

> The reported error seems to be unrelated to the patch.
> 
> There seems to be an issue with the build infrastructure.
> 
> Looking at "history" in the mailing list this kind of (unrelated) issue
> seems to happen from time to time.
> 
> JC

Yes indeed, I agree that the failure is related to another patch and not
this one.


ATB,

Mark.
