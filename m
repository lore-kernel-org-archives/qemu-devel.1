Received: from eggs.gnu.org ([2001:4830:134:3::10]:47334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1duY0L-0005jI-Hw
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 01:57:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1duY0K-00033B-Nf
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 01:57:01 -0400
References: <1505851374-6408-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170920042907.GC5520@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <88f39fd3-0ecf-8c37-e159-684c845672fd@ilande.co.uk>
Date: Wed, 20 Sep 2017 06:56:37 +0100
MIME-Version: 1.0
In-Reply-To: <20170920042907.GC5520@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv2] macio: convert pmac_ide_ops from old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 20/09/17 05:29, David Gibson wrote:

> On Tue, Sep 19, 2017 at 09:02:54PM +0100, Mark Cave-Ayland wrote:
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> This didn't apply for me.  Can you rebase on top of ppc-for-2.11, please.

(goes and looks)

Okay looks like the issue is that you're missing "[PATCH 3/8]
ppc/ide/macio: Add missing registers" from your queue - I see you
replied with an applied to ppc-2.11 email so I bet this got dropped on
rebase somewhere.

Can you try again with that patch added and then let me know if it still
doesn't work?

ATB,

Mark.
